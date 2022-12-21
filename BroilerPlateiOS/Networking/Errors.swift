//
//  Erros.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseError(String)
    case unknown
    case generic
    case internetError
    case sessionExpired
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError(let error):
            return NSLocalizedString(error, comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        case .generic:
            return NSLocalizedString("Something went wrong", comment: "Something went wrong")
        case .internetError:
            return NSLocalizedString("Please check your internet connection", comment: "Please check your internet connection")
        case .sessionExpired:
            return NSLocalizedString("Your session has been expired. Please login again.", comment: "Session Expired")
        }
    }
}
