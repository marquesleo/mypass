//
//  MeuLogin.swift
//  MyPass
//
//  Created by Leonardo Marques on 16/10/23.
//

import Foundation

class MeuLogin{
    public let tokenEUsuario: tokenEUsuario = .shared
      
}

class tokenEUsuario {
    
    static var shared: tokenEUsuario = tokenEUsuario(Id: UUID(), Token: "")
    
    private init(Id:UUID,Token:String ) {
        self.Id  = Id
        self.Token = Token
    }
    var Id: UUID
    var Token: String
}
