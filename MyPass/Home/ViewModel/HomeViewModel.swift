//
//  HomeViewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 14/10/23.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var uiState: SignInUIState = .none
    private let viewModel = CategoriaViewModel(interactor: CategoriaInInteractor())
    private let viewModelSenha = SenhaViewModel(interactor: SenhaInteractor())
    
    private let publisher = PassthroughSubject<Bool,Never>()
    private var cancellable: AnyCancellable?
    init ( ){
          cancellable = self.publisher.sink{ value in
           print("usuário alterado! goToHome: \(value)")
                
                if (value)
                {
                   // self.uiState = .goToHomeScreen
                }
            }
        
    }
    
    deinit{
        cancellable?.cancel()
      
    }
}


extension HomeViewModel {
    func signUpView() -> some View {
        return HomeViewRouter.makeSignUpView(publisher: publisher)
        
    }
    
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView()
    }
    
    func CrudSenhaView() -> some View {
        return HomeViewRouter.makeCrudSenhaView()
        
    }
    
    func SenhaView() -> some View {
        return HomeViewRouter.makeSenhaView(viewModel: self.viewModelSenha)
        
    }
    
    func CategoriaView() -> some View {
        return HomeViewRouter.makeCategoriaView(viewModel: self.viewModel)
        
    }
}
