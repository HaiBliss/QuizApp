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
    case department(page: Int, perPage: Int, name: String?)
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
        case .department(_, _, _):
            return .get
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
        case .department(page: let page, perPage: let perPage, name: let name):
            return .requestParameters(parameters: ["page": page,
                                                   "per_page": perPage,
                                                   "name": name as Any
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login(_, _):
            return [:]
        case .signup(_, _, _):
            return [:]
        case .department(_, _, _):
            guard let token = ProjectManager.sharedInstance.userInfo?.token else {
                return [:]
            }
            return["Authorization":"Bearer " + token]
        }
    }
    
    var path: String {
        switch self {
        case .login(_, _):
            return "/account/login"
        case .signup(_, _, _):
            return "/account/register"
        case .department(_, _, _):
            return "/department"
        }
    }
    
}
