//
//  GenericResponse.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 13/04/2022.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    
    var code: Int
    var message: String
    var data: T
    var totalPages: Int?
    var pageLimit: Int?
    var currentPage: Int?
    
}
