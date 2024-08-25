import Foundation
import SwiftUI

extension View {
@ViewBuilder public func hideLabel(_ shouldHide: Bool) -> some View {
    if shouldHide {
        self.labelsHidden()
    } else {
        self
    }
}
}
