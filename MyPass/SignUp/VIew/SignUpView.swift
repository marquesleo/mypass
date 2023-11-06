//
//  SignUpView.swift
//  MyPass
//
//  Created by Leonardo Marques on 14/10/23.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var action:  Int? = 0
    @State var navigationHidden = true
     var alteracao: Bool
   
    
    init(viewModel: SignUpViewModel,
         alteracao: Bool) {
        
        self.viewModel = viewModel
        self.alteracao = alteracao
        if alteracao{
            viewModel.CarregarUsuario()
        }
    }
    
    var body: some View {
        
                   
            ZStack {
                
                if case SignUpUIState.userUpdated = viewModel.uiState {
                    viewModel.homeView()
                    
                }else
                {
                    
                    
                    ScrollView(showsIndicators: false){
                        VStack(alignment: .center)
                        {
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(alteracao ? "Alteração" :   "Cadastro" )
                                    .foregroundColor(Color("meuazul"))
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom,8)
                                
                                usernameField
                                emailField
                                passwordField
                                saveButton
                                
                                
                               
                                
                            }
                            
                            Spacer()
                            
                        }.padding(.horizontal,8)
                    }.padding(20)
                    
                    if case SignUpUIState.error(let value) = viewModel.uiState {
                        
                        Text("")
                            .alert(isPresented: .constant(true)) {
                                Alert(title: Text("My Pass"), message: Text(value), dismissButton: .default(Text("Ok"))
                                      {
                                    
                                })
                            }
                    }
                    
                    
                   
                        Button("Cancelar"){
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .padding(.vertical,16)
                            .padding(.horizontal, 8)
                    
                    
                }
        }.navigationBarHidden(navigationHidden)
    }
}

extension SignUpView {
    var usernameField: some View {
        EditTextView(placeholder: "Username",
                     error: "Username deve ser preenchido",
                     failure: viewModel.username.isEmpty,
                     text: $viewModel.username )
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(placeholder: "Password",
                     error:  RetornarValidacaoPassword(),
                     failure: !RetornarValidacaoPassword().isEmpty,
                     isSecure: true,
                     text: $viewModel.password)
         }
        
        func RetornarValidacaoPassword() -> String {
            
            var erro:String = ""
            
            if viewModel.password.isEmpty{
                erro = "E-mail deve ser preenchido."
            }
                    
            if viewModel.password.count > 10 {
                erro = "Password deve ter até 10 caracteres."
            }
            
            return erro
            
        
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(placeholder: "E-mail",
                     error: RetornarValidacaoEmail(),
                     
                     failure: !RetornarValidacaoEmail().isEmpty,
                     keyBoard:  .emailAddress,
                     text: $viewModel.email )
    }
    
    func RetornarValidacaoEmail() -> String {
        
        var erro:String = ""
        
        if viewModel.email.isEmpty{
            erro = "E-mail deve ser preenchido."
        }
                
        if !viewModel.email.isEmail() {
            erro = "E-mail inválido."
        }
        
        if !viewModel.email.contains("@"){
            erro = "E-mail inválido."
        }
            
            return erro
            
        
    }
}

extension SignUpView {
    
    var saveButton: some View {
        LoadingButtonView(action: {
   
            viewModel.save()
        }, disabled:  !FormIsValid(),
                        text: "Salvar",
                          showProgressBar: self.viewModel.uiState == SignUpUIState.loading )
        
        
    }
    
    func FormIsValid() -> Bool {
        
        if viewModel.username.isEmpty {
            return false
        }
        
        if viewModel.password.isEmpty {
            return false
        }
        
        if viewModel.password.count > 10 {
            return false
        }
        
        if viewModel.email.isEmpty {
            return false
        }
            
        return true
    }
    
    
    
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        
        SignUpView(viewModel: SignUpViewModel(interactor: SignUPInteractor()), alteracao:  false)
    }
}
