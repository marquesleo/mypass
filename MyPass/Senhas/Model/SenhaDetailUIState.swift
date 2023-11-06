//
//  SenhaDetailUIState.swift
//  MyPass
//
//  Created by Leonardo Marques on 26/10/23.
//

import Foundation

enum SenhaDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
    case deleteSuccess
}
