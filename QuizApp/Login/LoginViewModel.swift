//
//  LoginViewModel.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 14/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class LoginViewModel {
    let loginInfo = PublishRelay<User>()
    let bag = DisposeBag()
    let loginData: LoginAPIProtocol = LoginAPI()
    
    func login(email: String, password: String) {
        
        loginData.login(email: email, password: password).subscribe { user in
            self.loginInfo.accept(user)
        } onFailure: { error in
//            print(error)
        }.disposed(by: bag)
    }
}
