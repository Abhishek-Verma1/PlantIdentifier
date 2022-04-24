//
//  PlantRepositoryProtocol.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/20/22.
//

import Foundation
import UIKit

protocol PlantRepositoryProtocol {
    func postPlantIdentify(image: UIImage, onCompletion: @escaping (Response) -> ())
}
