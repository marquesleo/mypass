//
//  SignInUIState.swift
//  MyPass
//
//  Created by Leonardo Marques on 14/10/23.
//

import Foundation

enum SignInUIState : Equatable{
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
