//
//  ServiceError.swift
//  MyPass
//
//  Created by Leonardo Marques on 16/10/23.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case network(Error)
    case decodeFail(Error)
    case custom(String)
    
    func erroDetail() -> String {
        switch self {
        case .invalidURL:
            return "URL inválida."
        case .network(let error):
            return "Erro de rede: \(error.localizedDescription)"
        case .custom(let message):
            return message
        case .decodeFail(let error):
            return "Erro ao decodificar: \(error.localizedDescription)"
        }
    }
}

