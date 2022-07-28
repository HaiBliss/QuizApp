//
//  QuizAPI.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/07/2022.
//

import Foundation
import RxSwift

protocol QuizProtocol {
    func getQuiz()
}

class QuizAPI: BaseAPI<RepositoriesNetworking>, QuizProtocol {
    func getQuiz() {
    }
}
