//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 25/07/2022.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa
import Combine

class QuizViewController: UIViewController {

    @IBOutlet weak var previousQuizButton: UIButton!
    @IBOutlet weak var nextQuizButton: UIButton!
    @IBOutlet weak var listQuizButton: UIButton!
    @IBOutlet weak var indexQuizLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var topView: ShadowView!
    @IBOutlet weak var bottomView: ShadowView!
    @IBOutlet weak var examView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    private var listQuizs: [Quizs.Quiz] = []
    private let vỉewModel = QuizViewModel()
    private let bag = DisposeBag()
    var quizCount = 0
    private var timeDismiss: Int = 0
    private var currentPage = 0 {
        didSet {
            indexQuizLabel.text = "\(currentPage+1)/\(quizCount)"
        }
    }
    private var startTime: String = ""
    private let dateFormatter = DateFormatter()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var time: String = "00:00"
    private var minutes: Float = 0.0 {
        didSet {
            self.time = "\(Int(minutes)):00"
        }
    }
//    private var initialTime = 0
    private var endDate = Date()
    private var store = [AnyCancellable]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        setupView()
    }
    
    func setupView() {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        collectionView.register(QuizCollectionViewCell.nib(), forCellWithReuseIdentifier: QuizCollectionViewCell.indentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        topView.setCorner([.bottomLeft, .bottomRight])
        bottomView.setCorner([.topLeft, .topRight])
    }
    
    func setupTime() {
        timer.receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.updateCountdown()
                self?.timerLabel.text = self?.time
            }.store(in: &store)
    }
    
    func bindData(examId: Int, timer: Int) {
        
        self.loadingView(isRuning: true)
        vỉewModel.getQuizs(page: 1, perPage: 100, examId: examId)
        vỉewModel.quizs.subscribe { [weak self] data in
            self?.loadingView(isRuning: false)
            if let quizs = data.element {
                if let errorCode = quizs.code {
                    switch errorCode {
                    case 200:
                        self?.timerLabel.text = "\(timer):00"
                        self?.quizCount = quizs.data?.count ?? 0
                        self?.indexQuizLabel.text = "\((self?.currentPage ?? 0) + 1)/\(self?.quizCount ?? 0)"
                        self?.listQuizs = quizs.data ?? []
                        self?.collectionView.reloadData()
                        self?.setupTime()
                        self?.start(minutes: Float(timer))
                        break
                    default:
                        self?.alertView(title: "Lỗi", message: quizs.message ?? "")
                        break
                        
                    }
                }
            }
        }.disposed(by: bag)
        
        vỉewModel.errorAPI.subscribe{ [weak self] data in
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
    @IBAction func submitExamAction(_ sender: Any) {
        submitExam(isConfirm: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if currentPage == listQuizs.count - 1 {
           
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    @IBAction func previousAction(_ sender: Any) {
        if currentPage < 1 {
           
        } else {
            currentPage -= 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func lisQuizAction(_ sender: Any) {
        if timeDismiss > 1 {
            presentQuizAnswer(listQuizs: listQuizs, timeDismiss: timeDismiss)?.selectQuiz = {[weak self] quizIndex in
                if (quizIndex > -1 && quizIndex <= self?.listQuizs.count ?? 0) {
                    self?.currentPage = quizIndex
                    let indexPath = IndexPath(item: quizIndex, section: 0)
                    self?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                }
            }
        }
    }
    
    func submitExam(isConfirm: Bool) {
        var listAnswer: [QuizRequest.Answer] = []
        for i in listQuizs {
            var answerSelect = -1
            if let answers = i.answers, answers.count > 0 {
                for (index, element) in answers.enumerated() {
                    if element.is_select == true {
                        answerSelect = index
                        break
                    }
                }
                if let id = i.id {
                    let answer = QuizRequest.Answer(quiz_id: id, answer: answerSelect)
                    listAnswer.append(answer)
                }
            }
        }
        
        if isConfirm {
            self.confirmView(title: "Bạn có chắc chắn muốn nộp bài?", message: "Dĩ nhiên rồi :)))") { [weak self] in
                
                let quizRequest = QuizRequest.init(exam_id: self?.listQuizs[0].exams_id ?? -1, start_time: self?.startTime ?? "", completion_time: self?.dateFormatter.string(from: Date()) ?? "", answer: listAnswer)
                self?.timer.upstream.connect().cancel()
                self?.presentScoreQuiz(quizRequest: quizRequest)
            }
        } else {
            let quizRequest = QuizRequest.init(exam_id: self.listQuizs[0].exams_id ?? -1, start_time: startTime, completion_time: self.dateFormatter.string(from: Date()), answer: listAnswer)
            timer.upstream.connect().cancel()
            presentScoreQuiz(quizRequest: quizRequest)
        }
    }
}

extension QuizViewController: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listQuizs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizCollectionViewCell.indentifier, for: indexPath) as! QuizCollectionViewCell
        let index = indexPath.row
        cell.setup(quiz: listQuizs[index], quizNumber: index + 1)
        cell.showImage = { url in
            self.presentImageVC(url: url)
        }
        
        cell.selectAnswer = { [weak self] quizNumber in
            if let answers = self?.listQuizs[index].answers {
                for i in 0..<answers.count {
                    self?.listQuizs[index].answers?[i].is_select = false
                }
                self?.listQuizs[index].answers?[quizNumber].is_select = true
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    
}

extension QuizViewController {
    
    func start(minutes: Float) {
        self.startTime = self.dateFormatter.string(from: Date())
        let initialTime = Int(minutes)
        self.endDate = Date()
        self.endDate = Calendar.current.date(byAdding: .second, value: initialTime * 60 + 1, to: endDate)!
    }
    
//    func reset() {
//        self.minutes = Float(initialTime)
//        self.time = "\(Int(minutes)):00"
//    }
    
    func updateCountdown() {
        // Nhận ngày hiện tại và thực hiện tính toán chênh lệch thời gian
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        //Check that the cowndown is not <=0
        if diff <= 0 {
            self.time = "0:00"
            submitExam(isConfirm: false)
            return
        }
        
        //Turn the time difference calculation into sensible data and format it
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        self.timeDismiss = minutes * 60 + seconds
        self.minutes = Float(minutes)
        self.time = String(format: "%d:%02d", minutes, seconds)
    }
   
}
