//
//  Fonts.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 06/04/2022.
//

import Foundation
import UIKit

enum Fonts: String {
    
    case poppinsBlackItalic = "Poppins-BlackItalic", poppinsBlack = "Poppins-Black", poppinsBoldItalic = "Poppins-BoldItalic", poppinsBold = "Poppins-Bold", poppinsExtraBoldItalic = "Poppins-ExtraBoldItalic", poppinsExtraBold = "Poppins-ExtraBold", poppinsExtraLightItalic = "Poppins-ExtraLightItalic", poppinsExtraLight = "Poppins-ExtraLight", poppinsItalic = "Poppins-Italic", poppinsLightItalic = "Poppins-LightItalic", poppinsLight = "Poppins-Light", poppinsMediumItalic = "Poppins-MediumItalic", poppinsMedium = "Poppins-Medium", poppinsThinItalic = "Poppins-ThinItalic", poppinsThin = "Poppins-Thin", poppins = "Poppins-Regular", poppinsSemiBold = "Poppins-SemiBold", poppinsSemiBoldItalic = "Poppins-SemiBoldItalic"
    
    func getFont(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
    
}
