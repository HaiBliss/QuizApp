//
//  HomeViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/06/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var tabBarView: TabBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        tabBarView.activeButton(tab: .HOME)
        actionTap()

    }
    
    func actionTap() {
        tabBarView.selectTab = { tabName in
            switch tabName {
            case .EXAM_UPLOAD:
                guard let vc = R.storyboard.examUploadViewController.examUploadViewController() else {
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
