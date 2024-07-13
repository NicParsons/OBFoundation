import Foundation

public func convert(_ amount: Decimal, from source: Currency, to target: Currency, using ratePreference: ExchangeRate.PricePoint = .market) -> Decimal {
	var result = Decimal()
	var rate = Decimal()
	let OB = OBLog()
	OB.log("Converting \(amount) \(source.rawValue) to \(target.rawValue).")
	if source == target {
		result = amount
	} else {
		let exchange = CurrencyExchange()
		let exchangeRate = exchange.rateToExchange(from: source, to: target)
		switch ratePreference {
		case .low:
			rate = exchangeRate.fiftyTwoWeekLow
		case .high:
			rate = exchangeRate.fiftyTwoWeekHigh
		default:
			rate = exchangeRate.price
		}
		OB.log("The rate is \(rate.description).")
			result = amount * rate
			result.roundTo(decimalPlaces: 2)
	} // end if currencies are different
	OB.log("The value after conversion is \(result) \(target.rawValue).")
	return result
} // func

//  ConvertCurrency.swift
//  Created by Nicholas Parsons on 14/1/2022.
