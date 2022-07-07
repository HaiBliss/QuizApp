//
//  SideMenuCell.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 01/07/2022.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Background
        self.backgroundColor = .clear
        
        // Icon
        iconImageView.setImageColor(color: .white, status: true)
        
        // Title
        self.titleLabel.textColor = .white
    }
}
