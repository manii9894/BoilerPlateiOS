//
//  Date+Extension.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 27/04/2022.
//

import Foundation

extension Date {
    
    func getString(format: DateFormats = .mmDDYYYYY) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.name
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
        
    }
    
    func localToUTC(format: DateFormats = .ddMMYYYYYhhmma) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.name
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        let dateString = dateFormatter.string(from: self)
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            return dateFormatter.string(from: date)
        }
        return ""
        
    }
    
    func UTCToLocal(inFormat: DateFormats = .ddMMYYYYYhhmma, outFormat: DateFormats = .ddMMYYYYYhhmma) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inFormat.name
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateString = dateFormatter.string(from: self)
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = outFormat.name
            return dateFormatter.string(from: date)
        }
        return ""
        
    }
    
}
