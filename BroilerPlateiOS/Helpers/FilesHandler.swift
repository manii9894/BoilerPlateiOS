//
//  FilesHandler.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 10/06/2022.
//

import Foundation

class FilesHandler {
    
    static let shared = FilesHandler()
    
    private init() {}
    
    func removeFile(at url: URL) {
        
        if FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.removeItem(at: url)
        }
        
    }
    
}
