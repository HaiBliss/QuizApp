//
//  QuizTableViewCell.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 18/07/2022.
//

import UIKit

class ExamTableViewCell: UITableViewCell {

    @IBOutlet weak var examNameLabel: UILabel!
    @IBOutlet weak var infoExamLabel: UILabel!
    static let indentifier = "QuizTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "QuizTableViewCell", bundle: nil)
    }
    
    func updateView(exam: Exams.Exam) {
        examNameLabel.text = exam.name
        infoExamLabel.text = "\(exam.question_count ?? 0) câu - \(exam.time_count ?? 0) phút"
    }
}
