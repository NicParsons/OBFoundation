import Foundation

extension Decimal {
    mutating func roundTo(decimalPlaces scale: Int, rounding roundingMode: NSDecimalNumber.RoundingMode = .plain) {
        let OB = OBLog()
        OB.debug("Rounding \(self) to \(scale) decimal places.")
        var localCopy = self
        NSDecimalRound(&self, &localCopy, scale, roundingMode)
        OB.debug("The number is now \(self).")
    }

    func roundedTo(decimalPlaces scale: Int, rounding roundingMode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
        let OB = OBLog()
        OB.debug("Rounding \(self) to \(scale) decimal places.")
        var result = Decimal()
        var localCopy = self
        NSDecimalRound(&result, &localCopy, scale, roundingMode)
        OB.debug("The result is \(result).")
        return result
    }

    var intValue: Int? {
        return Int(self.roundedTo(decimalPlaces: 0).description)
    }

    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}

//  Decimal.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 3/1/2022.
