//
//  ApiError.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/07/2022.
//

import Foundation

enum ApiError: CustomNSError {
    case commonError(code: Int, messages: String)
    case invalidJson
    case unknow(code: Int?)
    case networkError
}
