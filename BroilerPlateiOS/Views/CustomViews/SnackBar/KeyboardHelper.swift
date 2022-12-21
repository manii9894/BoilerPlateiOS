//
//  KeyboardHelper.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 18/05/2022.
//

import Foundation
import UIKit

final class KeyboardHelper {
    
    static let shared = KeyboardHelper()
    var keyboardHeight: CGFloat = 0
    var keyboardWillHide: () -> Void = {}
    
    private init() {}
    
    func setupKeyboardObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handle(keyboardShowNotification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handle(keyboardHideNotification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handle(keyboardWillHideNotification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func removeObservers() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc
    private func handle(keyboardShowNotification notification: Notification) {
        if let userInfo = notification.userInfo,
            // 3
            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    @objc
    private func handle(keyboardHideNotification notification: Notification) {
        keyboardHeight = 0
    }
    
    @objc
    private func handle(keyboardWillHideNotification notification: Notification) {
        keyboardWillHide()
    }
    
}
