import Foundation

public class CurrencyExchange: ObservableObject {
	let OB = OBLog()
	public var exchangeRates: ExchangeRateDictionary = [:]

	private func add(_ exchangeRate: ExchangeRate) {
		OB.log("Adding exchange rate for \(exchangeRate.shortName).")
		guard let _ = exchangeRate.from,
				let _ = exchangeRate.to else {
			OB.log("The exchange rate did not appear to be valid and so was not added.")
			return
		}
			exchangeRates[exchangeRate.shortName] = exchangeRate
				OB.log("Exchange rate added.")
		save()
	} // func

	private func addPlaceholderExchangeRate(for source: Currency, to target: Currency) {
		OB.log("Adding an exchange rate to convert from \(source.rawValue) to \(target.rawValue).")
		let key = source.rawValue + "/" + target.rawValue
		if exchangeRates[key] != nil {
				OB.log("An exchange rate already existed to convert from \(source.rawValue) to \(target.rawValue).")
			} else {
// we need to add it
				exchangeRates[key] = ExchangeRate(from: source, to: target)
				OB.log("Exchange rate added.")
			}
	} // func

	public func rateToExchange(from source: Currency, to target: Currency) -> ExchangeRate {
		OB.log("Checking local storage for an exchange rate to convert \(source.rawValue) to \(target.rawValue).")
		var rate: ExchangeRate
		let key = source.rawValue + "/" + target.rawValue

		rate = exchangeRates[key] ?? ExchangeRate(from: source, to: target)

		if rate.lastUpdated.timeIntervalSinceNow < 60 * 60 * 24 * -1 {
			OB.log("Exchange rate might be out of date. Will try to request new exchange rate from server.")
			fetchExchangeRateToConvert(from: source, to: target)
			// The following line is probably superfluous as the fetchExchangeRate method calls an asynchronous function and does not return a value
			// So the exchangeRates dictionary will rarely if ever be updated by the time the following line executes
			// If we can find a way to change that, we should
			rate = exchangeRates[key] ?? ExchangeRate(from: source, to: target)
		}

		return rate
	} // func

public func fetchExchangeRateToConvert(from source: Currency, to target: Currency) {
let yahoo = YahooFinanceAPI()
	let urlRequest = yahoo.urlRequestToConvert(from: source, to: target)
	requestExchangeRate(from: urlRequest)
}

	public func updateExchangeRates() {
		OB.log("Checking to see if exchange rates need updating.")
	let preferences = UserPreferences()
		let dateFormatter = ISO8601DateFormatter()
		let lastUpdated: Date = dateFormatter.date(from: preferences.exchangeRatesLastUpdated) ?? Date.distantPast
		if lastUpdated.timeIntervalSinceNow < 24 * 60 * 60 * -1 {
			updateAllExchangeRates()
		} else {
			OB.log("Exchange rates were last updated on \(preferences.exchangeRatesLastUpdated).")
		}
	}

	public func updateAllExchangeRates() {
	var string: String
	for source in Currency.allCases {
	string = ""
	// assumes that there are no more than 10 currencies
	// because API free plan allows max 10 symbols per request
	for target in Currency.allCases {
		if source != target { string += source.rawValue + target.rawValue + "=x," }
	}
	// remove the traling comma
		string.removeLast()
	// get the URL based on string, and make the API request
let yahoo = YahooFinanceAPI()
		let urlRequest = yahoo.urlRequest(forQuery: string)
		requestExchangeRate(from: urlRequest)
	}
		// update the exchangeRatesLastUpdated property of UserPreferences
		let formatter = ISO8601DateFormatter()
		let today = formatter.string(from: Date())
		UserPreferences().exchangeRatesLastUpdated = today
		OB.log("Finished updating all exchange rates.")
	} // func

	public func requestExchangeRate(from urlRequest: URLRequest) {
	OB.log("Fetching data from \(urlRequest.url!.absoluteString).")
let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
	// check and handle errors
	if let error = error {
		let customError = OBError.clientErrorFromURLRequest(error.localizedDescription)
		self.OB.error(customError)
		return // nothing
	}

	guard let httpResponse = response as? HTTPURLResponse else {
		let customError = OBError.noResponseFromServer
		self.OB.error(customError)
		return // nothing
	}

			guard httpResponse.statusCode == 200 else {
				let customError = OBError.unexpectedResponseFromServer(httpResponse.statusCode)
				self.OB.error(customError)
		return // nothing
	}

	guard httpResponse.mimeType == "application/json" else {
		let customError = OBError.nonJSONMimeTypeResponse(httpResponse.mimeType)
		self.OB.error(customError)
		return // nothing
	}

	guard let data = data else {
		let customError = OBError.noDataReturned
		self.OB.error(customError)
		return // nothing
	}

	self.OB.log("JSON data received. About to decode.")

	let decoder = JSONDecoder()
	do {
		let response = try decoder.decode(YahooFinanceAPIResponse.self, from: data)
		self.OB.log("JSON data decoded.")
		for rate in response.quoteResponse.result {
			self.add(rate)
		}
	} catch {
		let customError = OBError.couldNotDecodeJSONFromAPI(error.localizedDescription)
		self.OB.error(customError)
	} // do try catch
} // end completion handler

task.resume()
} // func

	private var fileName = "exchangeRates.json"

	public func save() {
		var jsonData: Data
		OB.log("Encoding exchange rates to JSON to save to disk.")
let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		encoder.dateEncodingStrategy = .iso8601
		do {
			jsonData = try encoder.encode(exchangeRates)
								  } catch {
			OB.error("Error encoding exchange rates to JSON. The error was: \(error.localizedDescription)")
			print(error)
			return
		}

		DispatchQueue.main.async {
			UserPreferences().exchangeRateData = jsonData
		}

		OB.log("Exchange rate data saved to AppStorage.")
	}

	public init() {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		let data = UserPreferences().exchangeRateData
		do {
			exchangeRates = try decoder.decode(ExchangeRateDictionary.self, from: data)
		} catch {
			exchangeRates = [:]
		}
	}
} // class

//  CurrencyExchange.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 14/1/2022.
