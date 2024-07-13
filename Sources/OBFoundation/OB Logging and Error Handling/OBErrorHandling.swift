import Foundation
import SwiftUI

public class OBErrorHandling: ObservableObject {
	@Published public var errorNotification: OBErrorNotification?
	public var hasError: Binding<Bool> {
		return Binding<Bool>(get: {
			self.errorNotification != nil
		}, set: { newValue in
			if !newValue { self.errorNotification = nil }
		})
	}

	public func handle(_ error: Error) {
		OBLog().log(error)
errorNotification = OBErrorNotification(error)
	}

	public func handle(_ error: Error, withTitle title: String) {
		OBLog().log(error)
		errorNotification = OBErrorNotification(error, title: title)
	}

	public func handle(_ error: Error, withTitle title: String, message: String) {
		OBLog().log(error)
		errorNotification = OBErrorNotification(error, title: title, message: message)
	}

	public func dismiss() {
		errorNotification = nil
	}
}

//  OBErrorHandling.swift
//  Created by Nicholas Parsons on 7/4/2022.
