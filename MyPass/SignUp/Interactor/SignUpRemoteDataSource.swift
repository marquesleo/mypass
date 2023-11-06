//
//  SignUpRemoteDataSource.swift
//  MyPass
//
//  Created by Leonardo Marques on 21/10/23.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
    
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    private init() {
        
    }
    
    func save(usuario:User) -> Future<User, AppError>
    {
        
        let userService = UserService()
        return userService.save(usuario: usuario)
    }
    
    func update(usuario:User) -> Future<Bool, AppError>
    {
        
        let userService = UserService()
        return userService.update(usuario: usuario)
    }
    
    
    func getUser(id: UUID) -> Future<User, AppError> {
        let userService = UserService()
        return userService.get(id: id)
        
    }
}

