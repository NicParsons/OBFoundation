import Foundation

class YahooFinanceAPI {
	let scheme = "https"
	let host = "yfapi.net"
	let path = "/v6/finance/quote"
	private var username = "support@openbooks.app"
		private var apiKey = "kxiKTZk6iE5LqB9ityu7x7sX5ZRR5Hob5dquZyEl"
// var region: String = "AU"
	// var lang: String = "en"

	func urlToConvert(from source: Currency, to target: Currency) -> URL {
		/*
		 this is now depricated
		 I've refactored this into several component methods that should be used instead
		 */
// e.g. 'https://yfapi.net/v6/finance/quote?region=AU&lang=en&symbols=AUDUSD%3Dx'

		var components = URLComponents()
		components.scheme = scheme
		components.host = host
		components.path = path

		components.queryItems = [
			URLQueryItem(name: "symbols", value: "\(source.rawValue)\(target.rawValue)=x")
		]
		let url = components.url!
		return url
	} // func

	func urlComponents() -> URLComponents {
		var components = URLComponents()
		components.scheme = scheme
		components.host = host
		components.path = path
		return components
	}

	func urlQuery(for symbol: String) -> URL {
var components = urlComponents()
		components.queryItems = [
			URLQueryItem(name: "symbols", value: symbol)
		]
		let url = components.url!
		return url
	}

	func queryStringToConvert(from source: Currency, to target: Currency) -> String {
		return source.rawValue + target.rawValue + "=x"
	}

	func urlRequestToConvert(from source: Currency, to target: Currency) -> URLRequest {
		let query = queryStringToConvert(from: source, to: target)
		return urlRequest(forQuery: query)
	}

		func urlRequest(forQuery query: String) -> URLRequest {
		let url = urlQuery(for: query)
var request = URLRequest(url: url)
		request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
		return request
	} // func
} // class

struct YahooFinanceAPIResponse: Codable {
let quoteResponse: QuoteResponse

	struct QuoteResponse: Codable {
		let result: [ExchangeRate]
		let error: Data? // not sure what form this will take, it is usually null
	} // QuoteResponse
} // YahooFinanceAPIResponse

//  YahooFinanceAPI.swift
//  Created by Nicholas Parsons on 14/1/2022.
