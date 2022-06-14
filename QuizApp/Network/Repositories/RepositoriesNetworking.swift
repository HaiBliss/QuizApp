//
//  Repositories.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 14/06/2022.
//

import Foundation
import Alamofire

enum RepositoriesNetworking {
    case login(email: String, password: String)
    case signup(name: String, email: String, password: String)
}

extension RepositoriesNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return "https://quanghuy.me/api"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login(_, _):
            return .post
        case .signup(_, _, _):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters: ["email" : email,
                                                   "password" : password ],
                                      encoding: URLEncoding.default)
        case .signup(let name, let email, let password):
            return.requestParameters(parameters: ["name" : name,
                                                  "email" : email,
                                                  "password" : password ],
                                     encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login(_, _):
            return [:]
        case .signup(_, _, _):
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .login(_, _):
            return "/account/login"
        case .signup(_, _, _):
            return "/account/register"
        }
    }
    
}
