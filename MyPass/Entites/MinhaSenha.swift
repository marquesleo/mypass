//
//  MinhaSenha.swift
//  MyPass
//
//  Created by Leonardo Marques on 19/10/23.
//


import Foundation

class MinhaSenha: Identifiable, Codable {
    var Id = UUID()
    var Descricao: String
    var Observacao: String?
    var Ativo: Bool
    var Usuario_Site:String
    var Usuario:UUID
    var Site:String
    var Password:String
    var UrlImageSite:String?
    var ImagemData:String?
    var NomeDaImagem:String?
    
    init(Descricao: String,
         Observacao: String,
         Ativo: Bool,
         Usuario_Site: String,
         Usuario: UUID,
         Site: String,
         Password: String,
         UrlImageSite: String,
         ImagemData: String,
         NomeDaImagem: String) {
       
        self.Descricao = Descricao
        self.Observacao = Observacao
        self.Ativo = Ativo
        self.Usuario_Site = Usuario_Site
        self.Usuario = Usuario
        self.Site = Site
        self.Password = Password
        self.UrlImageSite = UrlImageSite
        self.ImagemData = ImagemData
        self.NomeDaImagem = NomeDaImagem
    }
    
    enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case Descricao = "Descricao"
        case Observacao = "Observacao"
        case Ativo = "Ativo"
        case Usuario_Site = "Usuario_Site"
        case Usuario = "Usuario"
        case Site = "Site"
        case Password = "Password"
        case UrlImageSite = "UrlImageSite"
        case ImagemData = "ImagemData"
        case NomeDaImagem = "NomeDaImagem"
            
    }
}
