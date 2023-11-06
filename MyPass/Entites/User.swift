//
//  User.swift
//  MyPass
//
//  Created by Leonardo Marques on 14/10/23.
//

import Foundation

class User: Identifiable, Codable {
    var id = UUID()
    var username:String
    var email:String
    var password:String
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
    
    enum CodingKeys: String, CodingKey {
        case username = "Username"
        case email = "Email"
        case password = "Password"
        case id = "Id"
            
    }
}
