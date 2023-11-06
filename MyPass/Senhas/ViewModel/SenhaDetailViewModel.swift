//
//  SenhaDetailViewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 26/10/23.
//

import Foundation
import SwiftUI
import Combine
class SenhaDetailViewModel: ObservableObject {
    @Published var uiState: SenhaDetailUIState = .none
    @Published var value = ""
    var cancellables = Set<AnyCancellable>()
    
    var Id: UUID
    var Descricao:String
    var Obervacao:String
    var Usuario:String
    var Site: String
    var Password:String
    
    private let senhaDetailPublisher = PassthroughSubject<Bool,Never>()
    private var cancellableNotify: AnyCancellable?
    
    private var cancellableSenhaGet: AnyCancellable?
    private var cancellableSenhaDelete: AnyCancellable?
    var senhaViewPublisher: PassthroughSubject<Bool,Never>?
    
    private var interactor: CrudSenhaInteractor = CrudSenhaInteractor()
    
    init(id:UUID,
         descricao:String,
         observacao:String,
         usuario:String,
         site:String,
         password:String)
        
    {
        
        self.Id = id
        self.Descricao = descricao
        self.Obervacao = observacao
        self.Usuario = usuario
        self.Site = site
        self.Password = password
      
        cancellableNotify = senhaDetailPublisher.sink(receiveValue: {
            saved in
            print("Foi alterado")
            if saved && self.uiState != SenhaDetailUIState.deleteSuccess {
                self.CarregarSenha(id: id)
            }
            
        })
    }
    
    deinit{
        cancellableSenhaGet?.cancel()
        cancellableSenhaDelete?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
        
    }
    
    func ExcluirSenha(id:UUID) -> Void {
        self.cancellableSenhaDelete = self.interactor.deleteSenha(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
                switch(completion) {
                case .failure(let appError):
                    self.uiState =  SenhaDetailUIState.error(appError.message)
                    break
                case .finished:
                    break
                }
            }receiveValue: { sucess in
               
                self.uiState = SenhaDetailUIState.deleteSuccess
                self.senhaViewPublisher?.send(true)
                
            }
        
    }
    
    func CarregarSenha(id: UUID) -> Void {
      
        self.cancellableSenhaGet = self.interactor.getSenha(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
                switch(completion) {
                case .failure(let appError):
                    self.uiState =  SenhaDetailUIState.error(appError.message)
                    break
                case .finished:
                    break
                }
            }receiveValue: { sucess in
               
                self.Descricao = sucess.Descricao
                self.Id = sucess.Id
                self.Password = sucess.Password
                self.Site = sucess.Site
                self.Usuario = sucess.Usuario_Site
                self.Obervacao = sucess.Observacao ?? ""
              
                
            }
        
    }
    
}


extension SenhaDetailViewModel{
    func makeCrudSenhaView() -> some View {
        return SenhaCardViewRouter.makeCrudSenhaView(Id: self.Id)
    }
    
    func updateCrudSenhaView() -> some View {
        return SenhaCardViewRouter.updateCrudSenhaView(Id: self.Id, senhaPublisher: self.senhaDetailPublisher)
    }
}
