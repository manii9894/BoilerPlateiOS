//
//  SnakBarHandler.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 10/05/2022.
//

import UIKit

class SnackBarHandler {
    
    static let shared = SnackBarHandler()
    private var duration: CGFloat = 2.5
    
    private init() {}
    
    func showSnack(message: String) {
        
        if let view = getTopView() {
            AppSnackBar.make(in: view, message: message, duration: .custom(duration)).show()
        }
        
    }
    
    func showSessionExpiredSnackBar() {
        
        if let view = getTopView() {
            AppSnackBar.make(in: view, message: NetworkError.sessionExpired.errorDescription!, duration: .custom(duration)).show()
            UserSessionHandler().logout()
        }
        
    }
    
    private func getTopView() -> UIView? {
        
        if let vc = Router.shared.getTopVC() {
            return vc.view
        }
        return nil
        
    }
    
    
}
