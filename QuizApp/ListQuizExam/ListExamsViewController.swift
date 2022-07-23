//
//  ListQuizViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 18/07/2022.
//

import UIKit
import RxSwift

class ListExamsViewController: UIViewController {

    @IBOutlet weak var tabBarView: TabBarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subjectImage: UIImageView!
    @IBOutlet weak var subjectNameLabel: UILabel!
    private var viewModel = ListExamsViewModel()
    private var bag = DisposeBag()
    private var listExams: [Exams.Exam] = []
    var isSubject: Bool = true
    var subject: Departments.Department.Subject?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        actionTap()
        bindData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Home"
        navigationItem.backBarButtonItem = backItem
    }
    
    func setupView() {
        self.title = "Chọn Đề"
        tableView.register(ExamTableViewCell.nib(), forCellReuseIdentifier: ExamTableViewCell.indentifier)
        tableView.delegate = self
        tableView.dataSource = self

        subjectImage.sd_setImage(with: URL(string: subject?.image ?? ""), placeholderImage: R.image.placeholder())
        subjectNameLabel.text = subject?.name ?? "N/A"
    }
    
    func bindData() {
        if let mId = subject?.id {
            viewModel.getListExams(page: 1, perPage: 100, mId: 10, isSubjectId: isSubject)
            
            viewModel.listExams.subscribe { [weak self] data in
                if let exams = data.element {
                    if let code = exams.code {
                        switch code {
                            case 200:
                                self?.listExams = exams.data ?? []
                                self?.tableView.reloadData()
                                break
                            default:
                            print("Error: \(exams.message ?? "")")
                                break
                        }
                    }
                }
            }.disposed(by: bag)
        }
    }
    
    func actionTap() {
        tabBarView.selectTab = { tabName in
            self.pushTabbar(tab: tabName)
        }
    }
}

extension ListExamsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listExams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExamTableViewCell.indentifier, for: indexPath) as! ExamTableViewCell
        cell.updateView(exam: listExams[indexPath.row])
        return cell
    }
}
