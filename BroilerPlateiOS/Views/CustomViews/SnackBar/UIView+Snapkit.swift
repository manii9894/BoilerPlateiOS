//
//  UIView+Snapkit.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 18/05/2022.
//

import Foundation
import SnapKit

extension UIView {
    
    func setupSubview(_ subview: UIView, setup: (ConstraintViewDSL) -> Void) {
        self.addSubview(subview)
        setup(subview.snp)
    }
    
}
