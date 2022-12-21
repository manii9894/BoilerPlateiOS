//
//  UserDefaults.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 18/03/2022.
//

import Foundation

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode, noValue, unableToDecode
    
    var errorDescription: String {
        switch self {
        case .unableToEncode:
            return LocalizationHandler.getLocalizedString(for: .unableToEncode)
        case .noValue:
            return LocalizationHandler.getLocalizedString(for: .noValue)
        case .unableToDecode:
            return LocalizationHandler.getLocalizedString(for: .unableToDecode)
        }
    }
}

extension UserDefaults: ObjectSavable {
    
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
    
}
