//
//  DepartmentAPI.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 15/07/2022.
//

import Foundation
import RxSwift

protocol DepartmentIProtocol {
    func getDepartment(page: Int, perPage: Int, name: String?) -> Single<Departments>
}

class DepartmentAPI: BaseAPI<RepositoriesNetworking>, DepartmentIProtocol {
    func getDepartment(page: Int, perPage: Int, name: String?) -> Single<Departments> {
        self.featchData(target: .department(page: page, perPage: perPage, name: name), responseClass: Departments.self)
    }
}
