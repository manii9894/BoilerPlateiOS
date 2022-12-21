//
//  NibLoadableView.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 12/05/2022.
//

import Foundation

protocol NibLoadableView {
    static var nibName: String { get }
}

extension NibLoadableView  {
    static var nibName: String {
        return String(describing: self)
    }
}
