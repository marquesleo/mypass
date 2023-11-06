//
//  Service.swift
//  MyPass
//
//  Created by Leonardo Marques on 14/10/23.
//

import Foundation
import Combine

class LoginService {
    
    func login(username:String,
               password:String) ->
               Future<UserLogado, AppError>
    {
        
        let usuario = User(username: username,
                           email: "teste@gmail.com",
                           password: password)
        
        
        return Future<UserLogado, AppError> { promise  in
            
            ServiceBase.call(path: .loginUser,
                             method:.POST,
                             body: usuario,
                             utilizaToken: false ) { result in
                
                
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
                    
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let response = try?  decoder.decode(UserLogado.self, from: data)
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
