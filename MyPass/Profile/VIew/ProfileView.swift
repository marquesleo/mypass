//
//  ProfileView.swift
//  MyPass
//
//  Created by Leonardo Marques on 07/11/23.
//

import SwiftUI

struct ProfileView: View {

    @ObservedObject var viewModel: ProfileViewModel
   
    var disableDone: Bool {
       return viewModel.usernameValidation.failure ||
        viewModel.emailValidation.failure ||
        viewModel.senhaValidation.failure
    }
    
    
    var body: some View {
        
        ZStack
        {
            if case ProfileUIState.loading = viewModel.uiState {
                ProgressView()
            }else {
                
                
                NavigationView {
                    VStack {
                        Form{
                            Section(header: Text("Dados Cadastrais")){
                                HStack{
                                    Text("Usuário:")
                                    Spacer()
                                    TextField("Digite o login", text: $viewModel.usernameValidation.value)
                                        .keyboardType(.default)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.usernameValidation.failure {
                                    Text("Usuário deve ser preenchido.")
                                        .foregroundColor(.red)
                                }
                                
                                HStack{
                                    Text("E-mail:")
                                    Spacer()
                                    TextField("Digite o e-mail", text: $viewModel.emailValidation.value)
                                        .keyboardType(.emailAddress)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.emailValidation.failure {
                                    Text("E-mail inválido ou em branco.")
                                        .foregroundColor(.red)
                                }
                                
                                HStack{
                                    Text("Senha:")
                                    Spacer()
                                    SecureField("Digite a Senha", text: $viewModel.senhaValidation.value)
                                        .keyboardType(.default)
                                        .multilineTextAlignment(.trailing)
                                }
                                if viewModel.senhaValidation.failure {
                                    Text("Senha em branco ou com mais de 10 caracteres.")
                                        .foregroundColor(.red)
                                }
                                
                                
                            }
                        }
                    }.navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
                        .navigationBarItems(trailing: Button(action: {
                            
                            viewModel.update()
                            
                        }, label: {
                            if case ProfileUIState.updateLoading = viewModel.uiState {
                                ProgressView()
                            }else {
                                
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color("meuazul"))
                                }
                            })
                            .alert(isPresented: .constant(viewModel.uiState == .updateSuccess)) {
                                Alert(title: Text("MyPass"), message: Text("Dados atualizados com sucesso!"),
                                      dismissButton: .default(Text("Ok")) {
                                    viewModel.uiState = .none
                                     
                                })
                            }
                            .opacity(disableDone ? 0 : 1)
                        )
                    
                    
                }
                
                if case ProfileUIState.updateErro(let value) = viewModel.uiState {
                    Text("")
                        .alert(isPresented: .constant(true)) {
                            Alert(title: Text("MyPass"), message: Text(value),
                                  dismissButton: .default(Text("Ok")) {
                                viewModel.uiState = .none
                                 
                            })
                        
                        }
                }
                
                if case ProfileUIState.fetchErro(let value) = viewModel.uiState {
                    Text("")
                        .alert(isPresented: .constant(true)) {
                            Alert(title: Text("MyPass"), message: Text(value),
                                  dismissButton: .default(Text("Ok")))
                        }
                }
                
                
            }
                
        }.onAppear(perform: viewModel.CarregarUsuario)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor(), interactorSignUP: SignUPInteractor()))
    }
}
