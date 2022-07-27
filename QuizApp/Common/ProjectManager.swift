//
//  ProjectManager.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/06/2022.
//

import Foundation
import NVActivityIndicatorView
import UIKit

enum TabBar {
    case HOME
    case EXAM_UPLOAD
    case HISTORY
    case PROFILE
    case NONE
}

class ProjectManager: NSObject {
    var userInfo: User?
    var ACCEPT_TOKEN: String?
    var activeTab: TabBar = .NONE
    var isLoading = false
    let background = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    let loading = NVActivityIndicatorView(frame: .zero, type: .ballClipRotatePulse, color: UIColor(named: "8F94FB"), padding: 0)
    
    
    class var sharedInstance: ProjectManager {
        struct Static {
            static let instance : ProjectManager = ProjectManager()
        }
        return Static.instance
    }
}
