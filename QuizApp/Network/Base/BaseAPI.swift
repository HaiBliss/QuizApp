//
//  BaseAPI.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 14/06/2022.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

class BaseAPI<T: TargetType> {
    func featchData<M: Decodable>(target: T, responseClass: M.Type) -> Single<M> {
        
        Single.create { observer in
            let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
            let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
            let parameters = self.buildParams(task: target.task)
            
            print(target.baseURL + target.path)
            AF.request(target.baseURL + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers).responseJSON { reponse in

                guard let statusCode = reponse.response?.statusCode else {
                    print("Status code not found")
                    observer(.failure(NSError(domain: target.baseURL + target.path, code: 1)))
                    return
                }
                
                switch statusCode {
                case 200, 400:
                    guard let jsonResponse = try? reponse.result.get() else {
                        print("jsonReponse error")
                        observer(.failure(NSError(domain: target.baseURL + target.path, code: 2)))
                        return
                    }
                    
                   guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                       print("theJSONData error")
                       observer(.failure(NSError(domain: target.baseURL + target.path, code: 2)))
                       return
                   }
        
                   guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
                       print("responseObj error")
                       observer(.failure(NSError(domain: target.baseURL + target.path, code: 2)))
                       return
                   }
                   observer(.success(responseObj))
                    break
                default:
                    print("error statusCode is \(statusCode)")
                    observer(.failure(NSError(domain: target.baseURL + target.path, code: statusCode)))
                    break
                }
            }
            return Disposables.create()
        }
    }
    
    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding){
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}
