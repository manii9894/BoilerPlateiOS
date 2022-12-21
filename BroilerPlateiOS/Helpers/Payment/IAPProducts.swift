//
//  IAPProducts.swift
//  AudioBlend
//
//  Created by Abdul Rehman on 08/11/2022.
//

import Foundation

enum IAPProduct: String, CaseIterable {
    
    case premiumSubscription = "premium.subscription"
    
    var blenders: Int {
        switch self {
        case .premiumSubscription:
            return 5
        }
    }
    
    var price: Double {
        switch self {
        case .premiumSubscription:
            return 0.99
        }
    }
    
}
