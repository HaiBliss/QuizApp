//
//  HomeViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/06/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet weak var slideView: ShadowView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchBoxTextField: UITextField!
    @IBOutlet weak var subjectCollectionView: UICollectionView!
    @IBOutlet weak var slideCollectionView: UICollectionView!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var tabBarView: TabBarView!
    var departments: [Departments.Department] = []
    
    private let viewModel = HomeViewModel()
    private let bag = DisposeBag()
//    let withItem = UIScreen.main.bounds.width/2 - 40
//    let heightItem = (UIScreen.main.bounds.width/2 - 40) / (175/190)
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        tabBarView.activeButton(tab: .HOME)
        actionTap()
        setupView()
        bindData()

    }
    
    func setupView() {
        slideView.setCorner([.bottomRight, .bottomLeft])
        slideCollectionView.register(SlidesCollectionViewCell.nib(),
                                     forCellWithReuseIdentifier: SlidesCollectionViewCell.indentifier)
        slideCollectionView.delegate = self
        slideCollectionView.dataSource = self
        
        subjectCollectionView.register(SubjectsCollectionViewCell.nib(),
                                       forCellWithReuseIdentifier: SubjectsCollectionViewCell.indentifier)
        
        subjectCollectionView.register(SubjectCollectionReusableView.nib(),
                                       forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: SubjectCollectionReusableView.indentifier)
        subjectCollectionView.delegate = self
        subjectCollectionView.dataSource = self
        
        filterButton.layer.cornerRadius = filterButton.frame.width/2
        filterButton.layer.masksToBounds = true
        filterButton.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 5.0, opacity: 0.2)

    }
    
    func actionTap() {
        tabBarView.selectTab = { tabName in
            self.pushTabbar(tab: tabName)
        }
    }
    

    
    func bindData() {
        
        viewModel.getDepartmentHome(page: 1, perPage: 10)

        viewModel.departments.subscribe { [weak self] data in
            if let departmentsData = data.element {
                if let errorCode = departmentsData.code {
                    switch errorCode {
                    case 200:
                        print("Call thành công!")
                        self?.departments = departmentsData.data ?? []
                        self?.subjectCollectionView.reloadData()
                        break
                    default:
                        self?.alertView(title: "Load data fail!", message: departmentsData.message ?? "")
                        break
                    }
                }
            }
        }.disposed(by: bag)
    }
    
    
    func alertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == slideCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlidesCollectionViewCell.indentifier, for: indexPath) as! SlidesCollectionViewCell
            cell.configure(with: R.image.slide()!)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubjectsCollectionViewCell.indentifier, for: indexPath) as! SubjectsCollectionViewCell
        let subjects = departments[indexPath.section].subjects
        cell.departmentLabel.text = departments[indexPath.section].name
        cell.subjectNameLabel.text = subjects[indexPath.row].name
        cell.subjectImage.sd_setImage(with: URL(string: subjects[indexPath.row].image ?? ""), placeholderImage: R.image.placeholder())
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == slideCollectionView {
            return 4
        }
        return departments[section].subjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == slideCollectionView {
            print("Nhấn vào slider")
        } else {
            if let subjectId = departments[indexPath.section].subjects[indexPath.row].id {
                pushExams(mId: subjectId, isSubject: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == subjectCollectionView {
            return departments.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == subjectCollectionView {
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                    withReuseIdentifier: SubjectCollectionReusableView.indentifier,
                                                                                    for: indexPath)as! SubjectCollectionReusableView
           
            let department = departments[indexPath.section]
            sectionHeaderView.departmentNameLabel.text = department.name
            sectionHeaderView.seeAllButton.tag = department.id ?? 0
            sectionHeaderView.seeAllButton.addTarget(self, action: #selector(self.viewSeeAllSubject(_:)), for: UIControl.Event.touchUpInside)
            return sectionHeaderView
        }
        return UICollectionReusableView()
    }
    
    @objc func viewSeeAllSubject(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ListSubjectsViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ListSubjectsViewController") as! ListSubjectsViewController
        vc.departmentId = sender.tag
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = R.color.f94FB()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == subjectCollectionView {
            return CGSize(width: view.frame.size.width, height: 50)
        }
        return CGSize()
    }
    
    
}
