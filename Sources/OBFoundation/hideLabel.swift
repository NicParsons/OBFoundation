import Foundation
import SwiftUI

extension View {
@ViewBuilder func hideLabel(_ shouldHide: Bool) -> some View {
    if shouldHide {
        self.labelsHidden()
    } else {
        self
    }
}
}

//  hideLabel.swift
//  TributeCalculator
//  Created by Nicholas Parsons on 3/1/2022.
