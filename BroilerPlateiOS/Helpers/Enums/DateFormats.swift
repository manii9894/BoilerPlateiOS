//
//  DateFormats.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 27/04/2022.
//

import Foundation

enum DateFormats {
    
    case mmDDYYYYYhhmma
    case yyyyMMddHHmmSSZ
    case yyyyMMddHHmmSS
    case MMMdhmma
    case MMMdyyyy
    case hhmma
    case mmDDYYYYY
    case ddMMYYYYYhhmma
    case yyyyMMdd
    case HHmmss
    case ddMMYYYYY
    case ddMMMMYYYY
    case MMMYYYY
    case YYYY
    
    var name: String {
        
        switch self {
        case .mmDDYYYYYhhmma: return "MM-dd-yyyy hh:mm a"
        case .yyyyMMddHHmmSS: return "yyyy-MM-dd HH:mm:ss"
        case .mmDDYYYYY: return "MM-dd-yyyy"
        case .ddMMYYYYY: return "dd-MM-yyyy"
        case .yyyyMMdd : return "yyyy-MM-dd"
        case .ddMMYYYYYhhmma: return "dd-MM-yyyy hh:mm a"
        case .yyyyMMddHHmmSSZ: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case .hhmma: return "hh:mm a"
        case .HHmmss: return "HH:mm:ss"
        case .ddMMMMYYYY: return "dd MMMM yyyy"
        case .MMMYYYY: return "MMM yyyy"
        case .YYYY: return "yyyy"
        case .MMMdhmma: return "MMM d, h:mm a"
        case .MMMdyyyy: return "MMM d, yyyy"
        }
        
    }
    
}
