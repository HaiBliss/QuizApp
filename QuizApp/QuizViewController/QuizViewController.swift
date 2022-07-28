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

class QuizViewController: UIViewController {

    @IBOutlet weak var previousQuizButton: UIButton!
    @IBOutlet weak var nextQuizButton: UIButton!
    @IBOutlet weak var listQuizButton: UIButton!
    @IBOutlet weak var indexQuizLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var examView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    private var listQuizs: [Quizs.Quiz] = []
    private let vỉewModel = QuizViewModel()
    let bag = DisposeBag()
    var quizCount = 0
    var currentPage = 0 {
        didSet {
            indexQuizLabel.text = "\(currentPage+1)/\(quizCount)"
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        collectionView.register(QuizCollectionViewCell.nib(), forCellWithReuseIdentifier: QuizCollectionViewCell.indentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
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
}

extension QuizViewController: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listQuizs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizCollectionViewCell.indentifier, for: indexPath) as! QuizCollectionViewCell
        cell.setup(quiz: listQuizs[indexPath.row], quizNumber: indexPath.row + 1)
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
    
    func stringToTimer(timer: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        var date = dateFormatter.date(from: timer)
        //var str_from_date = dateFormatter.string(from: date)
    }
   
}
