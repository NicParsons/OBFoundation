import Foundation

public enum Currency: String, CaseIterable, Identifiable, Codable {
	// Cannot currently support EUR as there is a weird bug that I've posted about in the forums.
    case AUD, CAD, GBP, IDR, NZD, USD
    public var id: String { self.rawValue }
} // Currency enum

//  Currency.swift
//  Created by Nicholas Parsons on 2/1/2022.
