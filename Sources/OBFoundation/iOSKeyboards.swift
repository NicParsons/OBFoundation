import Foundation
import SwiftUI

extension View {
	@ViewBuilder public func withNumberPad() -> some View {
		#if os(iOS)
		self.keyboardType(.numberPad)
		#endif
		#if os(macOS)
		self
		#endif
}

	@ViewBuilder public func withDecimalPad() -> some View {
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
	public func dismissKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
#endif
