//
//  UIView.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/22/22.
//

import UIKit

extension UIView {
    func round() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
    }
    
    func setCornerRadius(corners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner],
                         radius: CGFloat) {
        
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        layer.masksToBounds = true
    }
    
    func setShadow(shadowColor: UIColor,
                   shadowOpacity: CGFloat,
                   shadowRadius: CGFloat,
                   shadowOffest: CGSize = CGSize.zero) {
        
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffest
        layer.shadowOpacity = Float(shadowOpacity)
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}

protocol ReusableView : AnyObject {  static var reuseIdentifier : String {get} }
extension ReusableView where Self : UIView {
    static var reuseIdentifier : String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

protocol NibLoadableView : AnyObject { static var nibName : String {get} }
extension NibLoadableView where Self : UIView {
    static var nibName : String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    static func loadNib() -> Self {
        let bundle = Bundle(for:Self.self)
        let nib = UINib(nibName: Self.nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
}
