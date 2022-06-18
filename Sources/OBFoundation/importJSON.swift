import Foundation

extension Bundle {
	func importJSON<Thing: Codable>(from fileName: String, withDateDecodingStrategy dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) throws -> Thing {
		let OB = OBLog()
		OB.log("About to decode JSON from \(fileName)")

		guard let url = self.url(forResource: fileName, withExtension: nil) else {
			let error = OBError.resourceNotFound(fileName)
			OB.error("\(error.description)")
			throw error
		}

		guard let data = try? Data(contentsOf: url) else {
			let error = OBError.couldNotLoadFile(fileName)
			OB.error("\(error.description)")
			throw error
		}

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = dateDecodingStrategy

		guard let decodedData = try? decoder.decode(Thing.self, from: data) else {
			let error = OBError.couldNotDecodeJSON(fileName)
			OB.error("\(error.description)")
			throw error
		}

		return decodedData
	} // end func
} // end extension

//  importJSON.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 14/1/2022.
