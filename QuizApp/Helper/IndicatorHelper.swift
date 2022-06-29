//
//  IndicatorHelper.swift
//  QuizApp
//
//  Created by it on 29/06/2022.
//

import UIKit

final class IndicatorHelper {

    static let shared = IndicatorHelper()
    let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    let indicatorView = UIView(frame: AppUtil.window?.bounds ?? CGRect.zero)
    let screenBounds = UIScreen.main.bounds

    init() {
        IndicatorHelper.runMainThread { [weak self] in
            self?.indicatorView.backgroundColor = UIColor(
                red: 0.0,
                green: 0.0,
                blue: 0.0,
                alpha: 0.3
            )
            self?.loadingIndicator.color = UIColor(named: "trangmo")
            self?.loadingIndicator.center = CGPoint(x: (self?.screenBounds.size.width)! * 0.5, y: (self?.screenBounds.size.height)! * 0.5)
            self?.loadingIndicator.startAnimating()

            self?.indicatorView.addSubview(self!.loadingIndicator)
            self?.indicatorView.tag = 9999
            AppUtil.window?.addSubview(self!.indicatorView)
        }
    }

    func isLoading() -> Bool {
        return indicatorView.isHidden == false
    }

    func startIndicator() {
        IndicatorHelper.runMainThread {
            if let view = AppUtil.window?.viewWithTag(9999) {
                view.isHidden = false
                AppUtil.window?.bringSubviewToFront(view)
            }
        }
    }

    func dismissIndicator() {
        IndicatorHelper.runMainThread {
            if let view = AppUtil.window?.viewWithTag(9999) {
                view.isHidden = true
            }
        }
    }

    private class func runMainThread(_ handler: @escaping () -> Void) {
        if Thread.isMainThread {
            handler()
        } else {
            DispatchQueue.main.sync {
                handler()
            }
        }
    }
}

