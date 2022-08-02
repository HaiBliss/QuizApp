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
            AF.request(target.baseURL + target.path,
                       method: method,
                       parameters: parameters.0,
                       encoding: parameters.1,
                       headers: headers).responseDecodable(of: M.self) { response in

                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else {
                        return
                    }
                    
                    switch statusCode {
                        case 200, 400:
                            guard let responseObj = try? JSONDecoder().decode(M.self, from: response.data ?? Data()) else {
                                print("responseObj error")
                                observer(.failure(ApiError.commonError(code: statusCode, messages: "Response could not be decoded")))
                                return
                            }
                            observer(.success(responseObj))
                            break
                        
                        default:
                            observer(.failure(ApiError.unknow(code: statusCode)))
                            break
                    }
                    
                case .failure(let error):
                    if (error as NSError).code == NSURLErrorCancelled {
                        debugPrint("Request cancelled: \(error.localizedDescription)")
                        return
                    }
    
                    debugPrint("Request error: \(error.localizedDescription)")
                    observer(.failure(ApiError.commonError(
                        code: error.responseCode ?? -1,
                        messages: "\(error.localizedDescription)"
                        )))
                    return
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
