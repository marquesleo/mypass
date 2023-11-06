//
//  SignUpViewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 14/10/23.
//

import SwiftUI
import Combine


class SignUpViewModel: ObservableObject {
    
    @Published var uiState: SignUpUIState = .none
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var alteracao = false
    @Published var id = UUID()
    
    
    private let interactor: SignUPInteractor
    private var cancellableSignSave: AnyCancellable?
    private var cancellableSignUpdate: AnyCancellable?
    private var cancellableUserAuth: AnyCancellable?
    private var cancellableUserGet: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    
    init(interactor: SignUPInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellableSignSave?.cancel()
        cancellableSignIn?.cancel()
        cancellableUserAuth?.cancel()
        cancellableUserGet?.cancel()
        cancellableSignUpdate?.cancel()
    }
    
    var publisher: PassthroughSubject<Bool,Never>!
    
    
    func CarregarUsuario() -> Void {
        self.uiState = .loading
        self.cancellableUserGet = self.interactor.getUser(id: tokenEUsuario.shared.Id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
                switch(completion) {
                case .failure(let appError):
                    self.uiState =  SignUpUIState.error(appError.message)
                    break
                case .finished:
                    break
                }
            }receiveValue: { sucess in
                
                self.uiState = .updateUser
                self.alteracao = true
                self.email = sucess.email
                self.id = sucess.id
                self.username = sucess.username
                self.password = sucess.password
                
            }
        
    }
    
    func post(){
        
        self.uiState =  .loading
        
        let usuario = User(username: username, email: email, password: password)
        
        self.cancellableSignSave  =  self.interactor.save(usuario: usuario)
        
            .receive(on: DispatchQueue.main)
            .sink {
                completion in
                
                switch(completion) {
                case .failure(let appError):
                    self.uiState =  SignUpUIState.error(appError.message)
                    break
                case .finished:
                    break
                }
            }receiveValue: { success in
                if !success.id.uuidString.isEmpty {
                    
                    self.cancellableSignIn = self.interactor.login(username: usuario.username,password: usuario.password)
                    
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch(completion) {
                            case .failure(let appError):
                                self.uiState =  .error(appError.message)
                                break
                            case .finished:
                                break
                            }
                        } receiveValue: { succesLogado in
                            self.interactor.insertAuth(userAuth: UserAuth(id: succesLogado.Id,
                                                                          token: succesLogado.token,
                                                                          RefreshToken: succesLogado.RefreshToken,
                                                                          expira: succesLogado.expira))
                            
                            self.publisher.send(true)
                            self.uiState = .success
                        }
                    
                }
               
            }
        
        
       
    }
    
    func save()
    {
        if alteracao
        {
            update()
        }else{
            post()
        }
        
    }
    
    
    func update(){
        self.uiState =  .loading
        let usuario = User(username: username, email: email, password: password)
        usuario.id = self.id
        self.cancellableSignUpdate =  self.interactor.update(usuario: usuario)
        
            .receive(on: DispatchQueue.main)
            .sink {
                completion in
                
                switch(completion) {
                case .failure(let appError):
                    self.uiState =  SignUpUIState.error(appError.message)
                    break
                case .finished:
                    break
                }
            }receiveValue: { success in
                if success {
                   
                    self.cancellableSignIn = self.interactor.login(username: usuario.username,password: usuario.password)
                    
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch(completion) {
                        case .failure(let appError):
                            self.uiState =  .error(appError.message)
                            break
                        case .finished:
                            break
                        }
                    } receiveValue: { succesLogado in
                        self.interactor.insertAuth(userAuth: UserAuth(id: succesLogado.Id,
                                                                      token: succesLogado.token,
                                                                      RefreshToken: succesLogado.RefreshToken,
                                                                      expira: succesLogado.expira))
                        
                        self.publisher.send(true)
                        self.uiState = .userUpdated
                    }

                }
                
            }
    
        }
       
    
}
       


extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView(publisher: self.publisher)
        
    }
}



