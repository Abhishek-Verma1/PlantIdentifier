//
//  Response.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/21/22.
//

import Foundation

enum Response {
    case success(PlantIdentifierDataModel)
    case failure(PlantIdentifierError)
}
