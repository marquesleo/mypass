//
//  SenhaCardView.swift
//  MyPass
//
//  Created by Leonardo Marques on 26/10/23.
//

import SwiftUI
import Combine
struct SenhaCardView: View {
    let viewModel: SenhaCardViewModel
    @State private var action = false
    
    
    var body: some View {
        ZStack(alignment: .trailing){
            
            
            NavigationLink(
                destination: viewModel.SenhaDetailView(),
                isActive: self.$action,
                label: {
                    EmptyView()
                }
            )
            Button(action: {
                self.action = true
            }, label: {
                HStack{
                 
                    viewModel.getImage()
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                       
                        
                    
                    Spacer()
                    
                    HStack (alignment: .top){
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4)
                        {
                            Text(viewModel.Descricao)
                                .font(.title3)
                                .foregroundColor(Color("meuazul"))
                                .multilineTextAlignment(.leading)
                            
                           
                            
                        }.frame(maxWidth:300, alignment: .leading)
                            
                            
                        Spacer()
                        
                       
                        
                        Spacer()
                        
                    }
                    
                    Spacer()
                }
                .padding()
                .cornerRadius(4.0)
            })
            
            Rectangle()
                .frame(width: 8)
                //.foregroundColor(viewModel.state)
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

struct SenhaCardView_Previews: PreviewProvider {
    static var previews: some View {
        SenhaCardView(viewModel: SenhaCardViewModel(senhaViewPublisher: PassthroughSubject<Bool, Never>()))
    }
}
