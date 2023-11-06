//
//  SenhaVIewRouter.swift
//  MyPass
//
//  Created by Leonardo Marques on 31/10/23.
//

import SwiftUI
import Combine

enum SenhaViewRouter {
    static func makeCrudSenhaView(senhaViewNovoCadastro:PassthroughSubject<Bool,Never>) -> some View
    {
        let viewModel = CrudSenhaViewModel(interactor: CrudSenhaInteractor())
        viewModel.senhaNovoCadastroPublisher = senhaViewNovoCadastro
        return CrudSenhaView(viewModel: viewModel, alteracao: false, id: UUID())
    }
  
}
