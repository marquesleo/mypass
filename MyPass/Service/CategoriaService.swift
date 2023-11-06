//
//  CategoriaService.swift
//  MyPass
//
//  Created by Leonardo Marques on 26/10/23.
//

import Foundation
import Combine

class CategoriaService {
    
    
    func getAll(idUsuario:UUID) -> Future<[Categoria], AppError>
            
    {
        return Future<[Categoria], AppError> { promise  in
            ServiceBase.call(path: .getAllCategoria(idUsuario: idUsuario),
                             method:.GET,
                             utilizaToken: true)
            { result in
                
                
                switch result
                {
                case .failure(let error, let data):
                    if let data = data {
                        
                        if (error == .badRequest) {
                            let decoder =  JSONDecoder()
                            let response = try?  decoder.decode(MeuErro.self, from: data)
                            promise(.failure(AppError.response(message: response?.message ?? "Erro desconhecido no servidor")))
                        }
                    }
                    break
                case .success(let data):
                    let decoder =  JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    
                    let response = try?  decoder.decode([Categoria].self, from: data)
                    guard let response = response else {
                        print("Log: Error parser \(String(data:data, encoding: .utf8)!)")
                        return
                    }
                    promise(.success(response))
                    break
                }
                
            }
        }
      
    }
    
    func get(id:UUID) -> Future<Categoria, AppError>
            
    {
        return Future<Categoria, AppError> { promise  in
            ServiceBase.call(path: .getCategoria(id:id),
                             method:.GET,
                             utilizaToken: true)
            { result in
                
                
                switch result
                {
                case .failure(let error, let data):
                    if let data = data {
                        
                        if (error == .badRequest) {
                            let decoder =  JSONDecoder()
                            let response = try?  decoder.decode(MeuErro.self, from: data)
                            promise(.failure(AppError.response(message: response?.message ?? "Erro desconhecido no servidor")))
                        }
                    }
                    break
                case .success(let data):
                    let decoder =  JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    
                    let response = try?  decoder.decode(Categoria.self, from: data)
                    guard let response = response else {
                        print("Log: Error parser \(String(data:data, encoding: .utf8)!)")
                        return
                    }
                    promise(.success(response))
                    break
                }
                
            }
        }
      
    }
    
    
    
    func update(categoria:Categoria) -> Future<Bool, AppError>
    {
        return Future<Bool, AppError> { promise  in
            
            ServiceBase.call(path: .getCategoria(id: categoria.id),
                             method:.PUT,
                             body: categoria,
                             utilizaToken:  true) { result in
                
                switch result
                {
                case .failure(let error, let data):
                    if let data = data {
                        
                        if (error == .badRequest) {
                            let decoder =  JSONDecoder()
                            let response = try?  decoder.decode(MeuErro.self, from: data)
                            promise(.failure(AppError.response(message: response?.message ?? "Erro desconhecido no servidor")))
                        }
                    }
                    break
                case .success(_):
                    promise(.success(true))
                    break
                }
                
            }
            
        }
    }
    
    
    func save(categoria:Categoria) -> Future<Categoria, AppError>
    {
        return Future<Categoria, AppError> { promise  in
            
            ServiceBase.call(path: .postCategoria,
                             method:.POST,
                             body: categoria,
                             utilizaToken: false) { result in
                
                
                switch result
                {
                case .failure(let error, let data):
                    if let data = data {
                        
                        if (error == .badRequest) {
                            let decoder =  JSONDecoder()
                            let response = try?  decoder.decode(MeuErro.self, from: data)
                            promise(.failure(AppError.response(message: response?.message ?? "Erro desconhecido no servidor")))
                        }
                    }
                    break
                case .success(let data):
                    let decoder =  JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    
                    
                    let response = try?  decoder.decode(Categoria.self, from: data)
                    guard let response = response else {
                        print("Log: Error parser \(String(data:data, encoding: .utf8)!)")
                        return
                    }
                    promise(.success(response))
                    break
                }
                
            }
            
        }
    }
    
}

        
      


