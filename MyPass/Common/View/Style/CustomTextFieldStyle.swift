//
//  CustomTextFieldStyle.swift
//  MyPass
//
//  Created by Leonardo Marques on 07/11/23.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
  public func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .padding(.horizontal, 8)
      .padding(.vertical, 16)
      .overlay(
        RoundedRectangle(cornerRadius: 8.0)
          .stroke(Color("meuazul"), lineWidth: 0.8)
      )
  }
  
}
