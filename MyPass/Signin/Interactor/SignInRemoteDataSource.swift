//
//  RemoteDataSource.swift
//  MyPass
//
//  Created by Leonardo Marques on 21/10/23.
//

import Foundation
import Combine

class SignInRemoteDataSource {
    
    static var shared: SignInRemoteDataSource = SignInRemoteDataSource()
    
    private init() {
        
    }
    
    func login(username: String,
               password: String) -> Future<UserLogado, AppError>
    {
        
        let loginService = LoginService()
        return loginService.login(username: username, password:  password)
    }
}
