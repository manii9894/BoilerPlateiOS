//
//  JSONParsable.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 10/05/2022.
//

import Foundation

protocol JSONParsable: Codable {
    
}

extension JSONParsable {
    
    func getJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
}
