//
//  SnackBar+Duration.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 18/05/2022.
//

import Foundation
import UIKit

extension SnackBar {
    
    public enum Duration: Equatable {
        case lengthLong
        case lengthShort
        case infinite
        case custom(CGFloat)
        
        var value: CGFloat {
            
            switch self {
            
            case .lengthLong:
                return 3.5
            case .lengthShort:
                return 2
            case .infinite:
                return -1
            case .custom(let duration):
                return duration
            }
        }
    }
}
