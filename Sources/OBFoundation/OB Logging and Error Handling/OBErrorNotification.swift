import Foundation

struct OBErrorNotification: Identifiable {
var id = UUID()
	var error: Error
	var title: String
	var message: String?
	var details: String
	// consider var recommendation: String?
	// consider var dismissAction: (() -> Void)

	var body: String {
		if let userFriendlyExplanation = message {
			return userFriendlyExplanation + "\n\nTechnical Details:\n\(details)"
		} else {
return details
		}
	}

	init(_ error: Error, title: String, message: String) {
id = UUID()
		self.error = error
		self.title = title
		self.message = message
		details = error.localizedDescription
	}

	init(_ error: Error, title: String) {
id = UUID()
		self.error = error
		self.title = title
		details = error.localizedDescription
	}

	init(_ error: Error) {
id = UUID()
		self.error = error
		title = "Oops, something went wrong 🙃"
		details = error.localizedDescription
	}
}

//  OBErrorNotification.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 6/4/2022.
