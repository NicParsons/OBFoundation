import Foundation
import SwiftUI
import Combine

class UserPreferences: ObservableObject {
	@AppStorage("exchangeRates") var exchangeRateData: Data = Data()
	@AppStorage("exchangeRatesLastUpdated") var exchangeRatesLastUpdated: String = ""
} // class

//  UserPreferences.swift
//  Created by Nicholas Parsons on 2/1/2022.
