//
//  CustomButton.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 11/05/2022.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    // MARK: - PROPERTIES
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            setupViews()
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            setupViews()
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var isRounded: Bool = false
    @IBInspectable var isFilled: Bool = true
    @IBInspectable var isClearBackground: Bool = false
    
    // MARK: - METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override func draw(_ rect: CGRect) {
        setupViews()
    }

    private func setupViews() {
        
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.masksToBounds = isRounded
        if !isFilled {
            backgroundColor = .clear
        }
        if isRounded {
            layer.cornerRadius = frame.height / 2
        } else {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
        
    }
    
}
