//
//  CrudSenhaView.swift
//  MyPass
//
//  Created by Leonardo Marques on 24/10/23.
//

import SwiftUI

struct CrudSenhaView: View {
    @ObservedObject var viewModel: CrudSenhaViewModel
    @State var navigationHidden = false
    var alteracao: Bool
    @State var showImagePicker: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var id: UUID
    
    init(viewModel: CrudSenhaViewModel,
         alteracao: Bool,
         id:UUID) {
        self.id = id
        self.viewModel = viewModel
        self.alteracao = alteracao
        if (alteracao){
            viewModel.CarregarSenha(id: self.id)
        }
    }
    
    
    var body: some View {
        ZStack {
            
            
            
            
            ScrollView(showsIndicators: false){
                VStack(alignment: .center)
                {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("+ Senha")
                            .foregroundColor(Color("meuazul"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom,8)
                        
                        descricaoField
                        siteField
                        observacaoField
                        usernameField
                        passwordField
                        ativoField
                        selectImageField
                        saveButton
                       
                        
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal,8)
                }.padding(20)
                .onAppear{
                  
                  
                }
                       
            
            let msgIncluida = "Senha Incluída com sucesso!"
            
            let msgAlteracao = "Senha Alterada com sucesso!"
            
            if case CrudSenhaUIState.success = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        
                        Alert(title: Text("My Pass"), message: Text(viewModel.alteracao ? msgAlteracao : msgIncluida), dismissButton: .default(Text("Ok"))
                        {
                            if !viewModel.alteracao
                            {
                                                           
                                viewModel.limpar()
                            
                            }
                            else
                            {
                                viewModel.$uiState.sink{ uiState in
                                    if uiState == .success && viewModel.alteracao {
                                        self.presentationMode.wrappedValue.dismiss()
                                   }
                                }.store(in: &viewModel.cancellables)
                            }
                        })
                    }
            }
            
            if case CrudSenhaUIState.error(let value) = viewModel.uiState
            {
                
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("My Pass"), message: Text(value), dismissButton: .default(Text("Ok"))
                        {
                           
                        })
                    }
            }
            
        }
       
           
        
        .navigationBarHidden(navigationHidden)
        
    }
}


extension CrudSenhaView {
    var descricaoField: some View {
        EditTextView(placeholder: "Descrição",
                     error: "Descrição da senha ser preenchida.",
                     failure: viewModel.Descricao.isEmpty,
                     text: $viewModel.Descricao )
    }
}

extension CrudSenhaView {
    var siteField: some View {
        EditTextView(placeholder: "Site",
                     error:  RetornarValidacaoSite(),
                     failure: !RetornarValidacaoSite().isEmpty,
                     text: $viewModel.Site)
    }
    
    func RetornarValidacaoSite() -> String {
        
        var erro:String = ""
        
        if viewModel.Site.isEmpty{
            erro = "Site deve ser preenchido."
        }
        return erro
        
        
    }
}

extension CrudSenhaView {
    var observacaoField: some View {
        EditTextView(placeholder: "Observação",
                     error: "",
                     failure: false,
                     text: $viewModel.Observacao )
    }
}

extension CrudSenhaView {
    var usernameField: some View {
        EditTextView(placeholder: "Usuario",
                     error: "Usuário nao pode ser vazio",
                     failure: viewModel.Usuario_Site.isEmpty,
                     text: $viewModel.Usuario_Site )
    }
}

extension CrudSenhaView {
    var passwordField: some View {
        EditTextView(placeholder: "Password",
                     error:  RetornarValidacaoPassword(),
                     failure: !RetornarValidacaoPassword().isEmpty,
                     isSecure: true,
                     text: $viewModel.Password)
         }
        
        func RetornarValidacaoPassword() -> String {
            
            var erro:String = ""
            
            if viewModel.Password.isEmpty{
                erro = "Senha deve ser preenchido."
            }
            return erro
            
        
    }
}

extension CrudSenhaView {
    var ativoField: some View {
        
       
            Toggle(isOn: $viewModel.Ativo) {
                Text("Ativo?")
            }
            .toggleStyle(iOSCheckboxToggleStyle())
        
    }
}


extension CrudSenhaView {
    var selectImageField: some View {
        VStack {
            Button {
                self.showImagePicker.toggle()
            } label: {
                Text("Selecione a Imagem")
            }
            
            if let image = self.$viewModel.selectedImage.wrappedValue {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .frame(maxWidth: .infinity) // Para ocupar toda a largura disponível
                    .frame(maxHeight: .infinity) // Para ocupar toda a altura disponível
            }
            
        }
        .frame(maxWidth: .infinity) // Para ocupar toda a largura disponível
        .frame(maxHeight: .infinity) // Para ocupar toda a altura disponível
        .alignmentGuide(HorizontalAlignment.center) { d in d[.leading] } // Alinha horizontalmente ao centro
        .alignmentGuide(VerticalAlignment.center) { d in d[.top] } // Alinha verticalmente ao centro
        .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: self.$viewModel.selectedImage, selectedImageName: self.$viewModel.NomeDaImagem)
        }
    
    }
}

extension CrudSenhaView {
    
    var saveButton: some View {
        LoadingButtonView(action:
        {
           viewModel.save()
        },
        disabled: !FormIsValid(),
                          text: "Salvar",
                          showProgressBar: self.viewModel.uiState == CrudSenhaUIState.loading )
        
        
    }
    
    func FormIsValid() -> Bool {
        
        if viewModel.Descricao.isEmpty {
            return false
        }
        
        if viewModel.Password.isEmpty {
            return false
        }
        
        if viewModel.Usuario_Site.isEmpty {
            return false
        }
             
        
        return true
    }
    
    
    
    
}


struct CrudSenhaView_Previews: PreviewProvider {
    static var previews: some View {
        CrudSenhaView(viewModel: CrudSenhaViewModel(interactor: CrudSenhaInteractor()),
                      alteracao: false,
                      id: UUID())
    }
}
