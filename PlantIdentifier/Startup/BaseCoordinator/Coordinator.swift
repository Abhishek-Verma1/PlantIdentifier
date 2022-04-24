//
//  Coordinator.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/23/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var mainNavigationController: UINavigationController? { get set }
    var subCoordinator: [Coordinator]? { get set }
    func start()
    func removeChild(coordinator: Coordinator)
    func startWithController(data: PlantCellViewModel,
                             image: UIImage) -> UIViewController?
    func navigate(to viewController: UIViewController,
                  with presentationStyle: NavigationType,
                  coordinator: Coordinator)
}

extension Coordinator {

    func navigate(to viewController: UIViewController,
                  with presentationStyle: NavigationType,
                  coordinator: Coordinator) {
        switch presentationStyle {
        case .push:
            mainNavigationController?.pushViewController(viewController, animated: true)
        case .present:
            if let lastController = mainNavigationController?.viewControllers.last {
                viewController.modalTransitionStyle = .coverVertical
                viewController.modalPresentationStyle = .overCurrentContext
                lastController.present(viewController, animated: true)
            }
        }
        if let _ = subCoordinator {
            subCoordinator?.append(coordinator)
        } else {
            subCoordinator = [coordinator]
        }
    }
    
    func removeViewController(with presentationStyle: NavigationType) {
        switch presentationStyle {
        case .push:
            mainNavigationController?.popViewController(animated: true)
        case .present:
            if let presentedVC = mainNavigationController?.viewControllers.last?.presentedViewController {
                presentedVC.dismiss(animated: true)
            }
        }
    }
    
    func removeChild(coordinator: Coordinator) {
        if let idx = subCoordinator?.firstIndex(where: { $0 === coordinator }){
            subCoordinator?.remove(at: idx)
        }
    }
    func start() { }
    func startWithController(data: PlantCellViewModel,
                             image: UIImage) -> UIViewController? { return nil }
}
