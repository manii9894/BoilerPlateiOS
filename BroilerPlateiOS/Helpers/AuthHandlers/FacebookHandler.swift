//
//  FacebookHandler.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 05/04/2022.
//

import Foundation
import FBSDKLoginKit
import Combine

class FacebookHandler: NSObject, ObservableObject {
    
    private let loginButton: FBLoginButton!
    @Published var user: User?
    
    override init() {
        loginButton = FBLoginButton()
    }
    
    func getButton() -> FBLoginButton {
        
        loginButton.permissions = ["public_profile", "email"]
        loginButton.delegate = self
        return loginButton
        
    }
    
    func getUserDataFromFacebook() {
        let request = GraphRequest(graphPath: "me", parameters: ["fields": "name, email, picture, id"], httpMethod: .get)
        request.start { [unowned self] (connection, result, error) in
            guard error == nil else {
                self.user = nil
                return
            }
            if let fields = result as? [String:Any], let name = fields["name"] as? String, let email = fields["email"] as? String, let id = fields["id"] as? String {
                let profilePic = "http://graph.facebook.com/\(id)/picture?type=large"
                user = User(email: email, name: name, profilePic: profilePic, userId: id, loginType: .facebook)
            }
        }
    }
    
    func logout() {
        LoginManager().logOut()
    }
    
}

// MARK: - LOGIN BUTTON DELEGATE -
extension FacebookHandler: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        guard error == nil else {
            user = nil
            return
        }
        getUserDataFromFacebook()
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
}
