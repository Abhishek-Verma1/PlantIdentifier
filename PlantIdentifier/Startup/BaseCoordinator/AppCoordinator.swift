//
//  AppCoordinator.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/23/22.
//

import UIKit
import Foundation

final class AppCoordinator: Coordinator {
  
    var mainNavigationController: UINavigationController?
    var subCoordinator: [Coordinator]?
    private var appWindow: UIWindow?
    
    required init(window: UIWindow?) {
        appWindow = window
    }
    
    func start() {
        mainNavigationController = UINavigationController()
        let customCameraCoordinator = CustomCameraCoordinator(navigationController: mainNavigationController!)
        customCameraCoordinator.start()
        appWindow?.rootViewController = mainNavigationController
        appWindow?.makeKeyAndVisible()
    }
}


