//
//  SenhaUpdateUIState.swift
//  MyPass
//
//  Created by Leonardo Marques on 08/11/23.
//

import Foundation
enum SenhaUpdateUIState : Equatable {
    case none
    case loading
    case fetchSuccess
    case fetchErro(String)
    
    case updateLoading
    case updateSuccess
    case updateErro(String)
    
}
