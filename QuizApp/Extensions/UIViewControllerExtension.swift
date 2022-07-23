//
//  UIViewControllerExtension.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 19/07/2022.
//

import Foundation
import  UIKit
extension UIViewController {
    func pushHome() {
        guard let vc = R.storyboard.homeViewController.homeViewController() else {
            return
        }
        self.navigationController?.setViewControllers([vc], animated: false)
    }
    
    func pushExamsUpload() {
        guard let vc = R.storyboard.examUploadViewController.examUploadViewController() else {
            return
        }
        self.navigationController?.setViewControllers([vc], animated: false)
    }
    
    func pushHistory() {
        guard let vc = R.storyboard.historyViewController.historyViewController() else {
            return
        }
        self.navigationController?.setViewControllers([vc], animated: false)
    }
    
    func pushProfile() {
        guard let vc = R.storyboard.userInfoViewController.userInfoViewController() else {
            return
        }
        self.navigationController?.setViewControllers([vc], animated: false)
    }
    
    func pushExams(subject: Departments.Department.Subject, isSubject: Bool) {
        guard let vc = R.storyboard.listExamsViewController.listExamsViewController() else {
            return
        }
        vc.subject = subject
        vc.isSubject = isSubject
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = R.color.f94FB()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func pushListSubject(departmentId: Int) {
        guard let vc = R.storyboard.listSubjectsViewController.listSubjectsViewController() else {
            return
        }
        vc.departmentId = departmentId
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = R.color.f94FB()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func pushTabbar(tab: TabBar) {
        switch tab {
            case .HOME:
                pushHome()
                break
            case .EXAM_UPLOAD:
               pushExamsUpload()
                break
            case .HISTORY:
                pushHistory()
                break
            case .PROFILE:
                pushProfile()
                break
            case .NONE:
                break
        }
    }
}
