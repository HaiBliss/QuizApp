//
//  HistoryViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 29/06/2022.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var tabBarView: TabBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        tabBarView.activeButton(tab: .HISTORY)
        actionTap()
    }
    
    func actionTap() {
        tabBarView.selectTab = { tabName in
            self.pushTabbar(tab: tabName)
        }
    }

}
