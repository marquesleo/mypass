//
//  SignInViewRouter.swift
//  MyPass
//
//  Created by Leonardo Marques on 14/10/23.
//

import SwiftUI
import Combine

enum HomeViewRouter {
   
    static func makeSignUpView(publisher: PassthroughSubject<Bool,Never>) -> some View {
        let viewModel = SignUpViewModel(interactor: SignUPInteractor() )
        viewModel.publisher = publisher
        return SignUpView(viewModel: viewModel, alteracao: true)
    }
    
    static func makeCrudSenhaView() -> some View {
        let viewModel = CrudSenhaViewModel(interactor: CrudSenhaInteractor() )
        return CrudSenhaView(viewModel: viewModel, alteracao: false, id: UUID())
    }
    
    static func makeCategoriaView(viewModel:CategoriaViewModel) -> some View {
      
        return CategoriaView(viewModel: viewModel)
    }
    
    static func makeSenhaView(viewModel:SenhaViewModel) -> some View {
      
        return SenhaView(viewModel: viewModel)
    }
    
    static func makeProfileView(viewModel: ProfileViewModel) -> some View {
      
        return ProfileView(viewModel: viewModel)
    }
    
}
