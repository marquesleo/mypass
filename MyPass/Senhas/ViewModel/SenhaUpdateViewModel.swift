//
//  SenhaUpdateViewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 08/11/23.
//

import Foundation
import SwiftUI
import Combine
class SenhaUpdateViewModel : ObservableObject {
    @Published var uiState : SenhaUpdateUIState = .none
    
    @Published var descricaoValidation = Descricao_FormSenhaValidation()
    @Published var usuarioSiteValidation = UsuarioSite_FormSenhaValidation()
    @Published var senhaValidation = Senha_FormSenhaValidation()
    @Published var siteValidation = Site_FormSenhaValidation()
    
    @Published var Observacao: String = ""
    @Published var Ativo: Bool = true
    @Published var Usuario:UUID = UUID()
  
    @Published var UrlImageSite:String = ""
    @Published var ImagemData:String = ""
    @Published var NomeDaImagem:String = ""
    @Published var selectedImage: Image? = Image("")
    @Published var id = UUID()
    
    var cancellables = Set<AnyCancellable>()
    private var cancellableGet: AnyCancellable?
    private var cancellableUpdate: AnyCancellable?
    private let interactor : CrudSenhaInteractor
    var senhaPublisher: PassthroughSubject<Bool,Never>?
    
    
    init(interactor:CrudSenhaInteractor){
        self.interactor = interactor
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    
    deinit{
        cancellableGet?.cancel()
        cancellableUpdate?.cancel()
    }
    
    func CarregarObjeto() -> MinhaSenha {
        var imageStr: String = ""
        
        if selectedImage != Image("") {
            let uiImage: UIImage = self.selectedImage.asUIImage()
            let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
            imageStr = imageData.base64EncodedString()
            
        }
        
        let senha = MinhaSenha(Descricao: self.descricaoValidation.value,
                               Observacao: self.Observacao,
                               Ativo: self.Ativo,
                               Usuario_Site: self.usuarioSiteValidation.value,
                               Usuario: tokenEUsuario.shared.Id,
                               Site: self.siteValidation.value,
                               Password: self.senhaValidation.value,
                               UrlImageSite: "",
                               ImagemData: imageStr,
                               NomeDaImagem: self.NomeDaImagem)
        return senha
    }
    
    
    func update() {
        self.uiState =  .updateLoading
        let senha = CarregarObjeto()
        senha.Id = self.id
        self.cancellableUpdate =  self.interactor.update(senha: senha)
        
            .receive(on: DispatchQueue.main)
            .sink {
                completion in
                
                switch(completion) {
                case .failure(let appError):
                    self.uiState =  SenhaUpdateUIState.fetchErro(appError.message)
                    break
                case .finished:
                    break
                }
            }receiveValue: { success in
                if success {
                  
                    self.uiState = .updateSuccess
                    self.senhaPublisher?.send(true)
                }
                
            }
    }
    
    func carregarRegistro() {
        self.uiState = .loading
        self.cancellableGet = self.interactor.getSenha(id: self.id)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch(completion) {
                    case .failure(let appError):
                        self.uiState = SenhaUpdateUIState.fetchErro(appError.message)
                    case .finished:
                        break
                    }
                }, receiveValue: { sucess in
                    
                    self.uiState = .fetchSuccess
                  
                    self.descricaoValidation.value = sucess.Descricao
                    self.ImagemData = sucess.ImagemData ?? ""
                    self.NomeDaImagem = sucess.NomeDaImagem ?? ""
                    self.id = sucess.Id
                    self.Usuario = sucess.Usuario
                    self.Observacao = sucess.Observacao ?? ""
                    self.senhaValidation.value = sucess.Password
                    self.siteValidation.value = sucess.Site
                    self.Ativo = sucess.Ativo
                    self.usuarioSiteValidation.value = sucess.Usuario_Site
                    self.selectedImage = self.getImage()
                })
    }
    
    
    func getImage() -> Image {
        if let base64 = self.ImagemData.split(separator: ",").last.map(String.init),
                  let data = Data(base64Encoded: base64) {
                   if let uiImage = UIImage(data: data) {
                       return Image(uiImage: uiImage)
                           
                   } else {
                       return Image("")
                   }
               } else {
                   return Image("")
               }
  
    }
}

class Descricao_FormSenhaValidation: ObservableObject {
    @Published var failure = false
    var value: String = ""{
        didSet {
            failure =   value.isEmpty
        }
    }
}

class Site_FormSenhaValidation: ObservableObject {
    @Published var failure = false
    var value: String = ""{
        didSet {
            failure = value.isEmpty
        }
    }
}

class UsuarioSite_FormSenhaValidation: ObservableObject {
    @Published var failure = false
    var value: String = ""{
        didSet {
            failure = value.isEmpty
        }
    }
}


class Senha_FormSenhaValidation: ObservableObject {
    @Published var failure = false
    var value: String = ""{
        didSet {
            failure = value.isEmpty
        }
    }
}

