//
//  SplashViewRouter.swift
//  MyPass
//
//  Created by Leonardo Marques on 13/10/23.
//

import SwiftUI

enum SplashViewRouter {
    
    static func makeSignInView() -> some View {
        
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        return SignInView(viewModel: viewModel)
    }
    
    
}
