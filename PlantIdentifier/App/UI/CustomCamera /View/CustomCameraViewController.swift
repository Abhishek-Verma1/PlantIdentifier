//
//  CustomCameraViewController.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/23/22.
//

import UIKit

#warning("Optimization is required in the next sprint.")
class CustomCameraViewController: UIViewController, AlertsPresentable {
    
    @IBOutlet weak var photoIdentificationLbl: UILabel! {
        didSet {
            photoIdentificationLbl.textColor = AppColor.whiteColor
            photoIdentificationLbl.font = AppFont.semibold(size: 16)
            photoIdentificationLbl.text = viewModel.title
        }
    }
    
    @IBOutlet weak var captureBtn: UIButton! {
        didSet {
            captureBtn.isHidden = false
        }
    }
    
    @IBOutlet weak var galleryBtn: UIButton!
    
    @IBOutlet weak var outerNavBarView: UIView! {
        didSet {
            outerNavBarView.backgroundColor = AppColor.navBarColor
        }
    }
    
    @IBOutlet weak var navBarView: UIView! {
        didSet {
            navBarView.backgroundColor = AppColor.clearColor
        }
    }
    
    @IBOutlet weak var outerBottomBarView: UIView! {
        didSet {
            outerBottomBarView.backgroundColor = AppColor.navBarColor
        }
    }
    
    @IBOutlet weak var bottomBarView: UIView! {
        didSet {
            bottomBarView.backgroundColor = AppColor.clearColor
        }
    }
    
    @IBOutlet weak var cameraPermissionLbl: UILabel! {
        didSet {
            cameraPermissionLbl.textColor = AppColor.textColor
            cameraPermissionLbl.font = AppFont.AvenirNextDemiBold(size: 16)
            cameraPermissionLbl.isHidden = true
        }
    }
    
    @IBOutlet weak var settingBtn: UIButton! {
        didSet {
            settingBtn.setTitle(viewModel.settingsBtnText, for: .normal)
            settingBtn.titleLabel?.font = AppFont.AvenirNextMedium(size: 16)
            settingBtn.setTitleColor(.blue, for: .normal)
            settingBtn.isHidden = true
        }
    }
    
    private var viewModel: CustomCameraVMProtocol!
    private var customCamera: CustomCamera!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customCamera = CustomCamera(delegate: self)
        Task {
            await openCameraGallery()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        customCamera.startCameraSession()
    }
    
    @IBAction func galleryBtnTapped(_ sender: UIButton) {
        Task {
            await openGallery()
        }
    }
    
    @IBAction func captureBtnTapped(_ sender: UIButton) {
        customCamera.capturePicture()
    }
    
    @IBAction func settingBtnTapped(_ sender: UIButton) {
        openDeviceSetting()
    }
    
    func prepareViewModel(vm: CustomCameraVMProtocol) {
        viewModel = vm
    }
    
    private func openCameraGallery() async {
        if viewModel.isAppRunOnSimulator() {
            await openGallery()
        } else {
            let isCameraOpened = await openCamera()
            if !isCameraOpened {
                do {
                    try await customCamera.openPhotoLibrary(parent: self)
                } catch {
                    cameraPermissionLbl.text = viewModel.cameraAndGalleryPermissionText
                }
            }
        }
    }
    
    private func openCamera() async -> Bool {
        do {
            try await customCamera.openCamera(parentVC: self)
            cameraPermissionLbl.isHidden = true
            settingBtn.isHidden = true
            captureBtn.isHidden = false
            return true
        } catch {
            cameraPermissionLbl.isHidden = false
            settingBtn.isHidden = false
            captureBtn.isHidden = true
            cameraPermissionLbl.text = viewModel.cameraPermissionText
            return false
        }
    }
    
    private func openGallery() async {
        do {
            try await customCamera.openPhotoLibrary(parent: self)
        } catch {
            showAlert(with: "Gallery", message: viewModel.galleryPermissionText, actionTitle: viewModel.settingsBtnText) {
                self.openDeviceSetting()
            }
        }
    }
    
    private func openDeviceSetting() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        viewModel.openSettingURL(url: settingsUrl)
    }
}

extension CustomCameraViewController: CustomCameraDelegate {
    func imageError(_ error: CustomCameraErrors) {
        print("error while capture")
    }
    
    func selectedImage(_ image: UIImage) {
        dismiss(animated: true)
        viewModel.delegate?.moveToResultScreen(image)
    }
}

