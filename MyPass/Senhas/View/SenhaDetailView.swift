//
//  SenhaDetailView.swift
//  MyPass
//
//  Created by Leonardo Marques on 30/10/23.
//

import SwiftUI
import Combine
struct SenhaDetailView: View {
    @ObservedObject var viewModel: SenhaDetailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false
    @State private var idToBeDeleted: Int = 0
    
    @State private var action = false
    init(viewModel:SenhaDetailViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
       
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 12) {
                    Text("Informações da senha")
                        .foregroundColor(Color("meuazul"))
                        .font(.title.bold())
                    
                    Text("Descrição:\(viewModel.Descricao)")
                        .foregroundColor(Color("textColor"))
                        .font(.title3)
                    
                    Text(viewModel.Site)
                        .foregroundColor(Color("textColor"))
                        .font(.title3)
                        .underline()
                    Text("Usuário:\(viewModel.Usuario)")
                        .foregroundColor(Color("textColor"))
                        .font(.title3)
                    
                    Text("Password:\(viewModel.Password)")
                        .foregroundColor(Color("textColor"))
                        .font(.title3)
                    
                    Text("Observação:\(viewModel.Obervacao)")
                        .foregroundColor(Color("textColor"))
                        .font(.title3)
                    
                    
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
            }.onAppear{
                viewModel.$uiState.sink{ uiState in
                    if uiState == .deleteSuccess  {
                        self.presentationMode.wrappedValue.dismiss()
                   }
                }.store(in: &viewModel.cancellables)
            }
            
        }
    
}


extension SenhaDetailView {
    
    var UpdateButton: some View {
       
        NavigationLink(
            destination: viewModel.updateSenhaView(),
            isActive: self.$action,
            label: {
                Label("Alterar", systemImage: "pencil")
                    .modifier(ButtonStyle())
            }
        )
        }

}





extension SenhaDetailView {
 //
    
    var DeleteButton: some View {
        LoadingButtonView(action:
        {
            showAlert = true
                 
        },
        disabled: false,
        text: "Excluir",
        cor: Color.red,
        showProgressBar: self.viewModel.uiState == SenhaDetailUIState.loading )
        .alert(isPresented: $showAlert){
            
            Alert(title: Text("Exclusão"),
                  message: Text("Deseja excluir senha?"),
                  primaryButton: .default(Text("Sim"))
                  {
                    viewModel.ExcluirSenha(id: self.viewModel.Id)
                  },
                  secondaryButton: .cancel()
           )
        }
        
        
    }
    
    
  
}


struct SenhaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SenhaDetailView(viewModel: SenhaDetailViewModel(id: UUID(),
                                                        descricao: "Itau",
                                                        observacao: "Site do Itaú",
                                                        usuario: "leopac",
                                                        site: "http://www.itau.com",
                                                        password: "123"
                                                        ))
        
    }
}
