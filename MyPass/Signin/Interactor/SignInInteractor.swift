//
//  SignInInteractor.swift
//  MyPass
//
//  Created by Leonardo Marques on 21/10/23.
//
import Combine
import Foundation


class SignInInteractor {
    
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
 
}


extension SignInInteractor {
    func login(username: String,
               password: String) -> Future<UserLogado, AppError>
    {
        
       return remoteSignIn.login(username: username,
                     password: password)
    }
    
    
    func insertAuth(userAuth: UserAuth){
        local.insertUserAuth(userAuth: userAuth)
        tokenEUsuario.shared.Id = userAuth.id
        tokenEUsuario.shared.Token = userAuth.token
    }
    
      
}
