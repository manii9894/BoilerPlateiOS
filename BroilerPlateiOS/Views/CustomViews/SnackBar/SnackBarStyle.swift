//
//  SnackBarStyle.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 18/05/2022.
//

import Foundation
import UIKit

struct SnackBarStyle {
    public init() { }
    // Container
    var background: UIColor = .systemGray6
    var horizontalPadding = 5
    var verticalPadding: CGFloat = 20
    var inViewPadding = 20
    // Label
    public var textColor: UIColor = .label
    public var font: UIFont = UIFont.systemFont(ofSize: 14)
    var maxNumberOfLines: UInt = 2
    // Action
    public var actionTextColorAlpha: CGFloat = 0.5
    public var actionFont: UIFont = UIFont.systemFont(ofSize: 17)
    public var actionTextColor: UIColor = .red
}
