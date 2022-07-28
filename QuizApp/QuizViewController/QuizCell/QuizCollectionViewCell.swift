//
//  QuizCollectionViewCell.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 25/07/2022.
//

import UIKit
import SDWebImage

class QuizCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    
    @IBOutlet weak var answerALabel: UILabel!
    @IBOutlet weak var answerBLabel: UILabel!
    @IBOutlet weak var answerCLabel: UILabel!
    @IBOutlet weak var answerDLabel: UILabel!
    @IBOutlet weak var answerAImage: UIImageView!
    @IBOutlet weak var answerBImage: UIImageView!
    @IBOutlet weak var answerCImage: UIImageView!
    @IBOutlet weak var answerDImage: UIImageView!

    static let indentifier = "QuizCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "QuizCollectionViewCell", bundle: nil)
    }
    
    func setup(quiz: Quizs.Quiz, quizNumber: Int) {
        questionLabel.text = "Câu \(quizNumber). \(quiz.name ?? "")"
        let answersLabel = [answerALabel, answerBLabel, answerCLabel, answerDLabel]
        
        let answersImage = [answerAImage, answerBImage, answerCImage, answerDImage]
        
        if let image = quiz.image, image != "" {
            questionImage.isHidden = false
            questionImage.sd_setImage(with: URL(string: image), placeholderImage: R.image.placeholder())
        } else {
            questionImage.isHidden = true
        }
        
        if let answers = quiz.answers {
            for i in 0...answers.count - 1{
                answersLabel[i]?.text = answers[i].value
                if let image = answers[i].image , image != "" {
                    answersImage[i]?.isHidden = false
                    answersImage[i]?.sd_setImage(with: URL(string: image), placeholderImage: R.image.placeholder())
                } else {
                    answersImage[i]?.isHidden = true
                }
            }
        }
    }

}
