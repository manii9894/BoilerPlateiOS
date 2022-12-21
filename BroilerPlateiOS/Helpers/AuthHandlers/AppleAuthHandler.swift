//
//  AppleAuthHandler.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 11/04/2022.
//

import Foundation
import Combine
import AuthenticationServices

class AppleAuthHandler: NSObject, ObservableObject {
    
    @Published var user: User?
    
    func setupAuthentication() {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
        
    }
    
}

// MARK: - APPLE AUTHENTICATION DELEGATE -
extension AppleAuthHandler: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            var fullName = ""
            if let firstName = appleIDCredential.fullName?.givenName, let lastName = appleIDCredential.fullName?.familyName {
                fullName = firstName + " " + lastName
            }
            user = User(email: appleIDCredential.email ?? "", name: fullName, userId: appleIDCredential.user, loginType: .apple)
        }
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
        user = nil
    }
    
}
