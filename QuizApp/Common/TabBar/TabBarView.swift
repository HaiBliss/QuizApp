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
    
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var examUploadImage: UIImageView!
    @IBOutlet weak var examUploadLabel: UILabel!
    @IBOutlet weak var historyImage: UIImageView!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    

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
        
        switch sender {
            case homeButton:
                setViewSelect(image: homeImage, lable: homeLabel)
                break
            case uploadedButton:
                setViewSelect(image: examUploadImage, lable: examUploadLabel)
                break
            case historyButton:
                setViewSelect(image: historyImage, lable: historyLabel)
                break
            case profileButton:
                setViewSelect(image: profileImage, lable: profileLabel)
                break
            default:
                break
        }
        buttonSelect(button: sender)
    }
    
    func activeButton(tab: TabBar) {
        switch tab {
            case .HOME:
                setViewSelect(image: homeImage, lable: homeLabel)
                break
            case .EXAM_UPLOAD:
                setViewSelect(image: examUploadImage, lable: examUploadLabel)
                break
            case .HISTORY:
                setViewSelect(image: historyImage, lable: historyLabel)
                break
            case .PROFILE:
                setViewSelect(image: profileImage, lable: profileLabel)
                break
        }
    }
    
    func buttonSelect(button: UIButton) {
        SideMenuViewController.defaultHighlightedCell = button.tag
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
    }
    
    func setViewSelect(image: UIImageView, lable: UILabel) {
        [self.homeImage,
        self.examUploadImage,
        self.historyImage,
        self.profileImage].forEach {
            $0?.setImageColor(color: .systemGray2, status: true)
        }
        
        [self.homeLabel,
        self.examUploadLabel,
        self.historyLabel,
        self.profileLabel].forEach {
            $0?.textColor = UIColor.systemGray2
        }
        
        image.setImageColor(color: .systemGray2, status: false)
        lable.textColor = R.color.dB()
    }
}

extension UIImageView {
    func setImageColor(color: UIColor, status: Bool) {
        if status {
            let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
            self.image = templateImage
            self.tintColor = color
        } else {
            let templateImage = self.image?.withRenderingMode(.alwaysOriginal)
            self.image = templateImage
        }
    }
}
