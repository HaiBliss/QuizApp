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
    let departments = PublishRelay<Departments>()
    let bag = DisposeBag()
    let departmentData: DepartmentIProtocol = DepartmentAPI()

    func getDepartmentHome(page: Int, perPage: Int) {
        departmentData.getDepartment(page: page, perPage: perPage).subscribe { deparment in
            self.departments.accept(deparment)
        } onFailure: { error in
            print("Lỗi API")
        }.disposed(by: bag)
    }
}

