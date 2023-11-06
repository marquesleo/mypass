//
//  CategoriaCardView.swift
//  MyPass
//
//  Created by Leonardo Marques on 25/10/23.
//

import SwiftUI

struct CategoriaCardView: View {
    let viewModel: CategoriaCardViewModel
    @State private var action = false
    
    
    var body: some View {
        ZStack(alignment: .trailing){
            
            NavigationLink(
                
                destination: viewModel.CategoriaDetailView(),
                isActive: self.$action,
                label: {
                    EmptyView()
                }
            )
            Button(action: {
                self.action = true
            }, label: {
                HStack{
                    /*Image(systemName: "pencil")
                        .padding(.horizontal, 8)*/
                    
                    Spacer()
                    
                    HStack (alignment: .top){
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4)
                        {
                            Text(viewModel.name)
                                .foregroundColor(Color("meuazul"))
                                .multilineTextAlignment(.leading)
                            
                        }.frame(maxWidth:300, alignment: .leading)
                            
                        Spacer()
                        
                        VStack(alignment: .leading,spacing: 4) {
                            
                           /* Text("Verificar")
                                .foregroundColor(Color("meuazul"))
                                .bold()
                                .multilineTextAlignment(.leading)*/
                            
                            
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    Spacer()
                }
                .padding()
                .cornerRadius(4.0)
            })
            
            Rectangle()
                .frame(width: 8)
                .foregroundColor(viewModel.state)
        }
        .background(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(Color("meuazul"), lineWidth: 1.4)
                .shadow(color: Color.gray,  radius: 2, x: 2.0, y: 2.0)
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }
}

struct CategoriaCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriaCardView(viewModel: CategoriaCardViewModel())
    }
}
