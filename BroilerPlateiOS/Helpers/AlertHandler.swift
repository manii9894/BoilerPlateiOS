//
//  AlertHandler.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 05/05/2022.
//

import Foundation
import UIKit

class AlertHandler {
    
    static let shared = AlertHandler()
    
    private init() {}
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert: alert)
        
    }
    
    func showAlert(title: String, message: String, preferredStyle: UIAlertController.Style? = .alert, buttons: [UIAlertAction]) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle!)
        for button in buttons {
            alert.addAction(button)
        }
        present(alert: alert)
        
    }
    
    private func present(alert: UIAlertController) {
        
        if let vc = Router.shared.getTopVC() {
            vc.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}
