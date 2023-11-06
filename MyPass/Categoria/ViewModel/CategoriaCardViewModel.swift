//
//  CategoriaCardViewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 25/10/23.
//

import Foundation
import SwiftUI

struct CategoriaCardViewModel: Identifiable, Equatable {
    var id: UUID = UUID()
    var icon:String = ""
    var name:String = "E-mail"
    var state:Color = .green
    var ativo:Bool = true
    
    static func == (lhs: CategoriaCardViewModel, rhs: CategoriaCardViewModel) -> Bool {
        return lhs.id == rhs.id
        
    }
}

extension CategoriaCardViewModel {
    func CategoriaDetailView() -> some View {
        return CategoriaCardViewRouter.makeCategoriaDetailView(id: self.id
                                                               ,descricao: self.name)
    }
}
