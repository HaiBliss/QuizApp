//
//  ShadowView.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 20/07/2022.
//

import UIKit

class ShadowView: UIView {
    enum ShadowType: Int {
        case background
        case button
    }

    @IBInspectable var shadowType: Int = 0 {
        didSet {
            setupShadow()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShadow()
    }

    private func setupShadow() {
        switch shadowType {
        case ShadowType.background.rawValue:
            defaultShadowForBackground()
        default:
            defaultShadowForButton()
        }
    }
}

class ShadowButton: UIButton {
    @IBInspectable var showShadow: Bool = true {
        didSet {
            setupShadow()
        }
    }

    @IBInspectable var rounded: Bool = true {
        didSet {
            setupRounded()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
        setupRounded()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShadow()
        setupRounded()
    }

    private func setupShadow() {
        if showShadow {
            defaultShadowForButton()
        } else {
            self.shadowColor = UIColor.clear
        }
    }

    private func setupRounded() {
        self.roundedRadius = rounded ? 8 : 0
    }
}

