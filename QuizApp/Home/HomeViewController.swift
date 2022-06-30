//
//  HomeViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/06/2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupView()
        self.title = "Home Page"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: nil)
        

    }
    
    @IBAction func abcTap(_ sender: Any) {
        guard let vc = R.storyboard.historyViewController.historyViewController() else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    func setupView() {
        navigationController?.navigationBar.tintColor = .white
        
    }
}
