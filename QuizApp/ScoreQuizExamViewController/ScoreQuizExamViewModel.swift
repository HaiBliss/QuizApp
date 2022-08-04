//
//  ScoreQuizExamViewModel.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 03/08/2022.
//

import Foundation
import RxCocoa
import RxSwift

class ScoreQuizExamViewModel {
    let quizs = PublishRelay<Quizs>()
    let bag = DisposeBag()
    let quizData: QuizProtocol = QuizAPI()
    let errorAPI = PublishRelay<ApiError>()
    
    func postQuizAnswer(quizRequest: QuizRequest) {
        quizData.postQuizAnswer(quizRequest: quizRequest).subscribe {[weak self] data in
            self?.quizs.accept(data)
        } onFailure: { error in
            self.errorAPI.accept(error as! ApiError)
        }.disposed(by: bag)
    }
}
