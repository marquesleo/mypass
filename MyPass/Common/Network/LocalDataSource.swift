//
//  LocalDataSource.swift
//  MyPass
//
//  Created by Leonardo Marques on 21/10/23.
//

import Foundation
import Combine

class LocalDataSource {
    
    static var shared: LocalDataSource = LocalDataSource()
    
    private init() {
        
    }
    
    private func saveValue(value: UserAuth) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value),
                                  forKey: "user_key")
    }
    
    
    private func readValue(forKey key:String) -> UserAuth {
        var userAuth: UserAuth
        
        // Inicialize userAuth com um valor padrão
        userAuth = UserAuth(id: UUID(), token: "", RefreshToken: "", expira: Date())
        
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            
            userAuth = try! PropertyListDecoder().decode(UserAuth.self, from: data)
     
        }else{
            let uuidForEmptyString = UUID(uuidString: "00000000-0000-0000-0000-000000000000")
            
            if let uuid = uuidForEmptyString {
                userAuth = UserAuth(id: uuid, token: "", RefreshToken: "", expira: Date())
            }
            
            
           
          
        }
        return userAuth
    }
}

extension LocalDataSource {
    
    func insertUserAuth(userAuth: UserAuth){
        
        saveValue(value: userAuth)
    }
    
    func getUserAuth() -> Future<UserAuth?, Never> {
        let userAuth = readValue(forKey: "user_key")
        return Future { promise in
            promise(.success(userAuth))
        }
    }
    
    
}
