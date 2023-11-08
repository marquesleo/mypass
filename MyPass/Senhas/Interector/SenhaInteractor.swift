//
//  CategoriaInterector.swift
//  MyPass
//
//  Created by Leonardo Marques on 26/10/23.
//

import Combine
import Foundation


class SenhaInteractor {
    
    private let remoteSenhaDataSource: SenhaRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
 
}


extension SenhaInteractor {
   
    func getAll() -> Future<[MinhaSenha], AppError>
    {
        
        return remoteSenhaDataSource.GetAll()
    }
    
    func Get(id:UUID) -> Future<MinhaSenha, AppError>
    {
        return remoteSenhaDataSource.Get(id: id)
    }
    
    func Save(minhaSenha:MinhaSenha) -> Future<MinhaSenha, AppError>
    {
        return remoteSenhaDataSource.Save(minhaSenha: minhaSenha)
    }
    
    func Update(minhaSenha:MinhaSenha) -> Future<Bool, AppError>
    {
        return remoteSenhaDataSource.Update(minhaSenha: minhaSenha)
    }
      
}

