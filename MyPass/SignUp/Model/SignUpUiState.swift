//
//  SignUpUiState.swift
//  MyPass
//
//  Created by Leonardo Marques on 14/10/23.
//

import Foundation

enum SignUpUIState : Equatable {
    case none
    case loading
    case success
    case updateUser
    case userUpdated
    case error(String)
}
