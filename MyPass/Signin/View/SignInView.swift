//
//  SignInView.swift
//  MyPass
//
//  Created by Leonardo Marques on 13/10/23.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var action:  Int? = 0
    @State var navigationHidden = true
    
    var body: some View {
        
        ZStack
        {
            
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
                
            }else
            {
                NavigationView
                {
                    
                    ScrollView(showsIndicators: false)
                    {
                        
                        VStack(alignment: .center, spacing: 20)
                        {
                            Spacer(minLength: 36)
                            VStack(alignment: .center, spacing: 8)
                            {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal,48)
                                
                                
                                Text("Login")
                                    .foregroundColor(Color("meuazul"))
                                    .font(Font.system (.title).bold())
                                    .padding(.bottom,8)
                                
                                usernameField
                                
                                passwordField
                                
                                enterButton
                                
                                registerLink
                            }
                        }
                        
                        if case SignInUIState.error(let value) = viewModel.uiState {
                            
                            Text("")
                                .alert(isPresented: .constant(true)) {
                                    Alert(title: Text("My Pass"), message: Text(value), dismissButton: .default(Text("Ok"))
                                          {
                                        
                                    })
                                }
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity )
                    .padding(.horizontal, 32)
                    .navigationBarTitle("Login",displayMode: .inline)
                    .navigationBarHidden(navigationHidden)
                }
            }
        }
        
        
    }
}

extension SignInView {
    var usernameField: some View {
        EditTextView(placeholder: "Username",
                     error: "Username deve ser preenchido",
                     failure: viewModel.username.isEmpty,
                     text: $viewModel.username )
    }
}

extension SignInView {
    var passwordField: some View {
        EditTextView(placeholder: "Password",
                     error: "Password deve ser preenchido ou ter 10 caracteres",
                     failure: viewModel.password.count > 10,
                     isSecure: true,
                     text: $viewModel.password)
    }
    
   
}

extension SignInView {
    var enterButton: some View {
        LoadingButtonView(action: {
            viewModel.login()
        }, disabled:  !FormIsValid(),
                        text: "Entrar",
                        showProgressBar: self.viewModel.uiState == SignInUIState.loading )
        
        
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
        return true
    }
}

extension SignInView {
    var registerLink: some View {
        
        VStack{
            
            Text("Ainda não possui um login ativo?")
                .foregroundColor(.gray)
                .padding(.top,48)
            
            ZStack{
                NavigationLink(
                destination:viewModel.signUpView(),
                tag: 1 ,
                selection: $action,
                label: { EmptyView() })
                    
                    Button("Realize seu cadastro") {
                        self.action = 1
                    }
             
                
            }
            
        }
        
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInViewModel (interactor: SignInInteractor() )
        SignInView(viewModel: viewModel)
    }
}
