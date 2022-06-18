import Foundation
import SwiftUI

//FIXME: haven't actually gotten this to work yet

extension View {
	@ViewBuilder func withOBErrorHandling() -> some View {
		let errorHandling = OBErrorHandling()
		self.alert(
			Text(errorHandling.hasError.wrappedValue ? errorHandling.errorNotification!.title : "Unknown Error"),
				isPresented: errorHandling.hasError) {
				Button("Got it") {
					errorHandling.dismiss()
				} // button closure
			} message: {
				if let notification = errorHandling.errorNotification {
				Text(notification.body)
				} else {
Text("Unknown error.")
				} // end if
			} // alert message closure
	} // view builder
} // view extension

/* alternative possibility
struct HandleErrorsByShowingAlertViewModifier: ViewModifier {
	@StateObject var errorHandling = OBErrorHandling()

	func body(content: Content) -> some View {
		content
			.environmentObject(errorHandling)
			// Applying the alert for error handling using a background element
			// is a workaround, if the alert would be applied directly,
			// other .alert modifiers inside of content would not work anymore
			.background(
				EmptyView()
					.alert(
						Text(errorHandling.errorIsPresent ? errorHandling.currentError!.title : "Unknown Error"),
					isPresented: $errorHandling.errorIsPresent) {
						Button("Got it") {
							errorHandling.dismiss()
						} // button closure
					} message: {
						if let notification = errorHandling.currentError {
						Text(notification.body)
						} else {
Text("Unknown error.")
						} // end if
					} // alert message closure
				/*
					.alert(item: $errorHandling.currentError) { currentAlert in
						Alert(
							title: Text(currentAlert.title),
							message: Text(currentAlert.message),
							dismissButton: .default(Text("Got it")) {
								// currentAlert.dismissAction?()
								errorHandling.dismiss()
							}
						) // Alert view
					} // alert modifier
				*/
			) // bakcground
	} // func
} // struct

extension View {
	func withErrorHandling() -> some View {
		modifier(HandleErrorsByShowingAlertViewModifier())
	}
}
*/

//  withOBErrorAlert.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 6/4/2022.
