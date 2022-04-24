//
//  PlantListViewModel.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/21/22.
//

import Foundation
import UIKit

protocol PlantListViewModelInput {
    func viewDidLoad()
    func didTapOnRow(at index: Int)
    func celViewModel(at index: Int) -> PlantCellViewModel
}

protocol PlantListViewModelOutput {
    var totalRows: Int { get }
    var title: String { get }
    var loader: Observable<Bool> { get }
    var reload: Observable<Void> { get }
    var error: Observable<String> { get }
    var delegate: ResultScreenCoordinatorDelegate? { get set }
    var selectedImage: UIImage { get set }
}

protocol PlantListViewModelProtocol: PlantListViewModelInput, PlantListViewModelOutput { }

final class PlantListViewModel: PlantListViewModelProtocol {
    var delegate: ResultScreenCoordinatorDelegate?
    
    var loader: Observable<Bool> = Observable(false)
    var reload: Observable<Void> = Observable(())
    var error: Observable<String> = Observable("")
    
    var totalRows: Int { plants.results?.count ?? 0 }
    var title: String { "Results".localized() }
    
    #warning("This is a bad way and needs to be replaced later.")
    private var plants = PlantIdentifier(results: nil, images: nil) { didSet { reload.value = () } }
    
    private let useCase: PlantIdentifiertUseCaseProtocol
    
     var selectedImage = UIImage()
    
    init(image: UIImage, useCase: PlantIdentifiertUseCaseProtocol, delegate: ResultScreenCoordinatorDelegate) {
        self.useCase = useCase
        self.selectedImage = image
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        loader.value = true
        #warning("Optimization required for support multiple images.")
        useCase.postPlantIdentify(image: self.selectedImage , onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func didTapOnRow(at index: Int) {
    }
    
    func celViewModel(at index: Int) -> PlantCellViewModel {
        let plant = plants
        let imageURL = plant.images?.first
        let score = plant.results?[index].score
        let species = plant.results?[index].species
        let title = species?.scientificNameWithoutAuthor
        let subTitle = species?.commonNames.joined(separator: ",") ?? species?.scientificName
        
        return PlantCellViewModel(imageUrl: imageURL, title: title, subTitle: subTitle, score: score, image: selectedImage)
    }
    
    private func onSuccess(data: PlantIdentifier) {
        loader.value = false
        plants = data
    }
    
    private func onFailure(errorMessage: String) {
        loader.value = false
        error.value = errorMessage
    }
    
    func getFooterTitle() -> String { return "We didn’t find your plant?".localized() }
    func getFooterDescriptionTitle() -> String { return "Retake the photo or send us the picture so that we can help you find it.".localized() }
    func getRetakeTitle() -> String { return "Retake Photo" .localized()}
}



