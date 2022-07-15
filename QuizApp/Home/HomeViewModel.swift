//
//  HomeViewModel.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 15/07/2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class HomeViewModel {
    let departmentsInfo = PublishRelay<Departments>()
    let bag = DisposeBag()
    let departmentData: DepartmentIProtocol = DepartmentAPI()
    
    func getDepartmentHome(page: Int, perPage: Int, name: String?) {
        departmentData.getDepartment(page: page, perPage: perPage, name: name).subscribe { deparment in
            self.departmentsInfo.accept(deparment)
        } onFailure: { error in
            
        }.disposed(by: bag)
    }
}

