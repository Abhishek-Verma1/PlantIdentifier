//
//  UICollectionView.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/22/22.
//

import UIKit

extension UICollectionView {

    func register<T:UICollectionViewCell>(_ : T.Type) where T : ReusableView & NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerSupplementryFooterView<T: UICollectionReusableView>(cellClass: T.Type) {
        let identifier = String(describing: cellClass.self)
        register(UINib(nibName: identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier)
    }

    func dequeResuseableCell<T:UICollectionViewCell>(for indexPath : IndexPath)->T where T : ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else{
            fatalError("Couldn't cast cell in \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeReusableSupplementryView<T>(reusableViewClass: T.Type,
                                        kind: String,
                                        indexPath: IndexPath) -> T where T: UICollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Header not found") }
        return view
    }

    func setdelegateAndDatasource(for viewController : UIViewController) {
        self.delegate = viewController as? UICollectionViewDelegate
        self.dataSource = viewController as? UICollectionViewDataSource
    }
}

