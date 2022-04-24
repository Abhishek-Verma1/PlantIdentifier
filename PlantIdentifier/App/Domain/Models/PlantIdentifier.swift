//
//  PlantIdentifier.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/21/22.
//

import Foundation

struct PlantIdentifier {
    let results: [PlantIdentifierResult]?
    let images: [String]?
    
    init(results: [PlantIdentifierResult]?,
         images: [String]?) {
        self.results = results
        self.images = images
    }
}
