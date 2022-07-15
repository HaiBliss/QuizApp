//
//  ProjectManager.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/06/2022.
//

import Foundation

enum TabBar {
    case HOME
    case EXAM_UPLOAD
    case HISTORY
    case PROFILE
}

class ProjectManager: NSObject {
    var userInfo: User?
    var ACCEPT_TOKEN: String?
    
    
    class var sharedInstance: ProjectManager {
        struct Static {
            static let instance : ProjectManager = ProjectManager()
        }
        return Static.instance
    }
}
