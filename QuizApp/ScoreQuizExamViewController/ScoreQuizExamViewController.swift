//
//  ScoreQuizExamViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 31/07/2022.
//

import UIKit
import SwiftUI

extension UIColor {
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    static let defaultOuterColor = UIColor.rgb(56, 25, 49)
    static let defaultInnerColor: UIColor = .rgb(234, 46, 111)
    static let defaultPulseFillColor = UIColor.rgb(86, 30, 63)
}

class ScoreQuizExamViewController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var backgroundTopView: ShadowView!
    @IBOutlet weak var backgroundBottomView: UIView!
    @IBOutlet weak var chartProgressView: UIView!
    @IBOutlet weak var backCorrectButton: ShadowButton!
    @IBOutlet weak var restartButton: ShadowButton!
    @IBOutlet weak var backButton: ShadowButton!
    var count: CGFloat = 0
    var progressRing: CircularProgressBar!
    var timer: Timer!
    var sum: Int = 0
    var correct: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sum = 150
        correct = 100
        chartProgressView.setCorner(.allCorners)
        backgroundTopView.setCorner([.bottomLeft, .bottomRight])
        setupView(sum: sum, correct: correct)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
         timer = Timer.scheduledTimer(timeInterval: 0.015, target: self, selector: #selector(incrementCount), userInfo: nil, repeats: true)
         timer.fire()

        chartProgressView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(resetProgressCount)))
    }
    
    func setupView(sum: Int, correct: Int) {
        let xPosition = chartProgressView.frame.width / 2
        let yPosition = chartProgressView.frame.height / 2
        let lineWidth = chartProgressView.frame.height / 15
        let radius = chartProgressView.frame.height * (2/5) - lineWidth
        let position = CGPoint(x: xPosition, y: yPosition)
        progressRing = CircularProgressBar(radius: radius, position: position, innerTrackColor: R.color.f94FB()!, outerTrackColor: R.color.e54C8()!, lineWidth: lineWidth)
        progressRing.countQuiz = CGFloat(sum)
        progressRing.correctQuiz = CGFloat(correct)
        chartProgressView.layer.addSublayer(progressRing)
    }
    
    @IBAction func backActionButton(_ sender: Any) {
        dimissRootVC()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Note only works when time has not been invalidated yet
    @objc func resetProgressCount() {
        count = 0
        timer.fire()
    }
    
    @objc func incrementCount() {
        count += 1
        progressRing.progress = count
        if count >= CGFloat(correct) {
            progressRing.score = (10.0 / Double(sum)) * Double(correct)
            timer.invalidate()
        }
    }

}
