//
//  AppUtil.swift
//  QuizApp
//
//  Created by it on 29/06/2022.
//

import UIKit

struct AppUtil {
    static var window: UIWindow? {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    }
}
