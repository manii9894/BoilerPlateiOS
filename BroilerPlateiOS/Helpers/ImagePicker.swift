//
//  ImagePicker.swift
//  AudioBlend
//
//  Created by Abdul Rehman on 27/09/2022.
//

import UIKit
import Photos

class ImagePickerManager: NSObject {
    
    // MARK: - PROPERTIES
    private var picker = UIImagePickerController()
    var pickImageCallback : ((UIImage) -> ())?
    
    // MARK: - METHODS
    override init(){
        super.init()
        picker.delegate = self
    }
    
    func pickImage(_ callback: @escaping ((UIImage) -> ())) {
        
        pickImageCallback = callback
        let cameraAction = UIAlertAction(title: LocalizationHandler.getLocalizedString(for: .camera), style: .default) { [unowned self] UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: LocalizationHandler.getLocalizedString(for: .gallery), style: .default) { [unowned self] UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: LocalizationHandler.getLocalizedString(for: .cancel), style: .cancel)
        AlertHandler.shared.showAlert(title: LocalizationHandler.getLocalizedString(for: .pickImage), message: "", preferredStyle: .actionSheet, buttons: [cameraAction, galleryAction, cancelAction])
        
    }
    
   
    func openCamera(){
        
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                picker.sourceType = .camera
                present()
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { [unowned self] (granted) in
                    if granted {
                        DispatchQueue.main.async {
                            self.picker.sourceType = .camera
                            self.present()
                        }
                    }
                }
            case .denied:
                let cancel = UIAlertAction(title: LocalizationHandler.getLocalizedString(for: .cancel), style: .cancel, handler: nil)
                let settings = UIAlertAction(title: LocalizationHandler.getLocalizedString(for: .settings), style: .default) { (action) in
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsUrl)
                    }
                }
                AlertHandler.shared.showAlert(title: LocalizationHandler.getLocalizedString(for: .permissionRequired), message: LocalizationHandler.getLocalizedString(for: .cameraPermissionMsg), buttons: [cancel, settings])
            default:
                break
            }
        }
        
    }
    
    func openGallery(){
        
        let photos = PHPhotoLibrary.authorizationStatus()
        switch photos {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ [unowned self] status in
                if status == .authorized{
                    DispatchQueue.main.async {
                        self.picker.sourceType = .photoLibrary
                        self.present()
                    }
                }
            })
        case .denied:
            let cancel = UIAlertAction(title: LocalizationHandler.getLocalizedString(for: .cancel), style: .cancel, handler: nil)
            let settings = UIAlertAction(title: LocalizationHandler.getLocalizedString(for: .settings), style: .default) { (action) in
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            AlertHandler.shared.showAlert(title: LocalizationHandler.getLocalizedString(for: .permissionRequired), message: LocalizationHandler.getLocalizedString(for: .galleryPermissionMsg), buttons: [cancel, settings])
        case .authorized:
            DispatchQueue.main.async {
                self.picker.sourceType = .photoLibrary
                self.present()
            }
        default:
            break
        }
    }
    
    private func present() {
        
        if let vc = Router.shared.getTopVC() {
            vc.present(picker, animated: true, completion: nil)
        }
        
    }
    
}

// MARK: - UIIMAGEPICKER DELEGATE -
extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        pickImageCallback?(image)
    }
    
}
