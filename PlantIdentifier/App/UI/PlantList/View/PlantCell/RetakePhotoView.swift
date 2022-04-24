//
//  PlantListViewModel.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/23/22.
//

import UIKit

protocol RetakePhotoViewDelagate: AnyObject {
    func retakeBtnTapped()
}

class RetakePhotoView: UICollectionViewCell, NibLoadableView, ReusableView  {

    @IBOutlet weak var didntFindPlantLbl: UILabel! {
        didSet {
            didntFindPlantLbl.textColor = AppColor.WashedBlackColor
            didntFindPlantLbl.font = AppFont.AvenirNextDemiBold(size: 20.0)
        }
    }
    
    @IBOutlet weak var didntFindPlantDescriptionLbl: UILabel! {
        didSet {
            didntFindPlantDescriptionLbl.textColor = AppColor.WashedBlackColor
            didntFindPlantDescriptionLbl.font = AppFont.AvenirNextMedium(size: 16.0)
        }
    }
    
    @IBOutlet weak var retakePhoto: UIButton! {
        didSet {
            retakePhoto.setTitleColor(AppColor.WashedBlackColor, for: .normal)
            retakePhoto.backgroundColor = AppColor.clearColor
            retakePhoto.titleLabel?.font = AppFont.AvenirNextDemiBold(size: 16.0)
        }
    }
    
    weak var delegate: RetakePhotoViewDelagate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func retakeBtnTapped(_ sender: UIButton) {
        delegate?.retakeBtnTapped()
    }
    
    
    func populateData(title: String,
                      description: String,
                      buttonTitle: String) {
        didntFindPlantLbl.text = title
        didntFindPlantDescriptionLbl.text = description
        retakePhoto.setTitle(buttonTitle, for: .normal)
    }
}
