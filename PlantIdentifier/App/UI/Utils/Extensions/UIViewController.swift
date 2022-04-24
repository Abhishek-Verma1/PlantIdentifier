//
//  UIViewController.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/21/22.
//

import UIKit

protocol AlertsPresentable: AnyObject {}
extension AlertsPresentable where Self: UIViewController {

    func showAlert(with title: String? = nil,
                   message: String? = nil,
                   actionTitle: String? = nil,
                   and action: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .default) { btnAction in
            action?()
        }
        alertController.addAction(alertAction)

        present(alertController, animated: true, completion: nil)
    }

}
