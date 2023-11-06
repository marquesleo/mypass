//
//  SenhaCardViewModel.swift
//  MyPass
//
//  Created by Leonardo Marques on 26/10/23.
//
import SwiftUI
import Combine

struct SenhaCardViewModel:  Equatable, Identifiable {
    var id: UUID = UUID()
 
    var Descricao:String = "XP"
    var Observacao:String = "Site de investimento"
    var Site:String = "http://xp.com.br"
    var Usuario_Site:String = "leopac"
    var ImageStr:String=""
    var Password:String=""
    var senhaViewPublisher: PassthroughSubject<Bool,Never>
    
   
    
    
    func getImage() -> Image {
        if let base64 = ImageStr.split(separator: ",").last.map(String.init),
                  let data = Data(base64Encoded: base64) {
                   if let uiImage = UIImage(data: data) {
                       return Image(uiImage: uiImage)
                           
                   } else {
                       return Image("")
                   }
               } else {
                   return Image("")
               }
  
    }
    
    static func == (lhs: SenhaCardViewModel, rhs: SenhaCardViewModel) -> Bool {
        return lhs.id == rhs.id
        
    }
}

extension SenhaCardViewModel {
    func SenhaDetailView() -> some View {
        return SenhaCardViewRouter.makeSenhaDetailView(id: self.id,
                                                       descricao: self.Descricao,
                                                       observacao: self.Observacao,
                                                       usuario: self.Usuario_Site,
                                                       site: self.Site,
                                                       password: self.Password,
                                                       senhaViewPublisher: self.senhaViewPublisher)
    }
}

