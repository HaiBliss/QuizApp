//
//  SubjectsCollectionViewCell.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 14/07/2022.
//

import UIKit

class SubjectsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemView: UIView!
    static let indentifier = "SubjectsCollectionViewCell"
    @IBOutlet weak var lastScoreLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var subjectImage: UIImageView!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var subjectNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        itemView.layer.cornerRadius = 10
        itemView.layer.borderColor = R.color.f94FB()?.cgColor
        itemView.layer.borderWidth = 1
        itemView.layer.masksToBounds = true
    }

    static func nib() -> UINib {
        return UINib(nibName: "SubjectsCollectionViewCell", bundle: nil)
    }
}
