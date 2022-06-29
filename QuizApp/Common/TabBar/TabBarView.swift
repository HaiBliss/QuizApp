//
//  TabBarView.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/06/2022.
//

import UIKit

@IBDesignable
class TabBarView: UIView {
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var uploadedButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var viewTabBar: UIView!

    var selectTab: (_ tab: TabBar) -> () = {tab in}
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
        
    }
    
    @IBAction func tabBarAction(_ sender: UIButton) {
        
            [self.homeButton,
            self.uploadedButton,
            self.historyButton,
            self.profileButton].forEach {
                $0?.isSelected = false
            }
            sender.isSelected = true
            buttonSelect(button: sender)
    }
    
    func activeButton(tab: TabBar) {
        switch tab {
        case .HOME:
            homeButton.isSelected = true
        case .EXAM_UPLOAD:
            uploadedButton.isSelected = true
        case .HISTORY:
            historyButton.isSelected = true
        case .PROFILE:
            profileButton.isSelected = true
        }
    }
    
    func buttonSelect(button: UIButton) {
        button.isSelected = true
        switch button {
        case homeButton:
            selectTab(TabBar.HOME)
            break
        case uploadedButton:
            selectTab(TabBar.EXAM_UPLOAD)
            break
        case historyButton:
            selectTab(TabBar.HISTORY)
            break
        case profileButton:
            selectTab(TabBar.PROFILE)
            break
        default:
            break
        }
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nidName: "TabBarView") else {
            return
        }
        
        view.frame = self.bounds
        self.addSubview(view)
        viewTabBar.addShadow(offset: CGSize.init(width: 0, height: -4), color: UIColor.black, radius: 4.0, opacity: 0.1)
        [self.homeButton,
        self.uploadedButton,
        self.historyButton,
        self.profileButton].forEach {
            $0?.setImage(nil, for: .normal)
            $0?.setImage(R.image.lightSign(), for: .selected)
            $0?.contentVerticalAlignment = .center
        }
    }
}
