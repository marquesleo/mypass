//
//  SenhaCardViewRouter.swift
//  MyPass
//
//  Created by Leonardo Marques on 30/10/23.
//

import SwiftUI
import Combine
enum SenhaCardViewRouter {
    static func makeSenhaDetailView(id: UUID,
                                    descricao: String,
                                    observacao: String,
                                    usuario: String,
                                    site: String,
                                    password:String,
                                    senhaViewPublisher: PassthroughSubject<Bool,Never>) -> some View {
        
        let viewModel = SenhaDetailViewModel(id: id,
                                             descricao: descricao,
                                             observacao: observacao,
                                             usuario: usuario,
                                             site: site,
                                             password: password)
        
        viewModel.senhaViewPublisher = senhaViewPublisher
      
        return SenhaDetailView(viewModel: viewModel)
    }
    
    static func makeCrudSenhaView(Id:UUID) -> some View
    {
        let viewModel = CrudSenhaViewModel(interactor: CrudSenhaInteractor())
        
        return CrudSenhaView(viewModel: viewModel, alteracao: false, id: Id)
    }
    
    static func updateCrudSenhaView(Id:UUID, senhaPublisher:PassthroughSubject<Bool,Never>) -> some View
    {
        let viewModel = CrudSenhaViewModel(interactor: CrudSenhaInteractor())
        viewModel.senhaPublisher = senhaPublisher
        return CrudSenhaView(viewModel: viewModel, alteracao: true, id: Id)
    }
  
}

