//
//  ImagePreviewCoordinator.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/23/22.
//

import Foundation
import UIKit

final class ImagePreviewCoordinator: Coordinator {
    var mainNavigationController: UINavigationController?
    var subCoordinator: [Coordinator]?
    
    required init(navigationController: UINavigationController) {
        mainNavigationController = navigationController
    }
    
    func startWithController(data: PlantCellViewModel, image: UIImage) -> UIViewController? {
        if let imagePreviewViewController = self.initiatlizeViewController() as? ImagePreviewViewController {
            imagePreviewViewController.prepareView(data: data,
                                                   image: image)
            return imagePreviewViewController
        }
        return nil
    }
}

extension ImagePreviewCoordinator: StroryBoardInitialize {
    var storyboard: UIStoryboard.Storyboard {
        return .main
    }
    var storyboardID: String {
        return String(describing: ImagePreviewViewController.self)
    }
}
