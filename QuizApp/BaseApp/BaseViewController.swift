//
//  BaseViewController.swift
//  QuizApp
//
//  Created by it on 29/06/2022.
//

import UIKit
import RxCocoa
import RxSwift
import NVActivityIndicatorView

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showAnimation() {
        IndicatorHelper.shared.startIndicator()
    }

    func dismissAnimation() {
        IndicatorHelper.shared.dismissIndicator()
    }
    
}
