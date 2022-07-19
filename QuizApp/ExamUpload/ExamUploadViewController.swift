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
            self.pushTabbar(tab: tabName)
        }
    }
    


}
