import Foundation

public extension Int {
	public func stringified(withMinStringLength: Int = 2) -> String {
		return String(format: "%0\(withMinStringLength)d", self)
	}
}
