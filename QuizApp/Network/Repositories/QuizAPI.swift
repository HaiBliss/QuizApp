//
//  QuizAPI.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/07/2022.
//

import Foundation
import RxSwift

protocol QuizProtocol {
    func getQuiz(page: Int, per_page: Int, exam_id: Int) -> Single<Quizs>
}

class QuizAPI: BaseAPI<RepositoriesNetworking>, QuizProtocol {
    func getQuiz(page: Int, per_page: Int, exam_id: Int) -> Single<Quizs> {
        self.featchData(target: .getQuizs(page: page, perPage: per_page, examId: exam_id), responseClass: Quizs.self)
    }
    
}
