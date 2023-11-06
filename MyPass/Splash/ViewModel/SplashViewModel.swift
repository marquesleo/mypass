//
//  SplashViewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 13/10/23.
//

import SwiftUI
import Combine


class SplashViewModel : ObservableObject {
    @Published var UIstate: SplashUIState = .loading
    
    private let publisher = PassthroughSubject<Bool,Never>()
    private var cancellable: AnyCancellable?
    
    private let interactor: SplashInteractor
    
   
    init (interactor: SplashInteractor ){
        self.interactor = interactor
        
    }
    
    deinit{
        cancellable?.cancel()
    }
    
    
    func onAppear(){
        
      cancellable =   interactor.fetchAuth()
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                
                if let validaUserAuth = userAuth {
                    
                    tokenEUsuario.shared.Id = validaUserAuth.id
                    tokenEUsuario.shared.Token = validaUserAuth.token
                    
                    if validaUserAuth.token.isEmpty
                    {
                        self.UIstate = .goToSignInScreen
                    }else if  Date().timeIntervalSince1970 > userAuth!.expira.timeIntervalSince1970
                    {
                        self.UIstate = .goToSignInScreen
                    }
                    
                    else
                    {
                        self.UIstate = .goToHomeScreen
                    }
                }
            }
                
                
        
       
    }
    
    
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
 
}
extension SplashViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView(publisher: publisher)
       
    }

}

