//
//  TabBarView.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 28/06/2022.
//

import UIKit

@IBDesignable
class TabBarView: UIView {
    @IBOutlet weak var viewTabBar: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
        
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nidName: "TabBarView") else {
            return
        }
        
        view.frame = self.bounds
        self.addSubview(view)
        viewTabBar.addShadow(offset: CGSize.init(width: 0, height: -4), color: UIColor.black, radius: 4.0, opacity: 0.1)
    }
}
