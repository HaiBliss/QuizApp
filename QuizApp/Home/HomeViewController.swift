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


    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchBoxTextField: UITextField!
    @IBOutlet weak var subjectCollectionView: UICollectionView!
    @IBOutlet weak var slideCollectionView: UICollectionView!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var tabBarView: TabBarView!
    
    private let viewModel = HomeViewModel()
    private let bag = DisposeBag()
    let withItem = UIScreen.main.bounds.width/2 - 40
    let heightItem = (UIScreen.main.bounds.width/2 - 40) / (175/190)
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
    

    
    func bindData() {
        
        viewModel.getDepartmentHome(page: 1, perPage: 1, name: nil)
        viewModel.departmentsInfo.subscribe { [weak self] data in
            if let departmentsInfo = data.element {
                if let errorCode = departmentsInfo.code {
                    switch errorCode {
                    case 200:
                        print("Call thành công!")
                        self?.subjectCollectionView.reloadData()
                        break
                    default:
                        self?.alertView(title: "Load data fail!", message: departmentsInfo.message ?? "")
                        break
                    }
                }
            }
        }
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
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == slideCollectionView {
            return 4
        }
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You tapped me")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == subjectCollectionView {
            return 3
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == subjectCollectionView {
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                    withReuseIdentifier: SubjectCollectionReusableView.indentifier,
                                                                                    for: indexPath)as! SubjectCollectionReusableView
            sectionHeaderView.departmentNameLabel.text = "Khoa CNTT"
            return sectionHeaderView
        }
        return UICollectionReusableView()
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == subjectCollectionView {
            return CGSize(width: view.frame.size.width, height: 50)
        }
        return CGSize()
    }
    
    
}
