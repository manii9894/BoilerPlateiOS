//
//  RoundShadowView.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 21/04/2022.
//

import UIKit

@IBDesignable
class RoundShadowView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            layoutView()
        }
    }
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            layoutView()
        }
    }
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            layoutView()
        }
    }
    @IBInspectable var shadowOpacity: Float = 1 {
        didSet {
            layoutView()
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 4 {
        didSet {
            layoutView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutView()
    }
    
    func layoutView() {
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        
    }
    
}
