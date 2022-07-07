//
//  UserInfoViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/06/2022.
//

import UIKit

class UserInfoViewController: UIViewController {

    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var tabBarView: TabBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        tabBarView.activeButton(tab: .PROFILE)
        actionTap()
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
            case TabBar.EXAM_UPLOAD:
                guard let vc = R.storyboard.examUploadViewController.examUploadViewController() else {
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
