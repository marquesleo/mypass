//
//  CategoriaDetailViewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 07/11/23.
//

import Foundation
import Combine

class CategoriaDetailViewModel: ObservableObject {
    @Published var uiState: CategoriaDetailUIState = .loading
    var Id:UUID
    var Descricao:String
    
    init(id:UUID, descricao:String){
        self.Id = id
        self.Descricao = descricao
        
    }
    
}
