//
//  AppFont.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/22/22.
//

import Foundation
import UIKit

final class AppFont {
    
    private init() { }
    
    class func AvenirNextDemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: size) ?? semibold(size: size)
    }
    
    class func AvenirNextRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size) ?? regular(size: size)
    }
    
    class func AvenirNextMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Medium", size: size) ?? medium(size: size)
    }
    
    class func semibold(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    class func regular(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    class func medium(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }

}
