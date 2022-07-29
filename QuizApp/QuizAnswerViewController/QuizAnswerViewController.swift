//
//  QuizAnswerViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 29/07/2022.
//

import UIKit

class QuizAnswerViewController: UIViewController {

    @IBOutlet weak var tooltipView: UIView!
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listQuizs: [Quizs.Quiz] = []
    var selectQuiz: (_ quizIndex: Int) -> () = {quizIndex in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        shadowView.setCorner(.allCorners)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(closeViewAction))
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: false)
    }
    
    @objc func closeViewAction(sender: Bool) {
        dismiss(animated: false)
    }
    

}

extension QuizAnswerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listQuizs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAnswerCollectionViewCell.indentifier, for: indexPath) as! QuizAnswerCollectionViewCell

        let index = indexPath.row
        cell.setupView(quiz: listQuizs[index], quizNumber: index + 1)
        cell.quizAnswerTap = {
            self.selectQuiz(index)
            self.dismiss(animated: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension QuizAnswerViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldReceive touch: UITouch) -> Bool {
        switch touch.view {
          case shadowView, collectionView, tooltipView:
              return false
          default:
              return true
        }
    }
}
