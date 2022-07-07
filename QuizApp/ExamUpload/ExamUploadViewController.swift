//
//  ExamUploadViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 29/06/2022.
//

import UIKit

class ExamUploadViewController: UIViewController {

    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var tabBarView: TabBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        tabBarView.activeButton(tab: .EXAM_UPLOAD)
        actionTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController()?.gestureEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController()?.gestureEnabled = true
    }
    
    func actionTap() {
        tabBarView.selectTab = { tabName in
            switch tabName {
            case .HOME:
                guard let vc = R.storyboard.homeViewController.homeViewController() else {
                    return
                }
                self.navigationController?.setViewControllers([vc], animated: false)
                break
            case .HISTORY:
                guard let vc = R.storyboard.historyViewController.historyViewController() else {
                    return
                }
                self.navigationController?.setViewControllers([vc], animated: false)
                break
            case TabBar.PROFILE:
                guard let vc = R.storyboard.userInfoViewController.userInfoViewController() else {
                    return
                }
                self.navigationController?.setViewControllers([vc], animated: false)
                break
            default:
                break
            }
        }
    }
    


}
