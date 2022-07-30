//
//  QuizCollectionViewCell.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 25/07/2022.
//

import UIKit
import SDWebImage
import SwiftUI

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
    @IBOutlet weak var answerAView: UIView!
    @IBOutlet weak var answerBView: UIView!
    @IBOutlet weak var answerCView: UIView!
    @IBOutlet weak var answerDView: UIView!
    @IBOutlet weak var buttonImageA: UIButton!
    @IBOutlet weak var buttonImageB: UIButton!
    @IBOutlet weak var buttonImageC: UIButton!
    @IBOutlet weak var buttonImageD: UIButton!
    @IBOutlet weak var imageAView: UIView!
    @IBOutlet weak var imageBView: UIView!
    @IBOutlet weak var imageCView: UIView!
    @IBOutlet weak var imageDView: UIView!
    
    var answersDict = [0:"A. ", 1:"B. ", 2:"C. ", 3: "D. "]
    var quizData: Quizs.Quiz?

    static let indentifier = "QuizCollectionViewCell"
    var showImage: (_ url: String) -> () = { url in }
    var selectAnswer: (_ quizNumber: Int) -> () = { quizNumber in }

    override func awakeFromNib() {
        super.awakeFromNib()
        let gestureA = UITapGestureRecognizer(target: self, action:  #selector(self.selectAAnswer))
        let gestureB = UITapGestureRecognizer(target: self, action:  #selector(self.selectBAnswer))
        let gestureC = UITapGestureRecognizer(target: self, action:  #selector(self.selectCAnswer))
        let gestureD = UITapGestureRecognizer(target: self, action:  #selector(self.selectDAnswer))
        answerAView.addGestureRecognizer(gestureA)
        answerBView.addGestureRecognizer(gestureB)
        answerCView.addGestureRecognizer(gestureC)
        answerDView.addGestureRecognizer(gestureD)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "QuizCollectionViewCell", bundle: nil)
    }
    
    func setup(quiz: Quizs.Quiz, quizNumber: Int) {
        quizData = quiz
        questionLabel.text = "Câu \(quizNumber). \(quiz.name ?? "")"
        let answersLabel = [answerALabel, answerBLabel, answerCLabel, answerDLabel]
        let answersImage = [answerAImage, answerBImage, answerCImage, answerDImage]
        let answersView = [answerAView, answerBView, answerCView, answerDView]
       
        
        if let image = quiz.image, image != "" {
            questionImage.isHidden = false
            questionImage.sd_setImage(with: URL(string: image), placeholderImage: R.image.placeholder())
        } else {
            questionImage.isHidden = true
        }
       
        if let answers = quiz.answers {
            for i in 0...answers.count - 1{
                answersView[i]?.borderColor = R.color.f94FB()!
                if answers[i].isSelect ?? false {
                    answersView[i]?.backgroundColor = R.color.f94FB()
                    answersLabel[i]?.textColor = .white
                } else {
                    answersLabel[i]?.textColor = .black
                }
                answersLabel[i]?.text = "\(answersDict[i] ?? "")\(answers[i].value ?? "")"
                if let image = answers[i].image , image != "" {
                    answersImage[i]?.isHidden = false
                    answersImage[i]?.sd_setImage(with: URL(string: image), placeholderImage: R.image.placeholder())
                } else {
                    answersImage[i]?.isHidden = true
                }
            }
        }
    }
    
    @IBAction func buttonImagection(_ sender: UIButton) {
        print("Click Image")
        showImage(quizData?.answers?[sender.tag].image ?? "")
    }
    
    @objc func selectAAnswer(sender: UITapGestureRecognizer) {
        selectQuiz(quizTag: sender.view?.tag ?? 0)
    }
    @objc func selectBAnswer(sender: UITapGestureRecognizer) {
        selectQuiz(quizTag: sender.view?.tag ?? 0)
    }
    @objc func selectCAnswer(sender: UITapGestureRecognizer) {
        selectQuiz(quizTag: sender.view?.tag ?? 0)
    }
    @objc func selectDAnswer(sender: UITapGestureRecognizer) {
        selectQuiz(quizTag: sender.view?.tag ?? 0)
    }
    
    func selectQuiz(quizTag: Int) {
        let answersView = [answerAView, answerBView, answerCView, answerDView]
        let answersLabel = [answerALabel, answerBLabel, answerCLabel, answerDLabel]
        for i in 0...3 {
            answersView[i]?.backgroundColor = .white
            answersLabel[i]?.textColor = .black
        }
        answersView[quizTag]?.backgroundColor = R.color.f94FB()
        answersLabel[quizTag]?.textColor = .white
        selectAnswer(quizTag)
    }

}
