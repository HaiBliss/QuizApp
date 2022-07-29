//
//  UIViewControllerExtension.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 19/07/2022.
//

import Foundation
import  UIKit

extension UIViewController {
    func pushBase() {
        let storyboard = UIStoryboard(name: "BaseViewController", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BaseViewController")
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
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
    
    func presentQuiz(examId: Int,  timer: Int) {
        guard let vc = R.storyboard.quizViewController.quizViewController() else {
            return
        }
        vc.bindData(examId: examId, timer: timer)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func presentImageVC(url: String) {
//        guard let vc = R.storyboard.popupImageViewController.popupImageViewController() else {
//            return
//        }
        
        let vc = ImagePopupViewController(nibName: "ImagePopupViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.urlImage = url
        self.present(vc, animated: false)
    }
    
    func presentQuizAnswer(listQuizs: [Quizs.Quiz]) -> QuizAnswerViewController?{
        let vc = R.storyboard.quizAnswerViewController.quizAnswerViewController()!
        
        vc.listQuizs = listQuizs
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
        return vc
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
    
    
    func loadingView(isRuning: Bool) {
       
        if ProjectManager.sharedInstance.isLoading == false {
            ProjectManager.sharedInstance.background.backgroundColor = UIColor(named: "trangmo")
            view.addSubview(ProjectManager.sharedInstance.background)
            ProjectManager.sharedInstance.background.addSubview(ProjectManager.sharedInstance.loading)
            ProjectManager.sharedInstance.loading.translatesAutoresizingMaskIntoConstraints = false
            let constraints = [
                ProjectManager.sharedInstance.loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                ProjectManager.sharedInstance.loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                ProjectManager.sharedInstance.loading.widthAnchor.constraint(equalToConstant: 40),
                ProjectManager.sharedInstance.loading.heightAnchor.constraint(equalToConstant: 40)
            ]
            NSLayoutConstraint.activate(constraints)
        }
        
        if isRuning {
            ProjectManager.sharedInstance.isLoading = true
            ProjectManager.sharedInstance.loading.startAnimating()
        } else {
            ProjectManager.sharedInstance.isLoading = false
            ProjectManager.sharedInstance.background.removeFromSuperview()
        }
    }
    
    func alertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func confirmView(title: String, message: String, onOK: (() -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            onOK?()
        }
        let cancelAction = UIAlertAction(title: "Huỷ", style: .default, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
