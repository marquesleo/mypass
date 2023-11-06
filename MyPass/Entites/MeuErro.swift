//
//  Error.swift
//  MyPass
//
//  Created by Leonardo Marques on 14/10/23.
//

struct MeuErro : Decodable {
    var message: String
    enum CodingKeys: String, CodingKey {
        case message
       
    }
}
