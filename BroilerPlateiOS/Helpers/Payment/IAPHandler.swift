//
//  IAPHandler.swift
//  AudioBlend
//
//  Created by Abdul Rehman on 07/11/2022.
//

import Foundation
import StoreKit

class IAPHandler: NSObject, Payable {
    
    // MARK: - PROPERTIES
    typealias Transaction = StoreKit.Transaction
    private var subscriptions = [Product]()
    private var purchasedSubscriptions: [Product] = []
    
    // MARK: - METHODS
    override init() {
        super.init()
        
    }
    
    private func fetchProducts() async {
        
        do {
            let storeProducts = try await Product.products(for: getProductsIDs())
            var newSubscriptions: [Product] = []

            for product in storeProducts {
                switch product.type {
                case .autoRenewable:
                    newSubscriptions.append(product)
                default:
                    print("Unknown product")
                }
            }
            subscriptions = sortByPrice(newSubscriptions)
            
        } catch {
            print("Failed product request from the App Store server: \(error)")
        }
    }
    
    private func getUserProductStatus() async {
        
        var purchasedSubscriptions: [Product] = []
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                switch transaction.productType {
                case .autoRenewable:
                    if let subscription = subscriptions.first(where: { $0.id == transaction.productID }) {
                        purchasedSubscriptions.append(subscription)
                    }
                default:
                    break
                }
            } catch {
                print()
            }
        }
        self.purchasedSubscriptions = purchasedSubscriptions
        
    }
    
    private func getProductsIDs() -> [String] {
        
        var products = [String]()
        for product in IAPProduct.allCases {
            products.append(product.rawValue)
        }
        return products
        
    }
    
    private func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { return $0.price > $1.price })
    }
    
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
        
    }
    
    func pay(for item: PaymentItem, success: @escaping () -> Void) {
        
    }
    
    func isPurchased(item: PaymentItem) -> Bool {
        
        if let product = subscriptions.first(where: { obj in
            return obj.price == item.amount as Decimal
        }) {
            return purchasedSubscriptions.contains(product)
        }
        return false
        
    }
    
    func fetchData() {
        
        Task {
            await fetchProducts()
            await getUserProductStatus()
        }
        
    }
    
}

public enum StoreError: Error {
    case failedVerification
}
