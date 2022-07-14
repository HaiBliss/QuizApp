//
//  HomeViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/06/2022.
//

import UIKit

class HomeViewController: UIViewController {


    @IBOutlet weak var subjectCollectionView: UICollectionView!
    @IBOutlet weak var slideCollectionView: UICollectionView!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var tabBarView: TabBarView!
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

    }
    
    func setupView() {
        slideCollectionView.register(SlidesCollectionViewCell.nib(), forCellWithReuseIdentifier: SlidesCollectionViewCell.indentifier)
        slideCollectionView.delegate = self
        slideCollectionView.dataSource = self
        
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: withItem, height: heightItem)
//        subjectCollectionView.collectionViewLayout = layout
        subjectCollectionView.register(SubjectsCollectionViewCell.nib(), forCellWithReuseIdentifier: SubjectsCollectionViewCell.indentifier)
        subjectCollectionView.delegate = self
        subjectCollectionView.dataSource = self

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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == subjectCollectionView {
//            return CGSize(width: withItem, height: heightItem)
//        }
//        return CGSize(width: 215, height: 89) 
//    }
    
    
}
