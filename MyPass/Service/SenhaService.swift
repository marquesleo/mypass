//
//  SenhaService.swift
//  MyPass
//
//  Created by Leonardo Marques on 24/10/23.
//

import Foundation
import Combine

class SenhaService {
    func getAll(idUsuario:UUID) -> Future<[MinhaSenha], AppError>
            
    {
        return Future<[MinhaSenha], AppError> { promise  in
            ServiceBase.call(path: .getAllSenha(idUsuario: idUsuario),
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
                    decoder.dateDecodingStrategy = .iso8601
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                   
                    //do {
                        let response = try?  decoder.decode([MinhaSenha].self, from: data)
                        guard let response = response else {
                            let msg  = String(data:data, encoding: .utf8)
                            let err = String(data:data, encoding: .utf8)!
                            print("Log: Error parser \(String(data:data, encoding: .utf8)!)")
                            return
                        }
                        promise(.success(response))
                        break
                    //}
                    //catch {
                    //    print("Erro na deserialização: \(error)")
                   // }
                }
                
            }
        }
      
    }
    
    
    
    
    func get(id:UUID) -> Future<MinhaSenha, AppError>
            
    {
        return Future<MinhaSenha, AppError> { promise  in
            ServiceBase.call(path: .getSenha(id: id),
                             method:.GET,
                             utilizaToken: true)
            { result in
                
                
                switch result
                {
                case .failure(let error, let data):
                    if let data = data {
                        
                        if (error == .badRequest) {
                            let decoder =  JSONDecoder()
                            let msg  = String(data:data, encoding: .utf8)
                            let response = try?  decoder.decode(MeuErro.self, from: data)
                            promise(.failure(AppError.response(message: response?.message ?? "Erro desconhecido no servidor")))
                        }
                    }
                    break
                case .success(let data):
                    let decoder =  JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    
                    let response = try?  decoder.decode(MinhaSenha.self, from: data)
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
    
    
    func delete(id:UUID) -> Future<Bool, AppError>
            
    {
        return Future<Bool, AppError> { promise  in
            ServiceBase.call(path: .getSenha(id: id),
                             method:.DELETE,
                             utilizaToken: true)
            { result in
                
                
                switch result
                {
                case .failure(let error, let data):
                    if let data = data {
                        
                        if (error == .badRequest) {
                            let decoder =  JSONDecoder()
                            //let msg  = String(data:data, encoding: .utf8)
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
    
    
    func update(senha:MinhaSenha) -> Future<Bool, AppError>
    {
        return Future<Bool, AppError> { promise  in
            
            ServiceBase.call(path: .getSenha(id: senha.Id),
                             method:.PUT,
                             body: senha,
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
    
    
    
    
    func save(senha:MinhaSenha) -> Future<MinhaSenha, AppError>
    {
        return Future<MinhaSenha, AppError> { promise  in
            
            ServiceBase.call(path: .postSenha,
                             method:.POST,
                             body: senha,
                             utilizaToken: true) { result in
                
                
                switch result
                {
                case .failure(let error, let data):
                    if let data = data {
                        
                        if (error == .badRequest) {
                            let decoder =  JSONDecoder()
                            let response = try?  decoder.decode(MeuErro.self, from: data)
                            
                            _ = String(data:data, encoding: .utf8)!
                            print("Log: Error parser \(String(data:data, encoding: .utf8)!)")
                            promise(.failure(AppError.response(message: response?.message ?? "Erro desconhecido no servidor")))
                        }
                    }
                    break
                case .success(let data):
                    let decoder =  JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    
                    
                    let response = try?  decoder.decode(MinhaSenha.self, from: data)
                    guard let response = response else {
                        _ = String(data:data, encoding: .utf8)!
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
