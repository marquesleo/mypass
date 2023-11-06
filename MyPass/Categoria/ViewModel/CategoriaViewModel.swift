//
//  CategoriaViewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 25/10/23.
//

import Foundation
import Combine

class CategoriaViewModel: ObservableObject {
    
    @Published var uiState: CategoriaUIState = .loading
    @Published var title = "Atenção"
    @Published var headLine = "Fique Ligado!"
    @Published var description = "Você está atrasado!"
    @Published var opened = false
    
    
    
    private var cancellableRequest: AnyCancellable?
    private let interactor: CategoriaInInteractor
    
    init(interactor:CategoriaInInteractor) {
        self.interactor = interactor
    }
    
    deinit{
        cancellableRequest?.cancel()
    }
    
    func onAppear() {
        self.opened = true
        self.uiState = .emptyList
        
        cancellableRequest = interactor.getAllCategoria()
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
                            
                            return CategoriaCardViewModel(
                                id: $0.id,
                                icon: $0.icon ?? "",
                                name: $0.descricao,
                                state: .green,
                                ativo: $0.ativo
                            )
                        }
                    )
                }
            })
    }
}


