import Foundation
import SwiftUI

extension View {
	@ViewBuilder func withNumberPad() -> some View {
		#if os(iOS)
		self.keyboardType(.numberPad)
		#endif
		#if os(macOS)
		self
		#endif
}

	@ViewBuilder func withDecimalPad() -> some View {
		#if os(iOS)
		self.keyboardType(.decimalPad)
		#endif
		#if os(macOS)
		self
		#endif
}
}

#if canImport(UIKit)
extension View {
	func dismissKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
#endif

//  iOSKeyboards.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 13/1/2022.
