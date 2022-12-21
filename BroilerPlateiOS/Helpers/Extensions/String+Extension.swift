//
//  String+Extension.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 27/04/2022.
//

import Foundation

extension String {
    
    var containsSpecialCharacter: Bool {
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    func isTextLimitReached(limit: Int) -> Bool {
        return (self.count - 1) == limit
    }
    
    func getMaskedString(pattern: String) -> String {
        
        var result = ""
        var index = self.startIndex
        for ch in pattern where index < self.endIndex {
            if ch == "#" {
                result.append(self[index])
                index = self.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
        
    }
    
    func validatedText(validationType: ValidatorType) throws {
        let validator = ValidatorFactory.validatorFor(type: validationType)
        return try validator.validated(self)
    }
    
    func isSpacingValid(restrictSpacing: Bool) -> Bool {
        
        if restrictSpacing && self.contains(" ") { return false }
        if self == " " {
            return false
        } else if self.contains("  ") {
            return false
        }
        return true
        
    }
    
    func localToUTC(inFormat: DateFormats = .yyyyMMddHHmmSSZ, outFormat: DateFormats = .MMMdhmma) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inFormat.name
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outFormat.name
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            return dateFormatter.string(from: date)
        }
        return ""
        
    }
    
    func UTCToLocal(inFormat: DateFormats = .yyyyMMddHHmmSSZ, outFormat: DateFormats = .MMMdhmma) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inFormat.name
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outFormat.name
            dateFormatter.timeZone = TimeZone.current
            return dateFormatter.string(from: date)
        }
        return ""
        
    }
    
    var localized: String {
        return localize(withBundle: Bundle.main)
    }
    
    private func localize(withBundle bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
}
