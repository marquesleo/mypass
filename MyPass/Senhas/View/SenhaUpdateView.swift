//
//  SenhaUpdateView.swift
//  MyPass
//
//  Created by Leonardo Marques on 08/11/23.
//

import SwiftUI

struct SenhaUpdateView: View {
    @ObservedObject var viewModel: SenhaUpdateViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var showImagePicker: Bool = false
    
    
    var disableDone: Bool {
        return viewModel.usuarioSiteValidation.failure ||
        viewModel.descricaoValidation.failure ||
        viewModel.senhaValidation.failure ||
        viewModel.siteValidation.failure
    }
    
    var body: some View {
        ZStack
        {
            if case SenhaUpdateUIState.loading = viewModel.uiState {
                ProgressView()
            }else {
                
                
                NavigationView {
                    VStack {
                        Form{
                            Section(header: Text("Dados Cadastrais")){
                                
                                
                                HStack{
                                    Text("Descrição:")
                                    Spacer()
                                    TextField("Digite a descrição", text: $viewModel.descricaoValidation.value)
                                        .keyboardType(.default)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.descricaoValidation.failure {
                                    Text("Descrição deve ser preenchida.")
                                        .foregroundColor(.red)
                                }
                                
                                HStack{
                                    Text("Site:")
                                    Spacer()
                                    TextField("Digite o site", text: $viewModel.siteValidation.value)
                                        .keyboardType(.default)
                                        .multilineTextAlignment(.trailing)
                                }
                                if viewModel.siteValidation.failure {
                                    Text("Site deve ser preenchido.")
                                        .foregroundColor(.red)
                                }
                                
                                HStack{
                                    Text("Observação:")
                                    Spacer()
                                    TextField("Digite uma observação", text: $viewModel.Observacao)
                                        .keyboardType(.default)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack{
                                    Text("Usuário:")
                                    Spacer()
                                    TextField("Digite o usuário", text: $viewModel.usuarioSiteValidation.value)
                                        .keyboardType(.emailAddress)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.usuarioSiteValidation.failure {
                                    Text("Usuário deve ser preenchido.")
                                        .foregroundColor(.red)
                                }
                                
                                HStack
                                {
                                    Text("Senha:")
                                    Spacer()
                                    SecureField("Digite a Senha", text: $viewModel.senhaValidation.value)
                                        .keyboardType(.default)
                                        .multilineTextAlignment(.trailing)
                                }
                                if viewModel.senhaValidation.failure {
                                    Text("Senha deve ser preenchida.")
                                        .foregroundColor(.red)
                                }
                                
                                HStack{
                                    Text("Ativo?")
                                    Spacer()
                                    Toggle(isOn: $viewModel.Ativo) {
                                        
                                    }
                                    .toggleStyle(iOSCheckboxToggleStyle())
                                    
                                    
                                }
                                
                                
                            }
                            VStack{
                                selectImageField
                                
                                
                            }
                        }
                    }.navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
                        .navigationBarItems(trailing: Button(action: {
                            
                            viewModel.update()
                            
                        }, label: {
                            if case SenhaUpdateUIState.updateLoading = viewModel.uiState {
                                ProgressView()
                            }else {
                                
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color("meuazul"))
                            }
                        })
                            .alert(isPresented: .constant(viewModel.uiState == .updateSuccess)) {
                                Alert(title: Text("MyPass"), message: Text("Dados atualizados com sucesso!"),
                                      dismissButton: .default(Text("Ok")) {
                                    
                                    viewModel.$uiState.sink{ uiState in
                                        if uiState == SenhaUpdateUIState.updateSuccess  {
                                            
                                            viewModel.uiState = .none
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    }.store(in: &viewModel.cancellables)
                                    
                                    
                                    
                                    
                                })
                            }
                            .opacity(disableDone ? 0 : 1)
                        )
                }
                
                if case SenhaUpdateUIState.updateErro(let value) = viewModel.uiState {
                    Text("")
                        .alert(isPresented: .constant(true)) {
                            Alert(title: Text("MyPass"), message: Text(value),
                                  dismissButton: .default(Text("Ok")) {
                                viewModel.uiState = .none
                                
                            })
                            
                        }
                }
                
                if case SenhaUpdateUIState.fetchErro(let value) = viewModel.uiState {
                    Text("")
                        .alert(isPresented: .constant(true)) {
                            Alert(title: Text("MyPass"), message: Text(value),
                                  dismissButton: .default(Text("Ok")))
                        }
                }
                
            }
            
        }
    }
}

extension SenhaUpdateView {
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

struct SenhaUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        SenhaUpdateView(viewModel: SenhaUpdateViewModel(interactor: CrudSenhaInteractor()))
    }
}
