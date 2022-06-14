//
//  Constants.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 14/06/2022.
//

import Foundation
import Alamofire

struct Constants {
    //The API's base URL
       static let baseUrl = "https://quanghuy.me"

    //The header fields
    enum Header: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
    
    enum ApiError: Error {
        case forbidden              //Status code 403
        case notFound               //Status code 404
        case conflict               //Status code 409
        case internalServerError    //Status code 500
    }
}
