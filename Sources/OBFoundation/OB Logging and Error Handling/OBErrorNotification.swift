import Foundation

public struct OBErrorNotification: Identifiable {
public var id = UUID()
	public var error: Error
	public var title: String
	public var message: String?
	public var details: String
	// consider var recommendation: String?
	// consider var dismissAction: (() -> Void)

	public var body: String {
		if let userFriendlyExplanation = message {
			return userFriendlyExplanation + "\n\nTechnical Details:\n\(details)"
		} else {
return details
		}
	}

	public init(_ error: Error, title: String, message: String) {
id = UUID()
		self.error = error
		self.title = title
		self.message = message
		details = error.localizedDescription
	}

	public init(_ error: Error, title: String) {
id = UUID()
		self.error = error
		self.title = title
		details = error.localizedDescription
	}

	public init(_ error: Error) {
id = UUID()
		self.error = error
		title = "Oops, something went wrong 🙃"
		details = error.localizedDescription
	}
}

//  OBErrorNotification.swift
//  Created by Nicholas Parsons on 6/4/2022.
