//
//  Permissions.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/23/22.
//

import Foundation
import Photos

struct Permissions {
    
    func checkCameraPermissions(completion: @escaping ((Bool) -> Void)) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch (authStatus) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: completion)
        case .authorized:
            completion(true)
        default:
            break
        }
    }
    
    static func checkGalleryPermissons(completion: @escaping ((Bool) -> Void)) {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            completion(true)
        } else {
            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: .readWrite, handler: { (status) in
                    DispatchQueue.main.async {
                        switch status {
                        case .authorized:
                            completion(true)
                        default:
                            completion(false)
                        }
                    }
                })
            } else {
                PHPhotoLibrary.requestAuthorization { (status) in
                    DispatchQueue.main.async {
                        switch status {
                        case .authorized:
                            completion(true)
                        default:
                            completion(false)
                        }
                    }
                }
            }
        }
    }
}
