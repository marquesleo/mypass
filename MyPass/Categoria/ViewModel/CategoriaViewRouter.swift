//
//  CategoriaViewRouter.swift
//  MyPass
//
//  Created by Leonardo Marques on 31/10/23.
//

import SwiftUI
import Combine
enum CategoriaCardViewRouter {
    static func makeCategoriaDetailView(id: UUID,
                                        descricao: String) -> some View {
        
        let viewModel = CategoriaDetailViewModel(id: id, descricao: descricao)
      
        return CategoriaDetailView(viewModel: viewModel)
    }
    
    
  
}
