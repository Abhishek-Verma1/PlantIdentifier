//
//  Double.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/24/22.
//

import Foundation

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
