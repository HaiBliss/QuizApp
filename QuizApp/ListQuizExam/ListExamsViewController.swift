//
//  ListQuizViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 18/07/2022.
//

import UIKit
import RxSwift

class ListExamsViewController: UIViewController {

    @IBOutlet weak var randomQuizButton: ShadowButton!
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
        randomQuizButton.setCorner(.allCorners)
        self.title = "Chọn Đề"
        tableView.register(ExamTableViewCell.nib(), forCellReuseIdentifier: ExamTableViewCell.indentifier)
        tableView.delegate = self
        tableView.dataSource = self

        subjectImage.sd_setImage(with: URL(string: subject?.image ?? ""), placeholderImage: R.image.placeholder())
        subjectNameLabel.text = subject?.name ?? "N/A"
    }
    
    func bindData() {
        self.loadingView(isRuning: true)
        if let mId = subject?.id {
            //thay mId vào API khi đủ dữ liệu
            viewModel.getListExams(page: 1, perPage: 100, mId: 10, isSubjectId: isSubject)
            
            viewModel.listExams.subscribe { [weak self] data in
                self?.loadingView(isRuning: false)
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

        viewModel.errorAPI.subscribe{ [weak self] data in
            self?.loadingView(isRuning: false)
            switch data.element {
            case .networkError:
                self?.alertView(title: "Lỗi", message: "Không có Internet" )
            case .commonError(code: _, messages: let messages):
                self?.alertView(title: "Lỗi", message: messages )
            case .invalidJson:
                break
            case .unknow(code: _):
               break
            case .none:
                break
            }
        }.disposed(by: bag)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let examId = listExams[indexPath.row].id, let timer = listExams[indexPath.row].time_count {
            presentQuiz(examId: examId, timer: timer)
        }
        
    }
}
