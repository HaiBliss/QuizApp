//
//  SubjectCollectionReusableView.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 15/07/2022.
//

import UIKit

class SubjectCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var departmentNameLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    static let indentifier = "SubjectCollectionReusableView"
    var isSeeAll: ((_ departmentId: Int ) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SubjectCollectionReusableView", bundle: nil)
    }
    @IBAction func seeAllAction(_ sender: Any) {
        
    }
    
}
