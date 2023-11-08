//
//  CategoriaRemoteDataSource.swift
//  MyPass
//
//  Created by Leonardo Marques on 26/10/23.
//


import Foundation
import Combine

class SenhaRemoteDataSource {
    
    static var shared: SenhaRemoteDataSource = SenhaRemoteDataSource()
    
    private init() {
        
    }
    
    func GetAll() -> Future<[MinhaSenha], AppError>
    {
        let senhaService = SenhaService()
        let idUsuario = tokenEUsuario.shared.Id
        return  senhaService.getAll(idUsuario: idUsuario)
    }
    
    func Get(id:UUID) -> Future<MinhaSenha, AppError>
    {
        let senhaService = SenhaService()
        return  senhaService.get(id: id)
    }
    
    func Save(minhaSenha:MinhaSenha) -> Future<MinhaSenha, AppError>
    {
        let senhaService = SenhaService()
        return  senhaService.save(senha: minhaSenha)
    }
    
    func Update(minhaSenha:MinhaSenha) -> Future<Bool, AppError>
    {
        let senhaService = SenhaService()
        return  senhaService.update(senha: minhaSenha)
    }
    
}

