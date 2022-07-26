//
//  QuizCollectionViewCell.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 25/07/2022.
//

import UIKit

class QuizCollectionViewCell: UICollectionViewCell {

    static let indentifier = "QuizCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "QuizCollectionViewCell", bundle: nil)
    }

}
