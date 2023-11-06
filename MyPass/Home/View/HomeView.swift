//
//  HomeView.swift
//  MyPass
//
//  Created by Leonardo Marques on 14/10/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
   @State var selection = 0
    
    var body: some View {
        
        TabView(selection: $selection) {
           
            /*viewModel.CategoriaView()
                .tabItem{
                    Image(systemName: "tray.2.fill")
                    Text("Categoria")
                }.tag("1")*/
           
            
            viewModel.SenhaView()
                .tabItem{
                    Image(systemName: "tray.2.fill")
                    Text("Lista de Senha")
                }.tag("1")
            
            
            viewModel.CrudSenhaView()
                .tabItem{
                    Image(systemName: "doc.fill.badge.plus")
                    Text("+ Senha")
                }.tag("2")
            
            viewModel.CategoriaView()
                .tabItem{
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                    Text("Lita Categoria")
                }.tag("3")
            
            viewModel.signUpView()
                .tabItem{
                    Image(systemName: "person.crop.circle")
                    Text("Perfil")
                }.tag("4")
            
            
        }
        .background(Color.white)
        .accentColor(Color("meuazul"))
        
        
        
        /*ZStack
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
                                    
                                    novaSenha
                                    
                                    categorias
                                    
                                    lista
                                    
                                    alterarUsuario
                                }
                            }
                            
                            
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity )
                        .padding(.horizontal, 32)
                        .navigationBarTitle("My Pass",displayMode: .inline)
                        
                    }
                    
                }*/
            
        
    }
}

extension HomeView {
    var lista: some View {
        
        VStack{
                 
            ZStack{
                NavigationLink {
                    viewModel.SenhaView()
                } label: {
                    VStack{
                        Image("lista")
                            .resizable()
                            .scaledToFit()
                            .padding(5)
                            .frame(width: 100, height: 100)
                        Text("Minhas Senhas")
                            .foregroundColor(Color("meuazul"))
                            .underline()
                    }
                }
                
                
            }
            
        }
        
    }
}

extension HomeView {
    var categorias: some View {
        
        VStack{
                 
            ZStack{
                NavigationLink {
                    viewModel.signUpView()
                } label: {
                   
                    VStack{
                        Image("categorias")
                            .resizable()
                            .scaledToFit()
                            .padding(5)
                            .frame(width: 100, height: 100)
                        
                        Text("Categorias")
                            .foregroundColor(Color("meuazul"))
                            .underline()
                        
                    }
                }
               
            }
            
        }
        
    }
}


extension HomeView {
    var novaSenha: some View {
        
        VStack{
                 
            ZStack{
                NavigationLink {
                    viewModel.CrudSenhaView()
                } label: {
                    VStack {
                        
                        Image("novasenha")
                            .resizable()
                            .scaledToFit()
                            .padding(5)
                            .frame(width: 100, height: 100)
                        Text("+ Senha")
                            .foregroundColor(Color("meuazul"))
                            .underline()
                    }
                }
                
               
                
            }
            
        }
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeView(viewModel: HomeViewModel())
                 
    }
}

extension HomeView {
    var alterarUsuario: some View {
        
        VStack{
                 
            ZStack{
                NavigationLink {
                    viewModel.signUpView()
                    
                   
                } label: {
                    VStack{
                        Image("usuario")
                            .resizable()
                            .scaledToFit()
                            .padding(5)
                            .frame(width: 100, height: 100)
                        Text("Meu Perfil")
                            .foregroundColor(Color("meuazul"))
                            .underline()
                    }
                }
          
            }
     
        }
        
    }
}



extension HomeView {
    var TituloView: some View {
        Text("My Pass")
            .foregroundColor(Color("meuazul"))
            .font(Font.system(.title).bold())
            .padding(.bottom, 20)
    }
}


