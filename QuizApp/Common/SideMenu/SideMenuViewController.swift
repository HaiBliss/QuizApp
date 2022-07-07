//
//  SideMenuViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 01/07/2022.
//

import UIKit


protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

class SideMenuViewController: UIViewController {
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var sideMenuTableView: UITableView!
    @IBOutlet var footerLabel: UILabel!

    var delegate: SideMenuViewControllerDelegate?

    static var defaultHighlightedCell: Int = 0

    var menu: [SideMenuModel] = [
        SideMenuModel(icon: R.image.home()!, title: "Home"),
        SideMenuModel(icon: R.image.exam_upload()!, title: "Đề Thi Đã Tải Lên"),
        SideMenuModel(icon: R.image.exam()!, title: "Lịch Sử"),
        SideMenuModel(icon: R.image.profile()!, title: "Cá Nhân"),
//        SideMenuModel(icon: UIImage(systemName: "person.fill")!, title: "Profile"),
//        SideMenuModel(icon: UIImage(systemName: "slider.horizontal.3")!, title: "Settings"),
        SideMenuModel(icon: R.image.love()!, title: "Góp Ý, Liên Hệ")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // TableView
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.backgroundColor = R.color.f94FB()
        self.sideMenuTableView.separatorStyle = .none

        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: SideMenuViewController.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }

        // Footer
        self.footerLabel.textColor = UIColor.white
        self.footerLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.footerLabel.text = "V1.0 Copyright 2022"

        // Register TableView Cell
        self.sideMenuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)

        // Update TableView with the data
        self.sideMenuTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: SideMenuViewController.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }
    }
    
    func setHighlightedCell() {
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: SideMenuViewController.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }
    }
}


// MARK: - UITableViewDelegate

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

// MARK: - UITableViewDataSource

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }

        cell.iconImageView.image = self.menu[indexPath.row].icon
        cell.iconImageView.setImageColor(color: .white, status: true)
        cell.titleLabel.text = self.menu[indexPath.row].title

        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = R.color.e54C8()
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath.row)
        if indexPath.row < 4 {
            SideMenuViewController.defaultHighlightedCell = indexPath.row
        }
       
        // Remove highlighted color when you press the 'Profile' and 'Like us on facebook' cell
        if indexPath.row == 4 || indexPath.row == 6 {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
