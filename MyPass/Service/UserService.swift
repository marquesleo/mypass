//
//  Service.swift
//  MyPass
//
//  Created by Leonardo Marques on 16/10/23.
//

import Foundation
import Combine

class UserService {
    
    
    func get(id:UUID) -> Future<User, AppError>
            
    {
        return Future<User, AppError> { promise  in
            ServiceBase.call(path: .getUser(id: id),
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
                    
                    let response = try?  decoder.decode(User.self, from: data)
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
    
    
    func update(usuario:User) -> Future<Bool, AppError>
    {
        return Future<Bool, AppError> { promise  in
            
            ServiceBase.call(path: .getUser(id: usuario.id),
                             method:.PUT,
                             body: usuario,
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
    
    
    func save(usuario:User) -> Future<User, AppError>
    {
        return Future<User, AppError> { promise  in
            
            ServiceBase.call(path: .postUser,
                             method:.POST,
                             body: usuario,
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
                    
                    
                    let response = try?  decoder.decode(User.self, from: data)
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

        
      

