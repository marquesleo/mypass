//
//  CategoriaInterector.swift
//  MyPass
//
//  Created by Leonardo Marques on 26/10/23.
//

import Combine
import Foundation


class CategoriaInInteractor {
    
    private let remoteCategoriaDataSource: CategoriaRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
 
}


extension CategoriaInInteractor {
   
    func getAllCategoria() -> Future<[Categoria], AppError>
    {
        
        return remoteCategoriaDataSource.GetAllCategoria()
    }
    
    func Get(id:UUID) -> Future<Categoria, AppError>
    {
        return remoteCategoriaDataSource.Get(id: id)
    }
    
    func Save(categoria:Categoria) -> Future<Categoria, AppError>
    {
        return remoteCategoriaDataSource.Save(categoria: categoria)
    }
    
    func Update(categoria:Categoria) -> Future<Bool, AppError>
    {
        return remoteCategoriaDataSource.Update(categoria: categoria)
    }
      
}

