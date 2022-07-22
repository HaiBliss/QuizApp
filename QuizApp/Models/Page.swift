//
//  Page.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 22/07/2022.
//

import Foundation

struct Page: Codable {
    let current_page: Int?
    let from: Int?
    let to: Int?
    let last_page: Int?
    let total: Int?
    let per_page: String?
}
