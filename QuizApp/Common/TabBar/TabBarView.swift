//
//  TabBarView.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/06/2022.
//

import UIKit

@IBDesignable
class TabBarView: UIView {
    
    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0
    
    @IBOutlet weak var homeTabView: UIView!
    @IBOutlet weak var uploadedTabView: UIView!
    @IBOutlet weak var historyTabView: UIView!
    @IBOutlet weak var profileTabView: UIView!
    @IBOutlet weak var viewTabBar: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(menuItems: Int, frame: CGRect) {
        self.init(frame: frame)
        
        guard let view = self.loadViewFromNib(nidName: R.nib.tabBarView.name) else {
            return
        }
        view.frame = self.bounds
        viewTabBar.addShadow(offset: CGSize.init(width: 0, height: -10), color: UIColor.black, radius: 4.0, opacity: 1)
    
        [homeTabView, uploadedTabView, historyTabView, profileTabView].forEach {
            $0.addGestureRecognizer(UITapGestureRecognizer(
                target: self,
                action: #selector(handleTap(_:)))
            )
        }
        
        addSubview(view)
        setNeedsLayout()
        layoutIfNeeded()
        activateTab(tab: 0)
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        switchTab(from: activeItem, to: sender.view!.tag)
    }
    
    func switchTab(from: Int, to: Int) {
        deactivateTab(tab: from)
        activateTab(tab: to)
    }
    
    func activateTab(tab: Int) {
        let tabBarVc = [homeTabView, uploadedTabView, historyTabView, profileTabView]
        guard let tabToActivate = tabBarVc[tab] else {return}
        let borderWidth = tabToActivate.frame.width - 20
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor(named: R.color.f94FB.name)?.cgColor
        borderLayer.name = "Active Border"
        borderLayer.frame = CGRect(x: 10, y: 0, width: borderWidth, height: 2)

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8,
                           delay: 0.0,
                           options: [.curveEaseIn, .allowUserInteraction]) {
                tabToActivate.layer.addSublayer(borderLayer)
                tabToActivate.setNeedsLayout()
                tabToActivate.layoutIfNeeded()
            } completion: { _ in
                self.itemTapped?(tab)
                self.activeItem = tab
            }
        }
    }
    
    func deactivateTab(tab: Int) {
        let tabBarVc = [homeTabView, uploadedTabView, historyTabView, profileTabView]
        guard let inactiveTab = tabBarVc[tab] else {return}
        let layerToRemove = inactiveTab.layer.sublayers?.filter({ $0.name == "Active Border" })

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseIn, .allowUserInteraction]) {
                layerToRemove?.forEach({ $0.removeFromSuperlayer() })
                inactiveTab.setNeedsLayout()
                inactiveTab.layoutIfNeeded()
            } completion: { _ in

            }
        }
    }
}
