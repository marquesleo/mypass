//
//  UserLogado.swift
//  MyPass
//
//  Created by Leonardo Marques on 14/10/23.
//

import SwiftUI

struct UserLogado: Decodable {
    
    
    
    var Id: UUID
    var Username: String
    var token: String
    var RefreshToken: String
    var expira: Date
    
    enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case Username = "Username"
        case token = "token"
        case RefreshToken = "RefreshToken"
        case expira = "expira"
    }
}
