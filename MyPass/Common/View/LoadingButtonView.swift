//
//  LoadingButtonView.swift
//  MyPass
//
//  Created by Leonardo Marques on 15/10/23.
//

import SwiftUI

struct LoadingButtonView: View {
    
    var action: () -> Void
    var disabled: Bool = false
    var text: String!
    var cor: Color = Color("meuazul")
    var showProgressBar: Bool = true
    
    var body: some View {
        
        ZStack{
            Button(action:{
                action()
                
            }, label: {
                Text(showProgressBar ? " " : text)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,14)
                    .padding(.horizontal,16)
                    .font(Font.system(.title3).bold())
                    .foregroundColor(.white)
                    .background(disabled ? Color("disable") : cor)
                    .cornerRadius(4.0)
                
            }).disabled(disabled || showProgressBar)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .foregroundColor(Color.white)
                .opacity(showProgressBar ? 1 : 0)
               
        }
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButtonView(action: {
            print("Ola mundo")
        },disabled: false, text: "Entrar",
                          showProgressBar: false)
    }
}
