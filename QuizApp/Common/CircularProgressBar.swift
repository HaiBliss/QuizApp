//
//  CircularProgressBar.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 31/07/2022.
//

import Foundation
import UIKit

public class CircularProgressBar: CALayer {
    
    private var circularPath: UIBezierPath!
    private var innerTrackShapeLayer: CAShapeLayer!
    private var outerTrackShapeLayer: CAShapeLayer!
    private let rotateTransformation = CATransform3DMakeRotation(-.pi / 2, 0, 0, 1)
    private var completedLabel: UILabel!
    public var progressLabel: UILabel!
    public var isUsingAnimation: Bool!
    public var countQuiz: CGFloat = 0.0
    public var correctQuiz: CGFloat = 0.0
    public var score: CGFloat = 0.0 {
        didSet {
            completedLabel.text = "\(String(format: "%.2f", score)) điểm"
        }
    }
//    public var progress: CGFloat = 0 {
//        didSet {
//            progressLabel.text = "\(progress)"
//            innerTrackShapeLayer.strokeEnd = correctQuiz/countQuiz
//            if progress > correctQuiz {
//                progressLabel.text = "\(correctQuiz)/\(countQuiz)"
//            }
//
//    }
    public var progress: CGFloat = 0 {
        didSet {
            progressLabel.text = "\(Int(progress))/\(Int(countQuiz))"
            innerTrackShapeLayer.strokeEnd = progress / countQuiz
//            if progress > 100 {
//                progressLabel.text = "100%"
//            }
        }
    }
    
    public init(radius: CGFloat, position: CGPoint, innerTrackColor: UIColor, outerTrackColor: UIColor, lineWidth: CGFloat) {
        super.init()
        
        circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        outerTrackShapeLayer = CAShapeLayer()
        outerTrackShapeLayer.path = circularPath.cgPath
        outerTrackShapeLayer.position = position
        outerTrackShapeLayer.strokeColor = outerTrackColor.cgColor
        outerTrackShapeLayer.fillColor = UIColor.clear.cgColor
        outerTrackShapeLayer.lineWidth = lineWidth
        outerTrackShapeLayer.strokeEnd = 1
        outerTrackShapeLayer.lineCap = CAShapeLayerLineCap.round
        outerTrackShapeLayer.transform = rotateTransformation
        addSublayer(outerTrackShapeLayer)
        
        innerTrackShapeLayer = CAShapeLayer()
        innerTrackShapeLayer.strokeColor = innerTrackColor.cgColor
        innerTrackShapeLayer.position = position
        innerTrackShapeLayer.strokeEnd = progress
        innerTrackShapeLayer.lineWidth = lineWidth
        innerTrackShapeLayer.lineCap = CAShapeLayerLineCap.round
        innerTrackShapeLayer.fillColor = UIColor.clear.cgColor
        innerTrackShapeLayer.path = circularPath.cgPath
        innerTrackShapeLayer.transform = rotateTransformation
        addSublayer(innerTrackShapeLayer)
        
        progressLabel = UILabel()
        let size = CGSize(width: radius, height: radius)
        let origin = CGPoint(x: position.x, y: position.y)
        progressLabel.frame = CGRect(origin: origin, size: size)
        progressLabel.center = position
        progressLabel.center.y = position.y - 10
        progressLabel.font = UIFont.boldSystemFont(ofSize: radius * 0.2)
        progressLabel.text = "0"
        progressLabel.textColor = .gray
        progressLabel.textAlignment = .center
        insertSublayer(progressLabel.layer, at: 0)
        
        completedLabel = UILabel()
        let completedLabelOrigin = CGPoint(x: position.x , y: position.y)
        completedLabel.frame = CGRect(origin: completedLabelOrigin, size: CGSize.init(width: radius, height: radius * 0.6))
        completedLabel.font = UIFont.systemFont(ofSize: radius * 0.2, weight: UIFont.Weight.light)
        completedLabel.textAlignment = .center
        completedLabel.center = position
        completedLabel.center.y = position.y + 20
        completedLabel.textColor = R.color.f94FB()!
        completedLabel.text = "quizs"
        insertSublayer(completedLabel.layer, at: 0)
        
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
