//
//  MultipartFormDataRequest.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation

struct MultipartFormDataRequest {
    
    private let boundary: String = "Boundary-\(UUID().uuidString)"
    private var httpBody = NSMutableData()
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func addTextField(named name: String, value: String) {
        httpBody.append(textFormField(named: name, value: value))
    }
    
    private func textFormField(named name: String, value: String) -> String {
        
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        return fieldString
        
    }
    
    func addDataField(media: MediaAttachment) {
        httpBody.append(dataFormField(named: media.key, fileName: media.fileName, data: media.data, mimeType: media.mimeType))
    }
    
    private func dataFormField(named name: String, fileName: String, data: Data, mimeType: String) -> Data {
        
        let fieldData = NSMutableData()
        fieldData.append("--\(boundary)\r\n")
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n")
        fieldData.append("Content-Type: \(mimeType)\r\n\r\n")
        fieldData.append(data)
        fieldData.append("\r\n")
        return fieldData as Data
        
    }
    
    func asURLRequest() -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        httpBody.append("--\(boundary)--")
        request.httpBody = httpBody as Data
        return request
        
    }
    
}

extension NSMutableData {
    
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
    
}
