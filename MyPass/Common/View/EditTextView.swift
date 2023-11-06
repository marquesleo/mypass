//
//  EditTextView.swift
//  MyPass
//
//  Created by Leonardo Marques on 15/10/23.
//

import SwiftUI

struct EditTextView: View {
    
    
    var placeholder: String = ""
    var error: String? = nil
    var failure:Bool? = nil
    var keyBoard: UIKeyboardType = .default
    var isSecure:Bool = false
    @Binding var text: String
    
    var body: some View {
        VStack{
            
            if isSecure {
                SecureField(placeholder,text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyBoard)
                    .textFieldStyle(CustomTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Color.blue, lineWidth: 0.8)
                    )
                
            }else {
                TextField(placeholder,text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyBoard)
                    .textFieldStyle(CustomTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Color.blue, lineWidth: 0.8)
                    )
            }
            if let error = error, failure == true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }.padding(.bottom, 10)
    }
}


struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack {
                
                EditTextView(placeholder: "E-mail",
                             error: "Campo inválido",
                             failure: "asasas".count > 100, text: .constant(""))
                .previewDevice("iPhone 14 Pro")
                    .padding()
                
            }
            .preferredColorScheme(.light)
            .frame(maxWidth: .infinity, maxHeight: .infinity )
                .previewDevice("iPhone 14 Pro")
                .preferredColorScheme($0)
        }
        
       
    }
}
