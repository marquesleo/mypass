//
//  CategoriaUIState.swift
//  MyPass
//
//  Created by Leonardo Marques on 25/10/23.
//

import Foundation

enum CategoriaUIState: Equatable, Identifiable {
    case loading
    case emptyList
    case fullList([CategoriaCardViewModel])
    case error(String)
    
    var id: String {
            switch self {
            case .loading:
                return "loading"
            case .emptyList:
                return "emptyList"
            case .fullList:
                return "fullList"
            case .error(let errorMessage):
                return "error_\(errorMessage)"
            }
        }
}
