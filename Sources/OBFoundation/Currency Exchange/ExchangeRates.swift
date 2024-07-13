import Foundation

typealias ExchangeRateDictionary = [String:ExchangeRate]

struct ExchangeRate: Codable {
	let shortName: String // e.g. "AUD/USD"
	var price: Decimal = 1.0
	var high: Decimal
	var low: Decimal
	var close: Decimal
	var open: Decimal
	var fiftyTwoWeekLow: Decimal
	var fiftyTwoWeekHigh: Decimal
	var fiftyDayAverage: Decimal
	var twoHundredDayAverage: Decimal
	var lastUpdated = Date()

	enum CodingKeys: String, CodingKey {
		case shortName, fiftyTwoWeekLow, fiftyTwoWeekHigh, fiftyDayAverage, twoHundredDayAverage
		case price = "regularMarketPrice"
		case high = "regularMarketDayHigh"
		case low = "regularMarketDayLow"
	case close = "regularMarketPreviousClose"
		case open = "regularMarketOpen"
	}

	enum PricePoint: Hashable {
case low, high, market
	}

	var from: Currency? {
		var code: String
	let index = shortName.firstIndex(of: "/")
	if let index = index {
		code = String(shortName[..<index])
	} else {
		code = shortName
	} // end if
			code = String(code.prefix(3))
return Currency(rawValue: code)
	} // var

		var to: Currency? {
			var code: String
			let index = shortName.firstIndex(of: "/")
			if let index = index {
				code = String(shortName[index...].dropFirst())
			} else {
				// something is seriously wrong
				code = String(shortName.suffix(3))
			} // end if
			// if code.count != 3 { something is seriously wrong }
			return Currency(rawValue: code)
		}

	var description: String {
		"1 \(from?.rawValue ?? "nil") = \(price) \(to?.rawValue ?? "nil")."
	}

	init(from source: Currency, to target: Currency, equals rate: Decimal) {
		shortName = source.rawValue + "/" + target.rawValue
		price = rate
		high = rate
		low = rate
		close = rate
		open = rate
		fiftyTwoWeekLow = rate
		fiftyTwoWeekHigh = rate
		fiftyDayAverage = rate
		twoHundredDayAverage = rate
		lastUpdated = Date.distantPast
	} // init

	init(from source: Currency, to target: Currency) {
		self.init(from: source, to: target, equals: 1.0)
	} // init
} // struct

//  ExchangeRates.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 2/1/2022.
