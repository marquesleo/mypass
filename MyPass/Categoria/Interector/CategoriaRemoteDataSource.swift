//
//  CategoriaRemoteDataSource.swift
//  MyPass
//
//  Created by Leonardo Marques on 26/10/23.
//


import Foundation
import Combine

class CategoriaRemoteDataSource {
    
    static var shared: CategoriaRemoteDataSource = CategoriaRemoteDataSource()
    
    private init() {
        
    }
    
    func GetAllCategoria() -> Future<[Categoria], AppError>
    {
        let categoriaService = CategoriaService()
        let idUsuario = tokenEUsuario.shared.Id
        return  categoriaService.getAll(idUsuario: idUsuario)
    }
    
    func Get(id:UUID) -> Future<Categoria, AppError>
    {
        let categoriaService = CategoriaService()
        return  categoriaService.get(id: id)
    }
    
    func Save(categoria:Categoria) -> Future<Categoria, AppError>
    {
        let categoriaService = CategoriaService()
        return  categoriaService.save(categoria: categoria)
    }
    
    func Update(categoria:Categoria) -> Future<Bool, AppError>
    {
        let categoriaService = CategoriaService()
        return  categoriaService.update(categoria: categoria)
    }
    
}

