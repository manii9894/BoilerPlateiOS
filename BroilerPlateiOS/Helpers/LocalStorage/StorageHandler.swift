//
//  StorageHandler.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 19/07/2022.
//

import Foundation
import UIKit

final class StorageHandler {
    
    static let shared = StorageHandler()
    private let storage: ObjectSavable
    private let keychain: KeychainSwift
    
    init() {
        storage = UserDefaults.standard
        keychain = KeychainSwift()
    }
    
    var userToken: String? {
        get {
            return try? keychain.getObject(forKey: Constants.Keys.userToken, castTo: String.self)
        }
        set {
            try? keychain.setObject(newValue, forKey: Constants.Keys.userToken)
        }
    }
    
    var user: User? {
        get {
            return try? storage.getObject(forKey: Constants.Keys.user, castTo: User.self)
        }
        set {
            try? storage.setObject(newValue, forKey: Constants.Keys.user)
        }
    }
    
    func clearCache() {
        
        userToken = nil
        user = nil
        
    }
    
}
