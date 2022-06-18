import Foundation
import SwiftUI

class OBErrorHandling: ObservableObject {
	@Published var errorNotification: OBErrorNotification?
	var hasError: Binding<Bool> {
		return Binding<Bool>(get: {
			self.errorNotification != nil
		}, set: { newValue in
			if !newValue { self.errorNotification = nil }
		})
	}

	func handle(_ error: Error) {
		OBLog().log(error)
errorNotification = OBErrorNotification(error)
	}

	func handle(_ error: Error, withTitle title: String) {
		OBLog().log(error)
		errorNotification = OBErrorNotification(error, title: title)
	}

	func handle(_ error: Error, withTitle title: String, message: String) {
		OBLog().log(error)
		errorNotification = OBErrorNotification(error, title: title, message: message)
	}

	func dismiss() {
		errorNotification = nil
	}
}

//  OBErrorHandling.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 7/4/2022.
