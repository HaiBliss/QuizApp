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
//                let vc = R.storyboard.homeViewController.homeViewController()!
                let vc = R.storyboard.homeViewController.baseNavigationController()!
                return vc
            case .EXAM_UPLOAD:
                let vc = R.storyboard.examUploadViewController.examUploadViewController()!
                return vc
            case .HISTORY:
                let vc = R.storyboard.historyViewController.historyViewController()!
                return vc
            case .PROFILE:
                let vc = R.storyboard.userInfoViewController.userInfoViewController()!
                return vc
        }
    }
}
