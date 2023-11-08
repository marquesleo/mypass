//
//  ProfileView.swift
//  MyPass
//
//  Created by Leonardo Marques on 07/11/23.
//

import SwiftUI

struct ProfileView: View {

    @State var usuario = ""
    @State var email = ""
    @State var senha = ""

    var body: some View {
        NavigationView {
            VStack {
                Form{
                    Section(header: Text("Dados Cadastrais")){
                        HStack{
                            Text("Usuário:")
                            Spacer()
                            TextField("Digite o login", text: $usuario)
                                .keyboardType(.default)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack{
                            Text("E-mail:")
                            Spacer()
                            TextField("Digite o e-mail", text: $email)
                                .keyboardType(.emailAddress)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack{
                            Text("Senha:")
                            Spacer()
                            SecureField("Digite a Senha", text: $senha)
                                .keyboardType(.default)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
            }
        }.navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
