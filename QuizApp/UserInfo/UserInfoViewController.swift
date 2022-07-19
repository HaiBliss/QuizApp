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
            self.pushTabbar(tab: tabName)
        }
    }

}
