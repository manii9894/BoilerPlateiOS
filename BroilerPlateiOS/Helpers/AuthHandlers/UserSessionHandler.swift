//
//  UserSessionHandler.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 17/05/2022.
//

import Foundation
import Combine
import FBSDKLoginKit
import AuthenticationServices

class UserSessionHandler: NSObject, ObservableObject {
    
    // MARK: - OUTLETS
    @Published var user: User?
    private var cancellables: Set<AnyCancellable> = []
    lazy var fbHandler: FacebookHandler = {
        let handler = FacebookHandler()
        return handler
    }()
    lazy var appleHandler: AppleAuthHandler = {
        let handler = AppleAuthHandler()
        return handler
    }()
    lazy var googleHandler: GoogleAuthHandler = {
        let handler = GoogleAuthHandler()
        return handler
    }()
    private var fbButton: FBLoginButton {
        return fbHandler.getButton()
    }
    
    // MARK: - PROPERTIES
    
    
    // MARK: - ACTIONS
    
    
    // MARK: - METHODS
    func login(loginType: LoginType) {
        
        switch loginType {
        case .google:
            loginWithGoogle()
        case .apple:
            loginWithApple()
        case .facebook:
            loginWithFacebook()
        }
        
    }
    
    func logout(withDelay: Bool = true) {
        
        if let user = StorageHandler.shared.user {
            switch user.loginType {
            case .facebook:
                fbHandler.logout()
                break
            case .google:
                googleHandler.logout()
            default: break
            }
            StorageHandler.shared.user = nil
            StorageHandler.shared.userToken = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + (withDelay ? 0.5 : 0.0)) {
                Router.shared.setRootVC()
            }
        }
        
    }
    
    private func loginWithFacebook() {
        
        cancellables.removeAll()
        fbButton.sendActions(for: .touchUpInside)
        fbHandler.$user.sink { user in
            self.user = user
        }.store(in: &cancellables)
        
    }
    
    private func loginWithApple() {
        
        cancellables.removeAll()
        appleHandler.user = nil
        appleHandler.setupAuthentication()
        appleHandler.$user.dropFirst().sink { user in
            self.user = user
        }.store(in: &cancellables)
        
    }
    
    private func loginWithGoogle() {
        
        cancellables.removeAll()
        googleHandler.user = nil
        googleHandler.login()
        googleHandler.$user.dropFirst().sink { [unowned self] user in
            self.user = user
        }.store(in: &cancellables)
        
    }
    
    
}
