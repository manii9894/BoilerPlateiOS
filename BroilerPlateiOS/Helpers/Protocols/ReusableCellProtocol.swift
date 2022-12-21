//
//  ReusableTableViewCellProtocol.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 12/05/2022.
//

import Foundation

protocol ReusableCellProtocol: AnyObject{
    static var identifier: String { get }
}

extension ReusableCellProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
