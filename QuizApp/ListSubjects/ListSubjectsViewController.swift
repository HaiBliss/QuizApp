//
//  ListSubjectsViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 19/07/2022.
//

import UIKit
import RxSwift

class ListSubjectsViewController: UIViewController {

    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var tabBarView: TabBarView!
    @IBOutlet weak var subjectCountLabel: UILabel!
    @IBOutlet weak var departmentImage: UIImageView!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = ListSubjectsViewModel()
    private let bag = DisposeBag()
    var department: Departments.Department?
    var departmentId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if let departmentId = departmentId {
            bindData(departmentId: departmentId)
        }
        actionTap()
    }
    
    func setupView() {
        self.title = "Lựa Chọn Môn Học"
        collectionView.register(SubjectsCollectionViewCell.nib(), forCellWithReuseIdentifier: SubjectsCollectionViewCell.indentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        shadowView.setCorner([.bottomLeft,.bottomRight])
    }
    
    func bindData(departmentId: Int) {
        self.animation(isRuning: true)
        viewModel.getSubjectsDepartment(page: 1, perPage: 100, departmentId: departmentId)
        
        viewModel.subjectsDepartment.subscribe { [weak self] data in
            self?.animation(isRuning: false)
            if let subjectsDepartment = data.element {
                if let errorCode = subjectsDepartment.code {
                    switch errorCode {
                    case 200:
                        self?.department = subjectsDepartment.data?[0]
                        self?.collectionView.reloadData()
                        break
                    default:
                        self?.alertView(title: "Load data fail!", message: subjectsDepartment.message ?? "")
                        break
                    }
                }
            }
        }.disposed(by: bag)
        
        viewModel.errorAPI.subscribe{ [weak self] data in
            self?.animation(isRuning: false)
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

extension ListSubjectsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItems = department?.subjects.count else {
            return 0
        }
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubjectsCollectionViewCell.indentifier, for: indexPath) as! SubjectsCollectionViewCell
        
        guard let subjects = department?.subjects else {
            return UICollectionViewCell()
        }
        cell.departmentLabel.text = department?.name
        cell.subjectNameLabel.text = subjects[indexPath.row].name
        cell.subjectImage.sd_setImage(with: URL(string: subjects[indexPath.row].image ?? ""), placeholderImage: R.image.placeholder())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You tapped me")
        guard let subjects = department?.subjects else {
            return
        }
        pushExams(subject: subjects[indexPath.row], isSubject: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 60) / 2
        let height = width * (19/17)
        return CGSize(width: width, height: height)
    }
    
}
