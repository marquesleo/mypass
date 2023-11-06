//
//  SplashView.swift
//  MyPass
//
//  Created by Leonardo Marques on 13/10/23.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
   
    
    var body: some View {
        Group {
            switch viewModel.UIstate {
            case .loading:
                loadingView()
                
            case .goToSignInScreen:
                viewModel.signInView()
             
            case .goToHomeScreen:
                viewModel.homeView()
            case .error(let msg):
                loadingView(error: msg)
            }
        }.onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

struct LoadingView : View {
    var body : some View {
        ZStack {
            Image("logo")
                .scaledToFit()
                .padding(5)
                
               
                
        }
    }
}

extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack {
            Image("logo")
                .scaledToFit()
                .padding(5)
            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("MyPass"),
                              message: Text(error),
                              dismissButton: .default(Text("Ok")) {
                            //faz algo quando some o alerta
                        })
                        
                    }
                
            }
        }
    }
}
struct SplashView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = SplashViewModel(interactor: SplashInteractor())
        SplashView(viewModel: viewModel)
    }
}
