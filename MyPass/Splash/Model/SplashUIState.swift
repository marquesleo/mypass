//
//  SplashUIState.swift
//  MyPass
//
//  Created by Leonardo Marques on 13/10/23.
//

import Foundation

enum SplashUIState {
    case loading //carregando
    case goToSignInScreen //vai para o login
    case goToHomeScreen //vai para a  home
    case error(String)
}
