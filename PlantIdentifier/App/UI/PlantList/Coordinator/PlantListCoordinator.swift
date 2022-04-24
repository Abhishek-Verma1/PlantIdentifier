//
//  PlantListCoordinator.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/21/22.
//

import UIKit

protocol ResultScreenCoordinatorDelegate: AnyObject {
    func openImagePreviewer(data: PlantCellViewModel,
                            currentImage: UIImage) -> UIViewController?
    func moveToPreviousScreen()
}

final class PlantListCoordinator: Coordinator {
    var mainNavigationController: UINavigationController?
    var subCoordinator: [Coordinator]?
    private var image: UIImage!
    
    required init(navigationController: UINavigationController,
                  selectedImage: UIImage) {
        mainNavigationController = navigationController
        image = selectedImage
    }
    
    func makePlantUseCase() -> PlantIdentifiertUseCaseProtocol { PlantIdentifiertUseCase(repository: repository) }
    
    func makePlantListViewModel() -> PlantListViewModel {
        PlantListViewModel(image: image, useCase: makePlantUseCase(), delegate: self)
    }
    
    lazy var repository: PlantRepositoryProtocol = PlantIdentifierDataStore()
    
    func start() {
        if let resultScreenViewController = self.initiatlizeViewController() as? PlantListViewController {
            resultScreenViewController.viewModel =  makePlantListViewModel()
            self.mainNavigationController?.pushViewController(resultScreenViewController, animated: true)
        }
    }
}

extension PlantListCoordinator: StroryBoardInitialize {
    var storyboard: UIStoryboard.Storyboard {
        return .main
    }
    var storyboardID: String {
        return String(describing: PlantListViewController.self)
    }
}

extension PlantListCoordinator: ResultScreenCoordinatorDelegate {
    func getImage() -> UIImage {
        return image
    }
    
    func openImagePreviewer(data: PlantCellViewModel,
                            currentImage: UIImage) -> UIViewController? {
        let coordinator = ImagePreviewCoordinator(navigationController: mainNavigationController!)
        let viewcontroller = coordinator.startWithController(data: data,
                                                             image: currentImage)
        return viewcontroller
    }
    
    func moveToPreviousScreen() {
        removeViewController(with: .push)
    }
}
