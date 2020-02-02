//
//  IMConfig.swift
//  iMovie
//
//  Created by bruno on 09/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation
import Alamofire

// um typealias para um bloco simples é necessário.
typealias CompletionSuccess = (() -> Void)?

#if RELEASE
let debugRequests = false
#else
let debugRequests = true
#endif

// muda esse Fetcher para qualquer outro nome
class IMConfig<T: Fetcher> {
    
    let alamofireManager = Alamofire.SessionManager.default
    
    public func fetch<V: Codable>(target: T,
                                  dataType: V.Type,
                                  completion: ((Result<V>, URLResponse?) -> Void)?) {
        // mantenha-se em nomeclaturas EN, esquece PT ou mistureba. 
        requestCodable(metodo: target.method,
                       objeto: dataType,
                       parametros: target.task?.dictionary() ?? [:],
                       url: target.path,
                       onSuccess: { response, result in
                       completion?(.success(result), response)
        }, onFail: { response, error in
            completion?(.failure(error), response)
        })
    }
    
    private func requestCodable<T>(metodo: HTTPMethod,
                                   objeto: T.Type,
                                   parametros: [String: Any] = [:],
                                   token: String = "",
                                   url: String? = nil,
                                   onSuccess: @escaping (_ response: HTTPURLResponse, _ objeto: T) -> Void,
                                   onFail: @escaping (_ response: HTTPURLResponse?, _ error: Error) -> Void)
        where T: Codable {
            
            if !Utils.isConnectedToNetwork() {
                // da erro mas não passa o objeto/ tipo pra frente?
                onFail(nil, IMError())
                return
            }
            
            var parameters = parametros
            var urlRequisicao = ""
            
            if debugRequests && metodo == .post {
                print("\n\n===========JSON===========")
                parametros.printJson()
                print("===========================\n\n")
            }
            
            if let url = url {
                urlRequisicao = API.baseUrl + url
            } else {
                // da erro mas não passa o objeto pra frente?
                onFail(nil, IMError())
                print("Ocorreu um erro, nenhum método padrão esta definido e nenhuma url personalizada esta definida")
                return
            }
            
            parameters["api_key"] = API.ApiKey
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            var encoded: ParameterEncoding = JSONEncoding.default
            
            if metodo == .get {
                encoded = URLEncoding.default
            }
            
            Alamofire.request(urlRequisicao,
                              method: metodo,
                              parameters: parameters, encoding: encoded, headers: headers).debugLog()
                .responseJSON { (response) in
                    
                    if debugRequests {
                        print("""
                            \n\nRequest: \(String(describing: response.request))
                            \nParametros: \n\(parametros)
                            \nTipo requisição:\(metodo)\n\n
                            """)
                        print(response)
                    }
                    
                    switch response.result {
                    case .success:
                        // como esses force casts passaram no lint?
                        do {
                            let objeto = try JSONDecoder().decode(objeto.self, from: response.data!)
                            onSuccess(response.response!, objeto)
                        } catch let error {
                            // vc tem que passar o erro do decode para frente... a camada para por aqui sem fazer nada.
                            print("\n\n===========Error===========")
                            print("Error Code: \(error._code)")
                            print("Error Messsage: \(error.localizedDescription)")
                            if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8) {
                                print("Server Error: " + str)
                            }
                            debugPrint(error as Any)
                            print("===========================\n\n")
                        }
                        
                    case .failure(let error):
                        print("\n\n===========Error===========")
                        print("Error Code: \(error._code)")
                        print("Error Messsage: \(error.localizedDescription)")
                        if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8) {
                            print("Server Error: " + str)
                        }
                        debugPrint(error as Any)
                        print("===========================\n\n")
                        onFail(response.response, IMError())
                    }
            }
    }
}
