//
//  Exams.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 22/07/2022.
//

import Foundation

struct Exams: Codable {
    let code: Int?
    let success:Bool?
    let message: String?
    let data: [Exam]?
    let page: Page?
    
    struct Exam: Codable {
        let id: Int?
        let name: String?
        let department: String?
        let department_id: Int?
        let subject: String?
        let subject_id: String?
        let image: String?
        let created_date: String?
        let updated_date: String?
        let time_count: Int?
        let question_count: Int?
    }
}
