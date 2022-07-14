//
//  SlidesCollectionViewCell.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 14/07/2022.
//

import UIKit

class SlidesCollectionViewCell: UICollectionViewCell {

    static let indentifier = "SlidesCollectionViewCell"
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SlidesCollectionViewCell", bundle: nil)
    }

}
