//
//  ProfileInteractor.swift
//  MyPass
//
//  Created by Leonardo Marques on 08/11/23.
//

import Combine
import Foundation


class ProfileInteractor {
    
    private let remoteProfile: ProfileRemoteDataSource = .shared
 }


extension ProfileInteractor {
    
        
    func getUser(id: UUID) -> Future<User, AppError>
    {
        
        return remoteProfile.getUser(id: id)
    }
    
    func update(usuario:User) -> Future<Bool, AppError>
    {   return remoteProfile.update(usuario: usuario)
    }
    
    
    
       
}


