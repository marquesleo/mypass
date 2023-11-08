//
//  SignInViewRouter.swift
//  MyPass
//
//  Created by Leonardo Marques on 14/10/23.
//

import SwiftUI
import Combine

enum SignUpViewRouter {
    static func makeHomeView(publisher: PassthroughSubject<Bool,Never>) -> some View {
        let viewModel = HomeViewModel()
        
        return HomeView(viewModel: viewModel)
    }
    static func makeSignUpView(publisher: PassthroughSubject<Bool,Never>) -> some View {
        let viewModel = SignUpViewModel(interactor: SignUPInteractor() )
        viewModel.publisher = publisher
        return SignUpView(viewModel: viewModel, alteracao: false)
    }
}
