//
//  ApplePayHandler.swift
//  AudioBlend
//
//  Created by Abdul Rehman on 30/09/2022.
//

import Foundation
import PassKit

class ApplePayHandler: NSObject, Payable {
    
    // MARK: - PROPERTIES
    private var success: (() -> Void)?
    
    // MARK: - METHODS
    func pay(for item: PaymentItem, success: @escaping () -> Void) {
        
        let paymentRequest = createRequest(payment: item)
        if let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            controller.delegate = self
            self.success = success
            if let vc = Router.shared.getTopVC() {
                vc.present(controller, animated: true, completion: nil)
            }
        }
        
    }
    
    private func createRequest(payment: PaymentItem) -> PKPaymentRequest {
        
        let request = PKPaymentRequest()
        request.merchantIdentifier = Constants.Config.applePayMerchantId
        request.supportedNetworks = [.visa, .masterCard,.amex,.discover]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: payment.itemName, amount: payment.amount)]
        return request
        
    }
    
    func isPurchased(item: PaymentItem) -> Bool {
        return false
    }
    
    func fetchData() {
            
    }
    
}

extension ApplePayHandler: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        success!()
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true)
    }
    
}
