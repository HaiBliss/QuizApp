//
//  Quizs.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/07/2022.
//

import Foundation

struct Quizs: Codable {
    let code: Int?
    let success: Bool?
    let message: String?
    let data: [Quiz]?
    let page: Page?
    
    struct Quiz: Codable {
        let id: Int?
        let exams_id: Int?
        let name: String?
        let answer_type: Int?
        let image: String?
        let created_date: String?
        let updated_date: String?
        let del_flg: Int?
        let answers: [Answer]?
        
        struct Answer: Codable {
            let id: Int?
            let questions_id: Int?
            let value: String?
            let image: String?
            let del_flg: Int?
        }
    }
}
