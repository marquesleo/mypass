//
//  SignUpInteractor.swift
//  MyPass
//
//  Created by Leonardo Marques on 21/10/23.
//

import Combine
import Foundation


class SplashInteractor {
    
   private let local: LocalDataSource = .shared
   
}


extension SplashInteractor {
   
    
  
    func fetchAuth() -> Future<UserAuth?, Never> {
        return local.getUserAuth()
    }
    
       
}

