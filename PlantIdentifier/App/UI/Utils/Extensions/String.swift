//
//  String.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/24/22.
//

import UIKit

extension String {
    
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
    
}
