//
//  Validators.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 28/04/2022.
//

import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws
}

enum ValidatorType {
    case email
    case password
    case fullname
    case phone
    case URL
    case requiredField(field: String)
    case selectionField(field: String)
}

enum ValidatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .fullname: return FullNameValidator()
        case .phone: return PhoneNumberValidator()
        case .URL: return URLValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .selectionField(let fieldName): return SelectionValidator(fieldName)
        }
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws {
        guard !value.isEmpty else {
            throw ValidationError(fieldName + " is required")
        }
    }
}

struct FullNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws {
        guard value.count >= 3 else {
            throw ValidationError("Name must contain at least three characters" )
        }
        guard value.count < 19 else {
            throw ValidationError("Name shoudn't contain more than 18 characters" )
        }
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws {
        guard value != "" else {throw ValidationError("Password is Required")}
        guard value.count >= 6 else { throw ValidationError("Password must have at least 6 characters") }
        
        do {
            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
            }
        } catch {
            throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
        }
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
    }
}

struct URLValidator: ValidatorConvertible {
    func validated(_ value: String) throws {
        do {
            if try NSRegularExpression(pattern: "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid URL")
            }
        } catch {
            throw ValidationError("Invalid URL")
        }
    }
}

struct PhoneNumberValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws {
        do {
            if try NSRegularExpression(pattern: "^\\s*\\+?\\s*([0-9][\\s-]*){10,}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid phone number")
            }
        } catch {
            throw ValidationError("Invalid phone number")
        }
    }
    
}

struct SelectionValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws {
        guard !value.isEmpty else {
            throw ValidationError("Please select \(fieldName)")
        }
    }
}
