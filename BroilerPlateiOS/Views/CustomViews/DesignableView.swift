//
//  DesignableView.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 07/04/2022.
//

import UIKit

@IBDesignable
class DesignableView: UIView {
    
    // MARK: - PROPERTIES
    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var isRounded: Bool = false
    
    // MARK: - METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        if isRounded {
            layer.cornerRadius = frame.height / 2
        } else {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
        
    }

}
