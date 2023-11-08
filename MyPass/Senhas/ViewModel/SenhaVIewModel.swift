//
//  SenhaVIewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 26/10/23.
//

import Foundation
import Combine
import SwiftUI
class SenhaViewModel: ObservableObject {
    
    @Published var uiState: SenhaUIState = .loading
    @Published var title = "Atenção"
    @Published var headLine = "Fique Ligado!"
    @Published var description = "Você está atrasado!"
    @Published var opened = false
    
 
    var cancellables = Set<AnyCancellable>()
    private let senhaViewPublisher = PassthroughSubject<Bool,Never>()
    private let senhaViewNovoCadastro = PassthroughSubject<Bool,Never>()
    private var cancellableNotify: AnyCancellable?
    private var cancellableNotifyInclusao: AnyCancellable?
    
    
    private var cancellableRequest: AnyCancellable?
  
    private let interactor: SenhaInteractor
    
    init(interactor:SenhaInteractor) {
        self.interactor = interactor
        
        cancellableNotify = senhaViewPublisher.sink(receiveValue: {
            delete in
            print("Foi deletado")
            if delete {
                self.onAppear()
            }
            
        })
        
        
        cancellableNotifyInclusao = senhaViewNovoCadastro.sink(receiveValue: {
            incluido in
            print("Foi incluido")
            if incluido {
                self.onAppear()
            }
            
        })
    }
    
    deinit{
        cancellableRequest?.cancel()
    }
    
    func onAppear() {
        self.opened = true
        self.uiState = .loading
        
        cancellableRequest = interactor.getAll()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion){
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                    
                }
            }, receiveValue: { response in
                if response.isEmpty {
                    self.uiState = .emptyList
                    
                }else
                {
                    self.uiState = .fullList(
                        response.map {
                            
                            return SenhaCardViewModel(
                                id: $0.Id ,
                                Descricao: $0.Descricao,
                                Observacao: $0.Observacao ?? "",
                                Site: $0.Site,
                                Usuario_Site: $0.Usuario_Site,
                                ImageStr: $0.ImagemData ?? "",
                                Password: $0.Password,
                                senhaViewPublisher: self.senhaViewPublisher
                             
                            )
                        }
                    )
                }
            })
    }
}

extension SenhaViewModel {
    func makeCrudSenhaView() -> some View {
        return SenhaViewRouter.makeCrudSenhaView(senhaViewNovoCadastro: self.senhaViewNovoCadastro)
    }
}

