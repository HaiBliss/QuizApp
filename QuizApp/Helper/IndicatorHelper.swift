//
//  IndicatorHelper.swift
//  QuizApp
//
//  Created by it on 29/06/2022.
//

import UIKit
import NVActivityIndicatorView

final class IndicatorHelper {

    static let shared = IndicatorHelper()
    let screenBounds = UIScreen.main.bounds
    let loadingIndicator = NVActivityIndicatorView(frame: .zero, type: .ballClipRotatePulse, color: UIColor(named: "8F94FB"), padding: 0)
    let indicatorView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    init() {
        IndicatorHelper.runMainThread { [weak self] in
            self?.indicatorView.backgroundColor = UIColor(named: "trangmo")
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

