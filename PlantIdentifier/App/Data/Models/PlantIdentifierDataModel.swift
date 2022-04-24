//
//  PlantIdentifierDataModel.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/21/22.
//

import Foundation

// MARK: - PlantIdentifierDataModel
public struct PlantIdentifierDataModel: Codable {
    let query: Query
    let language, preferedReferential, bestMatch: String
    public let results: [PlantIdentifierResult]
    let version: String
    let remainingIdentificationRequests: Int
}

// MARK: - Query
struct Query: Codable {
    let project: String
    let images, organs: [String]
    let includeRelatedImages: Bool
}

// MARK: - Result
public struct PlantIdentifierResult: Codable {
    public let score: Double
    public let species: Species
    let gbif: Gbif?
}

// MARK: - Gbif
struct Gbif: Codable {
    let id: String
}

// MARK: - Species
public struct Species: Codable {
    public let scientificNameWithoutAuthor, scientificNameAuthorship: String
    public let genus, family: Family
    public let commonNames: [String]
    public let scientificName: String
}

// MARK: - Family
public struct Family: Codable {
    public let scientificNameWithoutAuthor, scientificNameAuthorship, scientificName: String
}


extension PlantIdentifierDataModel {
    var plant: PlantIdentifier {
        PlantIdentifier(results: results, images: query.images)
    }
}


