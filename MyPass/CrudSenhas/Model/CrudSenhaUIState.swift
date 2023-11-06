//
//  CrudSenhaUIState.swift
//  MyPass
//
//  Created by Leonardo Marques on 24/10/23.
//

import Foundation

enum CrudSenhaUIState : Equatable {
    case none
    case loading
    case update
    case success
    case error(String)
}
