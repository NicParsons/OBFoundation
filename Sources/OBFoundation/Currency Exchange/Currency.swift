import Foundation

public enum Currency: String, CaseIterable, Identifiable, Codable, Comparable {
	// Cannot currently support EUR as there is a weird bug that I've posted about in the forums.
    case AUD, CAD, GBP, IDR, NZD, USD
    public var id: String { self.rawValue }

	public static func <(lhs: Currency, rhs: Currency) -> Bool {
		return lhs.rawValue < rhs.rawValue
	}
} // Currency enum

//  Currency.swift
//  Created by Nicholas Parsons on 2/1/2022.
