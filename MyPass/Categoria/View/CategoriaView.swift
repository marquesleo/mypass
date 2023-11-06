//
//  CategoriaView.swift
//  MyPass
//
//  Created by Leonardo Marques on 25/10/23.
//

import SwiftUI

struct CategoriaView: View {
    @ObservedObject var viewModel: CategoriaViewModel
    
    var body: some View {
       
        ZStack{
            
            if case CategoriaUIState.loading = viewModel.uiState {
                progress
            } else
            {
                NavigationView{
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing:12){
                            
                            //topContainer
                            
                            addButton
                            
                            if case CategoriaUIState.emptyList = viewModel.uiState
                            {
                                
                                Spacer(minLength: 60)
                               
                                VStack {
                                    
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24, alignment: .center)
                                    
                                    Text("Nenhuma categoria encontrada:(")
                                    
                                }
                                
                                
                            }else if case CategoriaUIState.fullList(let rows) = viewModel.uiState {
                                
                                LazyVStack{
                                    ForEach(rows ,content: CategoriaCardView.init(viewModel:))
                                    
                                }.padding(.horizontal,14)
                                
                            }else if case CategoriaUIState.error( let msg) = viewModel.uiState
                            {
                                Text("")
                                    .alert(isPresented: .constant(true)){
                                        
                                        Alert(title: Text("Ops!\(msg)"),
                                              message: Text("Tentar novamente?"),
                                              primaryButton: .default(Text("Sim"))
                                              {
                                            if !viewModel.opened {
                                                viewModel.onAppear()
                                            }
                                        },
                                              secondaryButton: .cancel()
                                       )
                                    }
                            }
                        }
                    }.navigationTitle("Categorias")
                }
            }
        }.onAppear {
            if !viewModel.opened {
                viewModel.onAppear()
            }
        }
    }
}

extension CategoriaView {
    var progress: some View {
        ProgressView()
    }
}


extension CategoriaView {
    var topContainer: some View {
        VStack(alignment: .center, spacing: 12){
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50,height: 50, alignment: .center)
            
            Text(viewModel.title)
                .font(Font.system(.title).bold())
                .foregroundColor(Color("meuazul"))
            
            Text(viewModel.headLine)
                .font(Font.system(.title3).bold())
                .foregroundColor(Color("textColor"))
            
            Text(viewModel.description)
                .font(Font.system(.subheadline))
                .foregroundColor(Color("textColor"))
            
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .overlay(
         RoundedRectangle(cornerRadius: 6)
            .stroke(Color.gray, lineWidth: 1)
           
        ).padding(.horizontal,16)
            .padding(.top, 16)
    }
}

extension CategoriaView {
    var addButton: some View {
        
        NavigationLink(destination: Text("Tela de adicionar")
            .frame(maxWidth: .infinity, maxHeight: .infinity)) {
                Label("Criar Categoria", systemImage: "plus.app")
                    .modifier(ButtonStyle())
            }
            .padding(.horizontal, 16)
            
    }
}


struct CategoriaView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriaView(viewModel: CategoriaViewModel(interactor: CategoriaInInteractor()))
    }
}
