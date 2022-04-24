//
//  StroryBoardInitialize.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/23/22.
//

import Foundation
import UIKit

protocol StroryBoardInitialize: AnyObject {
    var storyboard: UIStoryboard.Storyboard { get }
    var storyboardID: String { get }
    func initiatlizeViewController() -> UIViewController
}

extension StroryBoardInitialize where Self: Coordinator {

    func initiatlizeViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard.storyBoardIdentifier,
                                      bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: storyboardID)
    }
}
