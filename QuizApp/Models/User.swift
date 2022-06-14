//
//  User.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 14/06/2022.
//

import Foundation
import SwiftyJSON
import UIKit

struct User: Codable {
    let code: Int?
    let success: Bool?
    let message: String?
    let data: UserInfo?
    let token: String?
    
    struct UserInfo: Codable {
        let id: Int?
        let name: String?
        let email: String?
        let phone: String?
        let address: String?
        let province: String?
        let district: String?
        let avatar: String?
        let action_code: String?
        let created_at: String?
        let update_at: String?
        let status: Int
    }
    
    init(json: JSON) {
        self.code = json["code"].intValue
        self.success = json["success"].boolValue
        self.message = json["message"].stringValue
        self.token = json["token"].stringValue
        self.data = UserInfo(id: json["id"].intValue,
                             name: json["name"].stringValue,
                             email: json["email"].stringValue,
                             phone: json["phone"].stringValue,
                             address: json["address"].stringValue,
                             province: json["province"].stringValue,
                             district: json["district"].stringValue,
                             avatar: json["avatar"].stringValue,
                             action_code: json["action_code"].stringValue,
                             created_at: json["created_at"].stringValue,
                             update_at: json["update_at"].stringValue,
                             status: json["status"].intValue)
    }
}
