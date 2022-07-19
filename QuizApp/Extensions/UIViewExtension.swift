//
//  UIViewExtension.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/06/2022.
//

import Foundation
import UIKit

extension UIView {
    func loadViewFromNib(nidName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nidName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    /// The radius of the view's rounded corners
    @IBInspectable public var roundedRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    /// The width of the border applied to the view
    @IBInspectable public var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// The color of the border applied to the views
    @IBInspectable public var borderColor: UIColor {
        get {
            UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

    /// The color of the shadow applied to the view
    @IBInspectable public var shadowColor: UIColor {
        get {
            UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }

    /// The offet of the shadow in the form (x, y)
    @IBInspectable public var shadowOffset: CGSize {
        get {
            layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    /// The blur of the shadown
    @IBInspectable public var shadowRadius: CGFloat {
        get {
            layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    /// The opacity of the shadow applied to the view
    @IBInspectable public var shadowOpacity: Float {
        get {
            layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            layer.masksToBounds = false
        }
    }
}

extension UIView {
    func calculatePreferredHeight(preferredWidth: CGFloat? = nil) -> CGFloat {
        let width = preferredWidth ?? frame.width
        let widthConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==\(width)@999)]", options: [], metrics: nil, views: ["view": self])
        addConstraints(widthConstraint)
        let height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        removeConstraints(widthConstraint)
        return height
    }

    func defaultShadowForBackground() {
        self.shadowColor = .black
        self.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowOpacity = 0.08
        self.shadowRadius = 8
    }

    func defaultShadowForButton() {
        self.shadowColor = .black
        self.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowOpacity = 0.12
        self.shadowRadius = 6
    }

    func setCornerWithShadowBackground(_ corner: UIRectCorner, radius: CGFloat = 8) {
        self.defaultShadowForBackground()
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = CACornerMask(rawValue: corner.rawValue)
    }

    func setCorner(_ corner: UIRectCorner, radius: CGFloat = 8) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = CACornerMask(rawValue: corner.rawValue)
    }
}

