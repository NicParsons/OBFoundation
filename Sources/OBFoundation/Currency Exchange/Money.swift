import Foundation

public struct Money: Hashable, Equatable {
    public var amount: Decimal
    public var currency: Currency
    public var description: String {
		self.formatted()
    }

    public func formatted() -> String {
return amount.formatted(.currency(code: currency.rawValue))
    }
    
    public mutating func convert(from source: Money) {
		let OB = OBLog()
		OB.log("Converting \(source.description) from \(source.currency.rawValue) to \(currency.rawValue).")
        if source.currency == currency {
            self.amount = source.amount
        } else {
			let exchange = CurrencyExchange()
			let exchangeRate = exchange.rateToExchange(from: source.currency, to: currency)
			self.amount = source.amount * exchangeRate.price
                self.amount.roundTo(decimalPlaces: 2)
        } // end if currencies are different
		OB.log("The value after conversion is \(self.description).")
    } // func
    
    public static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && lhs.currency == rhs.currency
        }

	public init(amount: Decimal, currency: Currency) {
		amount = amount
		currency = currency
	} // init
} // Money struct

//  Money.swift
//  Created by Nicholas Parsons on 21/12/2021.
