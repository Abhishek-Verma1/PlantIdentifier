//
//  PlantUseCase.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/21/22.
//

import Foundation
import UIKit


protocol PlantIdentifiertUseCaseProtocol {
    func postPlantIdentify(image: UIImage,
                           onSuccess: @escaping(PlantIdentifier) -> (),
                           onFailure: @escaping(String) -> () )
}

final class PlantIdentifiertUseCase: PlantIdentifiertUseCaseProtocol {

    let repository: PlantRepositoryProtocol

    init(repository: PlantRepositoryProtocol) {
        self.repository = repository
    }

    func postPlantIdentify(image: UIImage, onSuccess: @escaping(PlantIdentifier) -> (), onFailure: @escaping(String) -> () ) {
        repository.postPlantIdentify(image: image) { (response) in
            switch response {
            case .success(let data):
                onSuccess(data.plant)
            case .failure(let error):
                onFailure(error.message)
            }
        }
    }

}
