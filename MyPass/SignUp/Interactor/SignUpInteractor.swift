//
//  SignUpInteractor.swift
//  MyPass
//
//  Created by Leonardo Marques on 21/10/23.
//

import Combine
import Foundation


class SignUPInteractor {
    
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
   
}


extension SignUPInteractor {
    func save(usuario:User) -> Future<User, AppError>
    {   return remoteSignUp.save(usuario: usuario)
    }
    
    func update(usuario:User) -> Future<Bool, AppError>
    {   return remoteSignUp.update(usuario: usuario)
    }
    
    func login(username:String, password:String)-> Future<UserLogado, AppError> {
        return remoteSignIn.login(username: username,
                                  password: password)
    }
        
    func getUser(id: UUID) -> Future<User, AppError>
    {
        return remoteSignUp.getUser(id: id)
    }
    
    func insertAuth(userAuth: UserAuth){
        local.insertUserAuth(userAuth: userAuth)
    }
    
    func fetchAuth() -> Future<UserAuth?, Never> {
        return local.getUserAuth()
    }
    
       
}

