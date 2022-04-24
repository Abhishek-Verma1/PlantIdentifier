//
//  CustomCameraVMProtocol.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/23/22.
//

import Foundation

protocol CustomCameraVMProtocol: AnyObject {
    var title: String { get }
    var cameraPermissionText: String { get }
    var cameraAndGalleryPermissionText: String { get }
    var galleryPermissionText: String { get }
    var settingsBtnText: String { get }
    var delegate: CommonCoordinatorDelegate? { get set }
    func openSettingURL(url: URL)
    func isAppRunOnSimulator() -> Bool
}
