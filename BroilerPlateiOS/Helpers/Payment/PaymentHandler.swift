//
//  PaymentHandler.swift
//  AudioBlend
//
//  Created by Abdul Rehman on 30/09/2022.
//

import Foundation

protocol Payable {
    func pay(for item: PaymentItem, success: @escaping () -> Void)
    func isPurchased(item: PaymentItem) -> Bool
    func fetchData()
}

struct PaymentItem {
    
    var itemName: String
    var amount: NSDecimalNumber
    
}

final class PaymentHandler {
    
    // MARK: - PROPERTIES
    static let shared = PaymentHandler()
    private let method: Payable
    
    // MARK: - METHODS
    private init() {
        method = IAPHandler()
    }
    
    func fetchSubscriptionStatus() {
        method.fetchData()
    }
    
    func makePayment(item: PaymentItem, success: @escaping () -> Void) {
        method.pay(for: item, success: success)
    }
    
}
