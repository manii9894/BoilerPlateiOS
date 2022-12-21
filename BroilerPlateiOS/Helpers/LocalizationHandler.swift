//
//  LocalizationHandler.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 29/07/2022.
//

import Foundation

final class LocalizationHandler {
    
    static func getLocalizedString(for string: AppStrings) -> String {
        return string.rawValue.localized
    }
    
}

enum AppStrings: String {
    
    case unableToEncode, noValue, unableToDecode, skin, accentColor, profile, resetTheme, deleteAccount, logout, about, cameraPermissionMsg, permissionRequired, settings, camera, gallery, cancel, pickImage, galleryPermissionMsg, privacyPolicy, rate, more, remove, removeAudioMsg, removeAudioTitle, deleteAudio
    
}
