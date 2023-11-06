//
//  SignInViewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 13/10/23.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
        
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    
    
    private let publisher = PassthroughSubject<Bool,Never>()
    private let interactor: SignInInteractor
    
    
    @Published var uiState: SignInUIState = .none
    @Published var username = ""
    @Published var password = ""
    
    
    init (interactor: SignInInteractor ){
        self.interactor = interactor
        cancellable = publisher.sink{ value in
         print("usuário criado! goToHome: \(value)")
            
            if (value)
            {
                self.uiState = .goToHomeScreen
            }
      }
    }
    
    deinit{
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    
    func login(){
        
        self.uiState =  .loading
       
        cancellableRequest =  interactor.login(username: username,
                                               password: password)
        
        .receive(on: DispatchQueue.main)
        .sink { completion in
            
            switch(completion) {
            case .failure(let appError):
                self.uiState =  SignInUIState.error(appError.message)
                break
            case .finished:
                break
            }
        }receiveValue: { sucess in
            self.interactor.insertAuth(userAuth: UserAuth(id: sucess.Id,
                                                          token: sucess.token,
                                                          RefreshToken: sucess.RefreshToken,
                                                          expira: sucess.expira))
            self.uiState = .goToHomeScreen
        }
       
    }
}

extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView(publisher: publisher)
        
    }
}

extension SignInViewModel {
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
        
    }
}
