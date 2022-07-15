//
//  Departments.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 15/07/2022.
//

import Foundation

struct Departments: Codable {
    let code: Int?
    let success: Bool?
    let message: String?
    let data: [Department]?
    
    struct Department: Codable {
        let id: Int?
        let name: String?
        let image: String?
        let created_date: String?
        let updated_date: String?
        let del_flg: String?
        let subjects: [Subject]
        
        struct Subject: Codable {
            let id: Int?
            let name: String?
            let department_id: Int?
            let image: String?
            let created_date: String?
            let updated_date: String?
            let del_flg: String?
        }
    }
}
