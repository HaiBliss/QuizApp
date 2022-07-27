//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 25/07/2022.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var examView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        collectionView.register(QuizCollectionViewCell.nib(), forCellWithReuseIdentifier: QuizCollectionViewCell.indentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension QuizViewController: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizCollectionViewCell.indentifier, for: indexPath) as! QuizCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
}
