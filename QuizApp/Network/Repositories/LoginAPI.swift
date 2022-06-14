//
//  LoginAPI.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 14/06/2022.
//

import Foundation
import RxSwift

protocol LoginAPIProtocol {
    func login(email: String, password: String) -> Single<User>
}

class LoginAPI: BaseAPI<RepositoriesNetworking>, LoginAPIProtocol {
    func login(email: String, password: String) -> Single<User> {
        self.featchData(target: .login(email: email, password: password), responseClass: User.self)
    }
}
