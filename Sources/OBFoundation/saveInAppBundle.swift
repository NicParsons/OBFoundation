import Foundation

extension Bundle {
	func save(_ data: Data, to fileName: String) throws {
		/*
		 this method is never going to work as the system will not let us write to the app's Bundle as that would invalidate the app's certificate
		 it's no longer used anywhere in the app but I've kept it here as I may want to modify it for some other purpose sometime
		 */
		let OB = OBLog()
		OB.log("About to write JSON to \(fileName)")

		// I should create the file if it doesn't already exist rather than using guard
		guard let url = self.url(forResource: fileName, withExtension: nil) else {
			let error = OBError.resourceNotFound(fileName)
			OB.error("\(error.description)")
			throw error
		}

		do {
			try data.write(to: url, options: [.atomic])
		} catch {
			OB.error("Error writing data to \(fileName) in the app's bundle. The error was: \(error.localizedDescription)")
			print(error)
		}
	} // end func
} // end extension

//  saveInAppBundle.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 16/1/2022.
