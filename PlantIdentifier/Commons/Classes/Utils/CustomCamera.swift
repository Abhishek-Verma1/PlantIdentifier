//
//  CustomCamera.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/23/22.
//

import Foundation
import AVFoundation
import UIKit
import PhotosUI

protocol CustomCameraDelegate: AnyObject {
    func selectedImage(_ image: UIImage)
    func imageError(_ error: CustomCameraErrors)
}

enum CustomCameraErrors: Error {
    case deviceNotFound
    case captureDeviceInputNotFound
    case captureDeviceOutputNotAdded
    case galleryPermissionsNotProvided
    case cameraPermissionsNotProvided
    case imageCaptureFailed(String)
}

#warning("Optimization is required in the next sprint.")
final class CustomCamera: NSObject {
    
    private var captureSession: AVCaptureSession!
    private var videoPreviewView: AVCaptureVideoPreviewLayer!
    private var capturePhotoOutput: AVCapturePhotoOutput!
    weak var delegate: CustomCameraDelegate?
    
    required init(delegate: CustomCameraDelegate) {
        self.delegate = delegate
    }
    
    func openCamera(parentVC: UIViewController) async throws {
        if checkCameraPermissions() {
            try await startCamera(previewView: parentVC.view)
        } else {
            let status = await requestAccessForCamera()
            if status {
                try await startCamera(previewView: parentVC.view)
            } else {
                throw CustomCameraErrors.cameraPermissionsNotProvided
            }
        }
    }
    
    func openPhotoLibrary(parent: UIViewController) async throws {
        let photoLibraryPermissions = await checkPhotoLibraryPermissions()
        if photoLibraryPermissions {
            openLibrary(viewController: parent)
        } else {
            throw CustomCameraErrors.galleryPermissionsNotProvided
        }
    }
    
    func checkCameraPermissions() -> Bool {
        guard AVCaptureDevice.authorizationStatus(for: .video) != .authorized else {
            return true
        }
        return false
    }
    
    private func requestAccessForCamera() async -> Bool {
        let permission = await AVCaptureDevice.requestAccess(for: .video)
        return permission
    }
    
    private func startCamera(previewView: UIView) throws {
        captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        if captureSession.canSetSessionPreset(.photo) {
            captureSession.sessionPreset = .photo
        }
        self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
        let cameraInput = try getCameraInputs()
        guard captureSession.canAddInput(cameraInput) else {
            throw CustomCameraErrors.captureDeviceInputNotFound
        }
        captureSession.addInput(cameraInput)
        try setCameraOutput()
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.videoPreviewView = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.videoPreviewView?.videoGravity = .resizeAspectFill
            self.videoPreviewView?.frame = previewView.layer.bounds
            previewView.layer.insertSublayer(self.videoPreviewView!, at: 0)
        }
        
        captureSession?.commitConfiguration()
        captureSession?.startRunning()
    }
    
    func startCameraSession() {
        if let session = captureSession,
           !session.isRunning {
            captureSession?.startRunning()
        }
    }
    
    private func getCameraInputs() throws -> AVCaptureDeviceInput {
        let device = try getCapturedDevice()
        let input = try AVCaptureDeviceInput(device: device)
        return input
    }
    
    private func getCapturedDevice() throws -> AVCaptureDevice {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            return  device
        } else {
            throw CustomCameraErrors.deviceNotFound
        }
    }
    
    private func setCameraOutput() throws {
        capturePhotoOutput = AVCapturePhotoOutput()
        capturePhotoOutput.isHighResolutionCaptureEnabled = true
        if captureSession.canAddOutput(capturePhotoOutput) {
            captureSession.addOutput(capturePhotoOutput)
        } else {
            throw CustomCameraErrors.captureDeviceOutputNotAdded
        }
    }
    
    func capturePicture() {
        guard let captureOutput = capturePhotoOutput else { return }
        let settings = getPhotoSettings()
        captureOutput.capturePhoto(with: settings, delegate: self)
    }
    
    private func getPhotoSettings() -> AVCapturePhotoSettings {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto
        return photoSettings
    }
    
    func checkPhotoLibraryPermissions() async -> Bool {
        let permissionStatus = photoLibraryPermissionsStatus()
        if permissionStatus == .notDetermined || permissionStatus == .denied {
            let status = await requestAccessForPhotoLibrary()
            return status
        }
        if #available(iOS 14, *) {
            return permissionStatus == .authorized || permissionStatus == .limited
        } else {
            return permissionStatus == .authorized
            // Fallback on earlier versions
        }
    }
    
    private func photoLibraryPermissionsStatus() -> PHAuthorizationStatus {
        
        if #available(iOS 14, *) {
            return PHPhotoLibrary.authorizationStatus(for: .readWrite)
        } else {
            return PHPhotoLibrary.authorizationStatus()
        }
    }
    
    private func requestAccessForPhotoLibrary() async -> Bool {
        var status: PHAuthorizationStatus = .denied
        if #available(iOS 14, *) {
            status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        } else {
            // Fallback on earlier versions
            PHPhotoLibrary.requestAuthorization { permissionStatus in
                status = permissionStatus
            }
        }
        return status == .authorized
    }
    
    private func openLibrary(viewController: UIViewController) {
        DispatchQueue.main.async {
            let controller = UIImagePickerController()
            controller.delegate = self
            #warning("Will be removed in a future release, use PHPicke in next sprint.")
            controller.sourceType = .photoLibrary
            controller.allowsEditing = true
            viewController.modalTransitionStyle = .coverVertical
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.present(controller, animated: true, completion: nil)
        }
    }
}

extension CustomCamera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let err = error {
            delegate?.imageError(.imageCaptureFailed(err.localizedDescription))
            return
        }
        guard let imageData = photo.fileDataRepresentation() else {
            delegate?.imageError(.imageCaptureFailed("Fail to convert in pixel buffer"))
            return
        }
        guard let capturedImage = UIImage(data: imageData , scale: 1.0) else {
            delegate?.imageError(.imageCaptureFailed("Fail to convert image data to UIImage"))
            return
        }
        captureSession?.stopRunning()
        delegate?.selectedImage(capturedImage)
    }
}

extension CustomCamera: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            delegate?.selectedImage(image)
        }
        picker.dismiss(animated: true)
    }
}
