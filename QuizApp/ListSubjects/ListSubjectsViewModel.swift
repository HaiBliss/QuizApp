//
//  ListSubjectsViewModel.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 19/07/2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class ListSubjectsViewModel {
    let subjectsDepartment = PublishRelay<Departments>()
    let bag = DisposeBag()
    let getSubjectsDepartment: DepartmentIProtocol = DepartmentAPI()
    let errorAPI = PublishRelay<ApiError>()
    
    func getSubjectsDepartment(page: Int, perPage: Int, departmentId: Int) {
        getSubjectsDepartment.getSubjectsDepartment(page: page, perPage: perPage, departmentId: departmentId).subscribe { subjectsDepartment in
            self.subjectsDepartment.accept(subjectsDepartment)
        } onFailure: { error in
            self.errorAPI.accept(error as! ApiError)
        }.disposed(by: bag)
    }
}
