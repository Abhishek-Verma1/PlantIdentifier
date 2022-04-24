//
//  AppColor.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/22/22.
//

import Foundation
import UIKit

#warning("Color naming conventions need to be corrected in the next sprint.")
final class AppColor {
    
    private init() { }
    
    class var textColor: UIColor {
        return UIColor(named: "textColor") ?? .white
    }
    
    class var WashedBlackColor: UIColor {
        return UIColor(named: "WashedBlackColor") ?? .white
    }
    
    class var precentageViewColor: UIColor {
        return UIColor(named: "percentageViewColor") ?? .white
    }
    class var percentageLblColor: UIColor {
        return UIColor(named: "percentageLblColor") ?? .white
    }
    class var clearColor: UIColor {
        return UIColor.clear
    }
    class var navBarColor: UIColor {
        return UIColor(named: "navBarColor") ?? .white
    }
    class var navigationItemTintColor: UIColor {
        return UIColor(named: "navigationItemTintColor") ?? .white
    }
    class var loaderBackgroundColor: UIColor {
        return UIColor(named: "navigationItemTintColor") ?? .white
    }
    class var whiteColor: UIColor {
        return UIColor.white
    }
    class var cellBackgroundColor: UIColor {
        return UIColor(named: "cellBackgroundColor") ?? .white
    }
    class var spinnerColor: UIColor {
        return UIColor(named: "spinnerColor") ?? .white
    }
    class var navigationBarTextColor: UIColor {
        return UIColor(named: "navigationBarTextColor") ?? .white
    }
    class var shadowColor: UIColor {
        return UIColor(named: "shadowColor") ?? .white
    }
    class var imagePreviewNavBarColor: UIColor {
        return UIColor(named: "imagePreviewNavBarColor") ?? .white
    }
}
