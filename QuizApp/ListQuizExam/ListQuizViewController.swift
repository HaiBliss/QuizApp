//
//  ListQuizViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 18/07/2022.
//

import UIKit

class ListQuizViewController: UIViewController {

    @IBOutlet weak var tabBarView: TabBarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subjectImage: UIImageView!
    @IBOutlet weak var subjectNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        actionTap()
        bindData()

        
    }
    
    func setupView() {
        tableView.register(QuizTableViewCell.nib(), forCellReuseIdentifier: QuizTableViewCell.indentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func bindData() {
        
    }
    
    func actionTap() {
        tabBarView.selectTab = { tabName in
            self.pushTabbar(tab: tabName)
        }
    }
    
}

extension ListQuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizTableViewCell.indentifier, for: indexPath) as! QuizTableViewCell
        return cell
    }
}
