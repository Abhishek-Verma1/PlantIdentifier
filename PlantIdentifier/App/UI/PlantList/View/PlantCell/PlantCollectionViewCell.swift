//
//  PlantCollectionViewCell.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/21/22.
//

import UIKit

class PlantCollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.backgroundColor = AppColor.cellBackgroundColor
            bgView.setCornerRadius(radius: 16.0)
        }
    }
    
    @IBOutlet weak var plantmage: UIImageView!
    
    @IBOutlet weak var cellTitleLbl: UILabel! {
        didSet {
            cellTitleLbl.textColor = AppColor.textColor
            cellTitleLbl.font = AppFont.AvenirNextDemiBold(size: 16.0)
        }
    }
    
    @IBOutlet weak var cellDescriptionLbl: UILabel! {
        didSet {
            cellDescriptionLbl.textColor = AppColor.textColor
            cellDescriptionLbl.font = AppFont.AvenirNextRegular(size: 14.0)
        }
    }
    
    @IBOutlet weak var percentageView: UIView! {
        didSet {
            percentageView.backgroundColor = AppColor.precentageViewColor
            percentageView.setCornerRadius(radius: 3.0)
        }
    }
    
    @IBOutlet weak var percentageLbl: UILabel! {
        didSet {
            percentageLbl.textColor = AppColor.percentageLblColor
            percentageLbl.font = AppFont.AvenirNextDemiBold(size: 16.0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        shadowView.setShadow(shadowColor: AppColor.shadowColor,
                             shadowOpacity: 0.4,
                             shadowRadius: 2.0)
    }
}

extension PlantCollectionViewCell {
  
    func setup(_ viewModel: PlantCellViewModel) {
        plantmage.image =  viewModel.image        
        cellTitleLbl.text = viewModel.title
        cellDescriptionLbl.text = viewModel.subTitle
        #warning("I am not sure for this calculation and optimization is required in the next sprint.")
        percentageLbl.text = "\(viewModel.score?.roundToDecimal(2) ?? 0) %"
    }
}
