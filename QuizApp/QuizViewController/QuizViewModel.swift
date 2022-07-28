//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/07/2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class QuizViewModel {
    let quizs = PublishRelay<Quizs>()
    let bag = DisposeBag()
    let quizData: QuizProtocol = QuizAPI()
    let errorAPI = PublishRelay<ApiError>()

    func getQuizs(page: Int, perPage: Int ,examId: Int) {
        quizData.getQuiz(page: page, per_page: perPage, exam_id: examId).subscribe { data in
            self.quizs.accept(data)
        } onFailure: { error in
            self.errorAPI.accept(error as! ApiError)
        }.disposed(by: bag)
    }
}
