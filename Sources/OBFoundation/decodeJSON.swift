import Foundation

func decodeJSON<Thing: Codable>(from data: Data) throws -> Thing {
	let OB = OBLog()
	OB.log("Decoding JSON.")

	let decoder = JSONDecoder()
	// decoder.dateDecodingStrategy = .iso8601

	guard let decodedData = try? decoder.decode(Thing.self, from: data) else {
		let error = OBError.couldNotDecodeJSON("given data")
		OB.error("\(error.description)")
		throw error
	}

	return decodedData
} // end func

//  decodeJSON.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 14/1/2022.
