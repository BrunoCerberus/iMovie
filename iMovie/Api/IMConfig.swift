//
//  IMConfig.swift
//  iMovie
//
//  Created by bruno on 09/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation
import Alamofire

#if RELEASE
let debugRequests = false
#else
let debugRequests = true
#endif

class IMConfig<T: Fetcher> {
    
    let alamofireManager = Alamofire.SessionManager.default
    
    public func fetch<V: Codable>(target: T,
                                  dataType: V.Type,
                                  completion: ((Result<V>, URLResponse?) -> Void)?) {
        
        requestCodable(metodo: target.method,
                       objeto: V.self,
                       parametros: nil,
                       url: target.path,
                       onSuccess: { response, result in
                       completion?(.success(result), response)
        }, onFail: { response, error in
            completion?(.failure(error), response)
        })
    }
    
    private func requestCodable<T>(metodo: HTTPMethod,
                                   objeto: T.Type,
                                   parametros: [String: Any]? = [:],
                                   token: String = "",
                                   url: String? = nil,
                                   onSuccess: @escaping (_ response: HTTPURLResponse, _ objeto: T) -> Void,
                                   onFail: @escaping (_ response: HTTPURLResponse?, _ error: Error) -> Void)
        where T: Codable {
            
            if !Utils.isConnectedToNetwork() {
                onFail(nil, IMError())
                return
            }
            
            var parameters = parametros
            var urlRequisicao = ""
            
            if debugRequests && metodo == .post {
                print("\n\n===========JSON===========")
                parametros?.printJson()
                print("===========================\n\n")
            }
            
            if let url = url {
                urlRequisicao = API.baseUrl + url
            } else {
                onFail(nil, IMError())
                print("Ocorreu um erro, nenhum método padrão esta definido e nenhuma url personalizada esta definida")
                return
            }
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            //            var encoded: ParameterEncoding = JSONEncoding.default
            
            if metodo == .get {
                //                encoded = URLEncoding.default
                parameters?["api_key"] = "URLs.ApiKey"
            }
            
            Alamofire.request(urlRequisicao,
                              method: metodo,
                              parameters: parameters, encoding: URLEncoding.default, headers: headers).debugLog()
                .responseJSON { (response) in
                    
                    if debugRequests {
                        print("""
                            \n\nRequest: \(String(describing: response.request))
                            \nParametros: \n\(parametros ?? [:])
                            \nTipo requisição:\(metodo)\n\n
                            """)
                        print(response)
                    }
                    
                    switch response.result {
                    case .success:
                        
                        do {
                            let objeto = try JSONDecoder().decode(objeto.self, from: response.data!)
                            onSuccess(response.response!, objeto)
                        } catch let error {
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
