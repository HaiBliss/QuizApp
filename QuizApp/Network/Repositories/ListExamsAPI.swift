//
//  ListExamsAPI.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 22/07/2022.
//

import Foundation
import RxSwift

protocol ListExamsProtocol {
    func getExam(page: Int, perPage: Int, mId: Int, isSubjectId: Bool) -> Single<Exams>
}

class ListExamsAPI: BaseAPI<RepositoriesNetworking>, ListExamsProtocol {
    func getExam(page: Int, perPage: Int, mId: Int, isSubjectId: Bool) -> Single<Exams> {
        self.featchData(target: .getExams(page: page, perPage: perPage, mId: mId, isSubjectId: isSubjectId), responseClass: Exams.self)
    }
    
}
