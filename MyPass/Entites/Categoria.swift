//
//  Categoria.swift
//  MyPass
//
//  Created by Leonardo Marques on 26/10/23.
//

import Foundation

struct Categoria: Codable {
    let id: UUID
    let descricao:String
    let icon:String?
    let ativo:Bool
    let usuario_id:UUID
    
    enum CodingKeys: String , CodingKey {
        case id = "Id"
        case descricao = "Descricao"
        case icon = "icon"
        case ativo = "Ativo"
        case usuario_id = "Usuario_Id"
        
    }
    
}
