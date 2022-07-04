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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(notification:)),
                                               name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(notification:)),
                                               name: UIWindow.keyboardWillHideNotification, object: nil)
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
    
    @objc private func keyboardShow(notification: NSNotification) {
        guard let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
                  return
              }
        UIView.animate(withDuration: duration, delay: 0.0, options: UIView.AnimationOptions(rawValue: curve), animations: { [weak self] in
            guard let self = self else {
                return
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    @objc private func keyboardHide(notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
                  return
              }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIView.AnimationOptions(rawValue: curve), animations: { [weak self] in
            guard let self = self else {
                return
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
