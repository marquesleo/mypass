//
//  CrudSenhaInteractor.swift
//  MyPass
//
//  Created by Leonardo Marques on 24/10/23.
//

import Combine
import Foundation


class CrudSenhaInteractor {
    
    private let remoteCrudSenha: CrudSenhaRemoteDataSource = .shared
      
}

extension CrudSenhaInteractor {
    func save(senha:MinhaSenha) -> Future<MinhaSenha, AppError>
    {   return remoteCrudSenha.save(senha: senha)
    }
    
    func update(senha:MinhaSenha) -> Future<Bool, AppError>
    {   return remoteCrudSenha.update(senha: senha)
    }
             
    func getSenha(id: UUID) -> Future<MinhaSenha, AppError>
    {
        return remoteCrudSenha.getSenha(id: id)
    }
    
    func deleteSenha(id: UUID) -> Future<Bool, AppError>
    {
        return remoteCrudSenha.deleteSenha(id: id)
    }
    
       
}

