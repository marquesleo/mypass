//
//  ProfileUIState.swift
//  MyPass
//
//  Created by Leonardo Marques on 08/11/23.
//

import Foundation

enum ProfileUIState: Equatable {
    case none
    case loading
    case fetchSuccess
    case fetchErro(String)
    
    case updateLoading
    case updateSuccess
    case updateErro(String)
}
