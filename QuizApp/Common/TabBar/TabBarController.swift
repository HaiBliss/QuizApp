//
//  TabBarController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 30/06/2022.
//

import UIKit

class TabBarController: UITabBarController {
    var customTabBar: TabBarView!
    var tabBarHeight: CGFloat = 60.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTabBar()

    }
    
    func loadTabBar() {
        let tabbarItems: [TabItem] = [.HOME, .EXAM_UPLOAD, .HISTORY, .PROFILE]
        
        setupCustomTabMenu(tabbarItems, completion: { viewControllers in
            self.viewControllers = viewControllers
        })

        selectedIndex = 0
    }
    
    func setupCustomTabMenu(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
        let frame = tabBar.frame
        var controllers = [UIViewController]()

        tabBar.isHidden = true
        // Khởi tạo custom tab bar
        customTabBar = TabBarView(menuItems: 4, frame: frame)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.clipsToBounds = true
        customTabBar.itemTapped = changeTab(tab:)
        view.addSubview(customTabBar)
        view.backgroundColor = .white

        // Auto layout cho custom tab bar
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        // Thêm các view controller tương ứng
        menuItems.forEach({
            controllers.append($0.viewController)
        })

        view.layoutIfNeeded()
        completion(controllers)
    }
    
    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }

}
