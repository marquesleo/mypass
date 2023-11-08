//
//  ProfileRemoteDataSource.swift
//  MyPass
//
//  Created by Leonardo Marques on 08/11/23.
//

import Foundation
import Combine

class ProfileRemoteDataSource {
    
    static var shared: ProfileRemoteDataSource = ProfileRemoteDataSource()
    
    private init() {
        
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


