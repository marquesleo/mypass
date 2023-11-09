//
//  ProfileViewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 08/11/23.
//

import Foundation
import Combine
class ProfileViewModel : ObservableObject {
    @Published var  uiState : ProfileUIState = .none
    
    
    @Published var usernameValidation = UsernameValidation()
    @Published var emailValidation = EmailValidation()
    @Published var senhaValidation = Senha_FormProfileValidation()
    
    var userId: UUID?
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    private var cancellable: AnyCancellable?
    private var cancellableUpdate: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    private let interactor : ProfileInteractor
    private let interactorSignUP: SignUPInteractor
    
    init(interactor:ProfileInteractor,
         interactorSignUP:SignUPInteractor){
        self.interactor = interactor
        self.interactorSignUP = interactorSignUP
    }
    
    
    deinit{
        cancellable?.cancel()
        cancellableUpdate?.cancel()
        cancellableSignIn?.cancel()
        
    }
    
    
    func CarregarUsuario() -> Void {
        self.uiState = .loading
        self.cancellable = self.interactor.getUser(id: tokenEUsuario.shared.Id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
                switch(completion) {
                case .failure(let appError):
                    self.uiState =  ProfileUIState.fetchErro(appError.message)
                    break
                case .finished:
                    break
                }
            }receiveValue: { sucess in
                
                self.uiState = .fetchSuccess
                self.emailValidation.value = sucess.email
                //self.email = sucess.email
                self.userId = sucess.id
                self.usernameValidation.value = sucess.username
               // self.username = sucess.username
                //self.password = sucess.password
                self.senhaValidation.value = sucess.password
            }
        
    }
    
    func update(){
        self.uiState =  .updateLoading
        let usuario = User(username: self.usernameValidation.value,
                           email: emailValidation.value,
                           password: senhaValidation.value)
        
        usuario.id = self.userId ?? UUID()
        self.cancellableUpdate =  self.interactor.update(usuario: usuario)
        
            .receive(on: DispatchQueue.main)
            .sink {
                completion in
                
                switch(completion) {
                case .failure(let appError):
                    self.uiState =  ProfileUIState.updateErro(appError.message)
                    break
                case .finished:
                    break
                }
            }receiveValue: { success in
                if success {
                   
                    self.cancellableSignIn = self.interactorSignUP.login(username: usuario.username,password: usuario.password)
                    
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch(completion) {
                        case .failure(let appError):
                            self.uiState =  .updateErro(appError.message)
                            break
                        case .finished:
                            break
                        }
                    } receiveValue: { succesLogado in
                        self.interactorSignUP.insertAuth(userAuth: UserAuth(id: succesLogado.Id,
                                                                      token: succesLogado.token,
                                                                      RefreshToken: succesLogado.RefreshToken,
                                                                      expira: succesLogado.expira))
                        
                        //self.publisher.send(true)
                        self.uiState = .updateSuccess
                    }

                }
                
            }
    
        }
    
    
    
}


class EmailValidation: ObservableObject {
    @Published var failure = false
    var value: String = ""{
        didSet {
            failure =  !value.isEmail() || value.isEmpty
        }
    }
}

class Senha_FormProfileValidation: ObservableObject {
    @Published var failure = false
    var value: String = ""{
        didSet {
            failure = value.isEmpty || value.count > 10
        }
    }
}





class UsernameValidation: ObservableObject {
    @Published var failure = false
    var value: String = ""{
        didSet {
            failure = value.isEmpty
        }
    }
}
