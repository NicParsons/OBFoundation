import Foundation

public extension String {
	public func adding(_ string: String, withSeparator separator: String = ".", includingLeadingSeparator: Bool = false) -> String {
		var base = self
		if base != "" || includingLeadingSeparator { base.append(separator) }
		base.append(string)
		return base
	}

	public func adding(_ integer: Int, withSeparator separator: String = ".", includingLeadingSeparator: Bool = false) -> String {
		var base = self
		let string = String(integer)
		if base != "" || includingLeadingSeparator { base.append(separator) }
		base.append(string)
		return base
	}

	public init(fromInt integer: Int, minStringLength: Int = 2) {
		self.init(format: "%0\(minStringLength)d", integer)
	}
}
