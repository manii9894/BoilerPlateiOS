//
//  GoogleAuthHandler.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 11/04/2022.
//

import Foundation
import Combine
import GoogleSignIn

class GoogleAuthHandler: NSObject, ObservableObject {
    
    private let signInConfig = GIDConfiguration.init(clientID: Constants.Config.googleClientID)
    @Published var user: User?
    
    func login() {
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: Router.shared.getTopVC()!) { [unowned self] user, error in
            guard error == nil else {
                self.user = nil
                return
            }
            if let profile = user?.profile, let id = user?.userID {
                self.user = User(email: profile.email, name: profile.name, profilePic: profile.imageURL(withDimension: 320)?.absoluteString ?? "", userId: id, loginType: .google)
            }
        }
        
    }
    
    func logout() {
        GIDSignIn.sharedInstance.signOut()
    }
    
}
