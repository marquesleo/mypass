//
//  CategoriaDetailUIState.swift
//  MyPass
//
//  Created by Leonardo Marques on 30/10/23.
//

import Foundation
enum CategoriaDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
