//
//  ServiceBase.swift
//  MyPass
//
//  Created by Leonardo Marques on 16/10/23.
//

import Foundation

struct ServiceBase {
    
    static let baseURL = "https://priorities.azurewebsites.net/api"
    
    enum Endpoint {
               
        
        
        case base
        
        case postUser
        case loginUser
        case getUser(id: UUID)
        
        case postSenha
        case getSenha(id: UUID)
        case getAllSenha(idUsuario:UUID)
        
        case postCategoria
        case getCategoria(id:UUID)
        case getAllCategoria(idUsuario:UUID)
        
       
        
        var rawValue: String {
            switch self {
            case .base:
                return "https://priorities.azurewebsites.net/api"
            case .postUser:
                return "/v1/usuario"
            case .loginUser:
                return "/v1/usuario/autenticar"
            case .getUser(let id):
                return "/v1/usuario/" + id.uuidString
            case .postSenha:
                return "/v1/senha"
            case .getSenha(let id):
                return "/v1/senha/" + id.uuidString
    
            case .getAllSenha(let idUsuario):
                return "/v1/senha?usuario_id=" + idUsuario.uuidString
                
                
            case .postCategoria:
                return  "/v1/categoria"
            case .getCategoria(let id):
                return "/v1/categoria/" + id.uuidString
            case .getAllCategoria(let idUsuario):
                return  "/v1/categoria?usuario_id=" + idUsuario.uuidString
            }
        }
    }
    enum NetworkError{
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
        
    }
    enum Method: String {
        case POST = "POST"
        case GET = "GET"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
        
    }
    
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)")
        else
        {
            return nil
        }
        return  URLRequest(url:url)
    }
    
    public static func call<T:Encodable>(path:Endpoint,
                                         method:Method,
                                         body: T?,
                                         utilizaToken:Bool,
                                         callback: @escaping (Result) -> Void)
    {
        guard var urlRequest = completeUrl(path: path)
        else { return }
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        guard let jsonData = try? encoder.encode(body) else { return }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        if utilizaToken {
            let token = tokenEUsuario.shared.Token
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let  data = data, error == nil else {
              
                callback(.failure(.internalServerError, nil))
                return
            }
            if let r = response as? HTTPURLResponse {
                switch r.statusCode {
                case 400:
                    callback(.failure(.badRequest,data))
                    break
                case 200, 201:
                    callback(.success(data))
                    break
                default:
                    
                    break
                }
          
            }
 
        }
        task.resume()
    }
    
    
    public static func call(path:Endpoint,
                            method:Method,
                            utilizaToken: Bool,
                            callback: @escaping (Result) -> Void)
    {
        guard var urlRequest = completeUrl(path: path)
        else { return }
        
       
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if utilizaToken {
            let token = tokenEUsuario.shared.Token
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let  data = data, error == nil else {
              
                callback(.failure(.internalServerError, nil))
                return
            }
            if let r = response as? HTTPURLResponse {
                switch r.statusCode {
                case 400:
                    callback(.failure(.badRequest,data))
                    break
                case 200, 201:
                    callback(.success(data))
                    break
                default:
                    
                    break
                }
          
            }
 
        }
        task.resume()
    }
    
}
    
