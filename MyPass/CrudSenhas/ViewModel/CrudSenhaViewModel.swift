//
//  CrudSenhaViewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 24/10/23.
//
import SwiftUI
import Combine


class CrudSenhaViewModel: ObservableObject {
    
    @Published var uiState: CrudSenhaUIState = .none
    @Published var Descricao: String = ""
    @Published var Observacao: String = ""
    @Published var Ativo: Bool = true
    @Published var Usuario_Site:String = ""
    @Published var Usuario:UUID = UUID()
    @Published var Site:String = ""
    @Published var Password:String = ""
    @Published var DtAtualizacao:Date = Date()
    @Published var UrlImageSite:String = ""
    @Published var ImagemData:String = ""
    @Published var NomeDaImagem:String = ""
    @Published var alteracao = false
    @Published var selectedImage: Image? = Image("")
    @Published var id = UUID()
    @State var jaCarregou = false
     
    var cancellables = Set<AnyCancellable>()
    
    var senhaPublisher: PassthroughSubject<Bool,Never>?
    var senhaNovoCadastroPublisher: PassthroughSubject<Bool,Never>?
    
    
    private let interactor: CrudSenhaInteractor
    private var cancellableSave: AnyCancellable?
    private var cancellableUpdate: AnyCancellable?
    private var cancellableSenhaGet: AnyCancellable?
    
    deinit{
        cancellableSave?.cancel()
        cancellableUpdate?.cancel()
        cancellableSenhaGet?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    
    init(interactor: CrudSenhaInteractor)
    {
        self.interactor = interactor
    }
    
    func limpar() {
        self.Descricao = ""
        self.Password = ""
        self.Ativo = true
        self.NomeDaImagem = ""
        self.Observacao = ""
        self.Site = ""
        self.Usuario_Site = ""
        self.selectedImage = Image("")
        self.ImagemData = ""
        
        uiState = .none
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
    
    func CarregarSenha(id: UUID)  {
      
        self.cancellableSenhaGet = self.interactor.getSenha(id: id)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch(completion) {
                    case .failure(let appError):
                        self.uiState = CrudSenhaUIState.error(appError.message)
                    case .finished:
                        break
                    }
                }, receiveValue: { sucess in
                    self.jaCarregou = true
                    self.uiState = .update
                    self.alteracao = true
                    self.Descricao = sucess.Descricao
                    self.ImagemData = sucess.ImagemData ?? ""
                    self.NomeDaImagem = sucess.NomeDaImagem ?? ""
                    self.id = sucess.Id
                    self.Usuario = sucess.Usuario
                    self.Observacao = sucess.Observacao ?? ""
                    self.Password = sucess.Password
                    self.Site = sucess.Site
                    self.Ativo = sucess.Ativo
                    self.Usuario_Site = sucess.Usuario_Site
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
    
    
    func CarregarObjeto() -> MinhaSenha {
        var imageStr: String = ""
        
        if selectedImage != Image("") {
            let uiImage: UIImage = self.selectedImage.asUIImage()
            let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
            imageStr = imageData.base64EncodedString()
            
        }
        
        let senha = MinhaSenha(Descricao: self.Descricao,
                               Observacao: self.Observacao,
                               Ativo: self.Ativo,
                               Usuario_Site: self.Usuario_Site,
                               Usuario: tokenEUsuario.shared.Id,
                               Site: self.Site,
                               Password: self.Password,
                               UrlImageSite: "",
                               ImagemData: imageStr,
                               NomeDaImagem: self.NomeDaImagem)
        return senha
    }
    
    func update(){
        self.uiState =  .loading
        let senha = CarregarObjeto()
        senha.Id = self.id
        self.cancellableUpdate =  self.interactor.update(senha: senha)
        
            .receive(on: DispatchQueue.main)
            .sink {
                completion in
                
                switch(completion) {
                case .failure(let appError):
                    self.uiState =  CrudSenhaUIState.error(appError.message)
                    break
                case .finished:
                    break
                }
            }receiveValue: { success in
                if success {
                  
                    self.uiState = .success
                    self.senhaPublisher?.send(true)
                }
                
            }
        
    }
    
    
    func post(){
        
        self.uiState =  .loading
        
        let senha = CarregarObjeto()
        
        self.cancellableSave  =  self.interactor.save(senha: senha)
        
            .receive(on: DispatchQueue.main)
            .sink {
                completion in
                
                switch(completion) {
                case .failure(let appError):
                    self.uiState =  CrudSenhaUIState.error(appError.message)
                    break
                case .finished:
                    break
                }
            }receiveValue: { success in
                if !success.Id.uuidString.isEmpty {
                    
                    self.uiState = .success
                    self.senhaNovoCadastroPublisher?.send(true)
                }
                
            }
            
    }
    
}
