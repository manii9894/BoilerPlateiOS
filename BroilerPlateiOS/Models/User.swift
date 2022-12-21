//
//  User.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 05/04/2022.
//

import Foundation

struct User: Codable {
    
    var id, email, name: String
    var profilePic, phoneNumber, userId: String
    var loginType: LoginType
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, name, profilePic, phoneNumber, userId, loginType
    }
    
    init(id: String = "", email: String, name: String, profilePic: String = "", phoneNumber: String = "", userId: String, loginType: LoginType) {
        
        self.id = id
        self.email = email
        self.name = name
        self.profilePic = profilePic
        self.phoneNumber = phoneNumber
        self.userId = userId
        self.loginType = loginType
        
    }

    func getDictionary() -> [String: Any] {
        
        let params: [String: Any] = [
            "userId"        :   userId,
            "name"          :   name,
            "email"         :   email,
            "profilePic"    :   profilePic,
            "phoneNumber"   :   phoneNumber,
            "loginType"     :   loginType.rawValue
        ]
        return params
        
    }
    
}

enum LoginType: String, Codable {
    case google, apple, facebook
}
