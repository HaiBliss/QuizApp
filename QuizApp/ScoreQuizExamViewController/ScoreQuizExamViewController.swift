//
//  ScoreQuizExamViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 31/07/2022.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

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
    private var viewModel = ScoreQuizExamViewModel()
    private let bag = DisposeBag()
    var quizRequest: QuizRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        bindData()
    }
    
    func setupView() {
        backCorrectButton.isEnabled = false
        restartButton.isEnabled = false
//        backButton.isEnabled = false
        chartProgressView.setCorner(.allCorners)
        backgroundTopView.setCorner([.bottomLeft, .bottomRight])
    }
    
    func setupChartProgress(sum: Int, correct: Int) {
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
    
    func startCicle() {
         timer = Timer.scheduledTimer(timeInterval: 0.015, target: self, selector: #selector(incrementCount), userInfo: nil, repeats: true)
         timer.fire()

//        chartProgressView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(resetProgressCount)))
    }
    
    func bindData() {
        guard let quizRequest = quizRequest else {
            self.errorView(title: "Lỗi", message: "Không có Data!")
            return
        }
        self.loadingView(isRuning: true)
        viewModel.postQuizAnswer(quizRequest: quizRequest)
        viewModel.quizs.subscribe { [weak self] data in
            self?.loadingView(isRuning: false)
            if let quizs = data.element {
                if let errorCode = quizs.code {
                    switch errorCode {
                    case 200:
                        self?.sum = quizs.data?.count ?? 0
                        self?.correct = 100
                        self?.setupChartProgress(sum: self?.sum ?? 0, correct: self?.correct ?? 0)
                        self?.startCicle()
                        break
                    default:
                        self?.errorView(title: "Lỗi", message: quizs.message ?? "")
                        break
                    }
                }
            }
        }.disposed(by: bag)
        
        viewModel.errorAPI.subscribe{ [weak self] data in
            self?.loadingView(isRuning: false)
            switch data.element {
            case .networkError:
                self?.alertView(title: "Lỗi", message: "Không có Internet" )
            case .commonError(code: _, messages: let messages):
                self?.alertView(title: "Lỗi", message: messages )
            case .invalidJson:
                break
            case .unknow(code: _):
               break
            case .none:
                break
            }
        }.disposed(by: bag)
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
            backCorrectButton.isEnabled = true
            restartButton.isEnabled = true
            backButton.isEnabled = true
        }
    }

}
