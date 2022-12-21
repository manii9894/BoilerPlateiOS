//
//  APIs.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation

enum ServerEnvironment: String {
    
    case local = ""
    case staging = "staging"
    case production = "production"
    
    static var baseUrl: String {
        ServerEnvironment.staging.rawValue
    }
    
}

enum Endpoint {
    
    case login
    
    var urlString: String {
        get {
            switch self {
            case .login:
                return ServerEnvironment.baseUrl + "api/v1/auth/login"
            }
        }
    }
    
}

enum APIMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum APIState {
    
    case uncalled
    case success(String?)
    case error(String)
    
}
