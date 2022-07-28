//
//  ListQuizViewModel.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 22/07/2022.
//

import Foundation
import RxSwift
import RxRelay

class ListExamsViewModel {
    let listExams = PublishRelay<Exams>()
    let bag = DisposeBag()
    let getListExams: ListExamsProtocol = ListExamsAPI()
    let errorAPI = PublishRelay<ApiError>()
    
    func getListExams(page: Int, perPage: Int, mId: Int, isSubjectId: Bool) {
        getListExams.getExam(page: page, perPage: perPage, mId: mId, isSubjectId: isSubjectId).subscribe { exams in
            self.listExams.accept(exams)
        } onFailure: { error in
            self.errorAPI.accept(error as! ApiError)
        }.disposed(by: bag)
    }
}
