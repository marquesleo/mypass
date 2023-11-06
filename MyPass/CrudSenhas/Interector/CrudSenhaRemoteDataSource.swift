//
//  CrudSenhaRemoteDataSource.swift
//  MyPass
//
//  Created by Leonardo Marques on 24/10/23.
//

import Foundation
import Combine

class CrudSenhaRemoteDataSource {
    
    static var shared: CrudSenhaRemoteDataSource = CrudSenhaRemoteDataSource()
    
    private init() {
        
    }
    
    func save(senha:MinhaSenha) -> Future<MinhaSenha, AppError>
    {
        let senhaService = SenhaService()
        return senhaService.save(senha: senha)
    }
    
    func update(senha:MinhaSenha) -> Future<Bool, AppError>
    {
        let senhaService = SenhaService()
        return senhaService.update(senha: senha)
    }
    
    func getSenha(id: UUID) -> Future<MinhaSenha, AppError> {
        let senhaService = SenhaService()
        return senhaService.get(id: id)
        
    }
    
    func deleteSenha(id: UUID) -> Future<Bool, AppError> {
        let senhaService = SenhaService()
        return senhaService.delete(id: id)
        
    }
}


