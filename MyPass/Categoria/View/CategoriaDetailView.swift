//
//  CategoriaDetailView.swift
//  MyPass
//
//  Created by Leonardo Marques on 30/10/23.
//

import SwiftUI

struct CategoriaDetailView: View {
    
    @ObservedObject var viewModel: CategoriaDetailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    init(viewModel:CategoriaDetailViewModel){
        self.viewModel = viewModel
    }
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 50) {
                Text("Informações da Categoria")
                    .foregroundColor(Color("meuazul"))
                    .font(.title2.bold())
                
                Text("Descriçao:\(viewModel.Descricao)")
                    .foregroundColor(Color("textColor"))
                    .font(.title3)
                     
            }
            
            HStack{
                UpdateButton
                    .padding(.leading, 16)
                    .padding(.trailing, 10)
                DeleteButton
                    
                    .padding(.leading, 10)
                    .padding(.trailing, 16)
                
              
            }
            
            Button("Cancelar"){
                self.presentationMode.wrappedValue.dismiss()
            }.padding(.vertical,16)
                .padding(.horizontal, 8)
                
        }
    }
}

extension CategoriaDetailView {
    
    var UpdateButton: some View {
        LoadingButtonView(action:
        {
             
        },
        disabled: false,
        text: "Alterar",
        showProgressBar: self.viewModel.uiState == CategoriaDetailUIState.loading )
        
        
    }
    
    
  
}

extension CategoriaDetailView {
    
    var DeleteButton: some View {
        LoadingButtonView(action:
        {
             //
        },
        disabled: false,
        text: "Excluir",
        cor: Color.red,
        showProgressBar: self.viewModel.uiState == CategoriaDetailUIState.loading )
        
        
    }
    
    
  
}


struct CategoriaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriaDetailView(viewModel: CategoriaDetailViewModel(id: UUID(), descricao: "Banco"))
    }
}
