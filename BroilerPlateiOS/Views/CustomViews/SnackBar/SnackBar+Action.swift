//
//  SnackBar+Action.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 18/05/2022.
//

import Foundation
import UIKit

extension UIButton {
    struct Trager { static var action :(() -> Void)? }
    private func actionHandler(action:(() -> Void)? = nil) {
        if action != nil {
            Trager.action = action
            
        } else {
            Trager.action?()
            
        }
    }
    @objc private func triggerActionHandler() {
        self.actionHandler()
    }
    func actionHandler(controlEvents control: UIControl.Event, ForAction action: @escaping () -> Void) {
        self.actionHandler(action: action)
        self.addTarget(self, action: #selector(triggerActionHandler), for: control)
    }
}
