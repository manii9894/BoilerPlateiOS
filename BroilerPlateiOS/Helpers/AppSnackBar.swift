//
//  AppSnakBar.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 10/05/2022.
//

import Foundation

class AppSnackBar: SnackBar {
    
    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .darkGray
        style.textColor = .white
        style.horizontalPadding = 20
        style.verticalPadding = 20
        return style
    }
    
}
