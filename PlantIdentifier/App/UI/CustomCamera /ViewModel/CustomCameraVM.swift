//
//  CustomCameraVM.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/23/22.
//

import Foundation

final class CustomCameraVM: CustomCameraVMProtocol {
    
    var title: String {
        "Photo Identification".localized()
    }
    var cameraPermissionText: String {
        return "Camera Permission is not provided. Please enable it from settings.".localized()
    }
    var cameraAndGalleryPermissionText: String {
        return "Camera Or Gallery Permission is not provided. Please enable it from settings.".localized()
    }
    var galleryPermissionText: String {
        return "Gallery Permission is not provided. Please enable it from settings.".localized()
    }
    
    var settingsBtnText: String { return "Settings".localized() }
    weak var delegate: CommonCoordinatorDelegate?
    
    required init(coordinatorDelegate: CommonCoordinatorDelegate) {
        delegate = coordinatorDelegate
    }
    
    func openSettingURL(url: URL) {
        delegate?.openPhoneSetting(url: url)
    }
    
     #warning("Will move to Device extension later.")
    func isAppRunOnSimulator() -> Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }
}
