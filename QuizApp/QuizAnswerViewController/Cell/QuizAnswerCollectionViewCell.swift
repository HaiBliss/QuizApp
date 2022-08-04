//
//  QuizAnswerCollectionViewCell.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 29/07/2022.
//

import UIKit

class QuizAnswerCollectionViewCell: UICollectionViewCell {
    static let indentifier = "QuizAnswerCollectionViewCell"
    
    @IBOutlet weak var quizAnswerButton: UIButton!
    @IBOutlet weak var quizAnswerView: ShadowView!
    var quizAnswerTap: () -> () = {}

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "QuizAnswerCollectionViewCell", bundle: nil)
    }
    
    func setupView(quiz: Quizs.Quiz, quizNumber: Int) {
        quizAnswerButton.setTitle("\(quizNumber)", for: .normal)
        if let answers = quiz.answers {
            for element in answers {
                if element.is_select == true {
                    quizAnswerView.borderColor = R.color.f94FB()!
                    quizAnswerButton.setTitleColor(R.color.f94FB(), for: .normal)
                    break
                } else {
                    quizAnswerView.borderColor = .gray
                    quizAnswerView.backgroundColor = .white
                    quizAnswerButton.setTitleColor(.black, for: .normal)
                }
            }
        }
    }
    
    @IBAction func quizAnswerAction(_ sender: Any) {
        quizAnswerTap()
    }
    
}
