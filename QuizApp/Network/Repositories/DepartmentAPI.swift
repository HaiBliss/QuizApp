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
    func getDepartment(page: Int, perPage: Int) -> Single<Departments>
    
    func getSubjectsDepartment(page: Int, perPage: Int, departmentId: Int) -> Single<Departments>
}

class DepartmentAPI: BaseAPI<RepositoriesNetworking>, DepartmentIProtocol {
    func getDepartment(page: Int, perPage: Int) -> Single<Departments> {
        self.featchData(target: .department(page: page, perPage: perPage), responseClass: Departments.self)
    }
    
    func getDepartment(page: Int, perPage: Int, name: String?) -> Single<Departments> {
        self.featchData(target: .departmentInfo(page: page, perPage: perPage, name: name), responseClass: Departments.self)
    }
    
    func getSubjectsDepartment(page: Int, perPage: Int, departmentId: Int) -> Single<Departments> {
        self.featchData(target: .getSubjectsDepartment(page: page, perPage: perPage, departmentId: departmentId), responseClass: Departments.self)
    }
}
