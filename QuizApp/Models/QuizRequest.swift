//
//  QuizRequest.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 03/08/2022.
//

import Foundation

struct QuizRequest: Codable {
    var exam_id: Int
    var start_time: String
    var completion_time: String
    var answer: [Answer]
    
    struct Answer: Codable {
        let quiz_id: Int
        var answer: Int = -1
    }
    
    var dictionaryQuizRequest: [String: Any] {
       return [
        "exam_id" : exam_id as Any,
        "start_time" : start_time as Any,
        "completion_time" : completion_time as Any,
        "answer": answer as Any
       ]
    }
}
