//
//  ProjectManager.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/06/2022.
//

import Foundation
import UIKit

class ProjectManager: NSObject {
    var userInfo: User?
}

enum TabItem: String, CaseIterable {
    case HOME
    case EXAM_UPLOAD
    case HISTORY
    case PROFILE
    
    var viewController: UIViewController {
        switch self {
        case .HOME:
            let vc = R.storyboard.homeViewController.baseNavigationController()!
            return vc
        case .EXAM_UPLOAD:
            return UINavigationController(
                rootViewController: R.storyboard.examUploadViewController.examUploadViewController()!
            )
        case .HISTORY:
            return UINavigationController(
                rootViewController: R.storyboard.historyViewController.historyViewController()!
            )
        case .PROFILE:
            return UINavigationController(
                rootViewController: R.storyboard.userInfoViewController.userInfoViewController()!
            )
        }
    }
}
