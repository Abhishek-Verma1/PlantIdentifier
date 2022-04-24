//
//  CustomCameraCoordinator.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/23/22.
//

import Foundation
import UIKit

protocol CommonCoordinatorDelegate: AnyObject {
    func moveToResultScreen(_ image: UIImage)
    func openPhoneSetting(url: URL)
}

final class CustomCameraCoordinator: Coordinator {
    var mainNavigationController: UINavigationController?
    var subCoordinator: [Coordinator]?
    
    required init(navigationController: UINavigationController) {
        mainNavigationController = navigationController
    }
    
    func start() {
        if let customCameraViewController = self.initiatlizeViewController() as? CustomCameraViewController {
            customCameraViewController.prepareViewModel(vm: CustomCameraVM(coordinatorDelegate: self))
            navigate(to: customCameraViewController,
                     with: .push,
                     coordinator: self)
        }
    }
}

extension CustomCameraCoordinator: CommonCoordinatorDelegate {
    func openPhoneSetting(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, completionHandler: {(success) in
                print("Success")
            })
        }
    }
    
    func moveToResultScreen(_ image: UIImage) {
        let coordinator = PlantListCoordinator(navigationController: mainNavigationController!, selectedImage: image)
        coordinator.start()
    }
}

extension CustomCameraCoordinator: StroryBoardInitialize {
    var storyboard: UIStoryboard.Storyboard {
        return .main
    }
    var storyboardID: String {
        return String(describing: CustomCameraViewController.self)
    }
}

