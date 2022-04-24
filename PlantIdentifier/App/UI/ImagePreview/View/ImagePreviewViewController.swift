//
//  ImagePreviewViewController.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/23/22.
//

import UIKit

final class ImagePreviewViewController: UIViewController {

    @IBOutlet weak var navigationBarView: UIView! {
        didSet {
            navigationBarView.backgroundColor = AppColor.imagePreviewNavBarColor
        }
    }
    
    @IBOutlet weak var navigationBarLbl: UILabel! {
        didSet {
            navigationBarLbl.textColor = AppColor.whiteColor
            navigationBarLbl.font = AppFont.AvenirNextDemiBold(size: 16.0)
            navigationBarLbl.text = data.title
        }
    }
    
    @IBOutlet weak var imagePreview: UIImageView! {
        didSet {
            imagePreview.image = image
        }
    }
    private var image: UIImage!
    private var data: PlantCellViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func prepareView(data: PlantCellViewModel, image: UIImage) {
        self.image = image
        self.data = data
    }
}
