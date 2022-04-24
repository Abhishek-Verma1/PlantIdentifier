//
//  PlantIdentifierError.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/21/22.
//

import Foundation

// MARK: - PlantNetError
public struct PlantIdentifierError: Codable, Error {
    public let statusCode: Int
    public let error, message: String
}
