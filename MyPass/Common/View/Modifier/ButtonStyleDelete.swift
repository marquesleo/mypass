//
//  ButtonStyleDelete.swift
//  MyPass
//
//  Created by Leonardo Marques on 30/10/23.
//

import Foundation
import SwiftUI

struct ButtonStyleDelete: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical,14)
            .padding(.horizontal,16)
            .font(Font.system(.title3).bold())
            .foregroundColor(.white)
            .background(.red)
            .cornerRadius(4.0)
    }
}

