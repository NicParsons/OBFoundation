import Foundation

/* TODO
 - consider making errors conform to LocalizedError
 - consider grouping related errors into separate enumerations
 */
enum OBError: Error {
	case resourceNotFound(String)
case couldNotLoadFile(String)
	case couldNotDecodeJSON(String)

	// exchange rate API errors
	case clientErrorFromURLRequest(String)
	case noResponseFromServer
case unexpectedResponseFromServer(Int)
	case nonJSONMimeTypeResponse(String?)
	case noDataReturned
	case couldNotDecodeJSONFromAPI(String)
}

extension OBError: CustomStringConvertible {
	public var description: String {
		switch self {
		case let .resourceNotFound(file):
			return "Couldn't find \(file) in the app's bundle."
		case let .couldNotLoadFile(file):
			return "Couldn't load data from \(file)."
		case let .couldNotDecodeJSON(file):
			return "Couldn't decode \(file) as JSON. Check that it is validly formatted JSON with the expected property keys."

			// currency exchange API errors
		case let .clientErrorFromURLRequest(message):
			return "The client returned an error in response to the URL request. The error message was: \(message)."
		case .noResponseFromServer:
			return "The server did not return a valid HTTP response."
		case let .unexpectedResponseFromServer(status):
			return "The server returned an unexpected status code. The status code returned was \(status)."
		case let .nonJSONMimeTypeResponse(mimeType):
			return "Expected MIME type application/json but instead it was \(mimeType ?? "nil")."
		case .noDataReturned:
			return "The request did not return any data."
		case let .couldNotDecodeJSONFromAPI(errorDescription):
return "Unable to decode JSON data from API request. The error description was: \(errorDescription)"
		} // end switch
	} // end description
} // end extension

//  OBErrors.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 14/1/2022.
