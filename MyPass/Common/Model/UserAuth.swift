//
//  UserAuth.swift
//  MyPass
//
//  Created by Leonardo Marques on 21/10/23.
//

import Foundation

struct UserAuth: Codable {
    var id: UUID
    var token: String
    var RefreshToken: String
    var expira: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case token = "token"
        case RefreshToken = "RefreshToken"
        case expira = "expira"
    }
}
