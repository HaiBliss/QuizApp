//
//  App.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 30/07/2022.
//

import Foundation
import UIKit

final class App {
    
    static var shared = App()
    
    var window: UIWindow!
    var mainNavigationController: UINavigationController!
    var loginViewController: UIViewController!
    var baseViewController: UIViewController!
    var homeViewController: UIViewController!
    
    func startInterface() {
        // MARK: Initial MainNavigationController and MainViewController
        mainNavigationController = UINavigationController()
        baseViewController = UIStoryboard.base.baseViewController
        
        homeViewController = UIStoryboard.home.homeViewController
        mainNavigationController.viewControllers = [homeViewController]
   
        // MARK: Initial LoginViewController
        loginViewController = UIStoryboard.login.loginViewController
        
        if UserDefaults.standard.bool(forKey: "LOGGED_IN") { // check whether user logged or not
//            window.rootViewController = baseViewController
            window.rootViewController = mainNavigationController
        } else {
            window.rootViewController = loginViewController
        }
        
        window.makeKeyAndVisible()
    }
    
    func swipeBackToLogin() {
        let snapShot = window.snapshotView(afterScreenUpdates: true)
        if let snapShot = snapShot {
            loginViewController.view.addSubview(snapShot)
        }
        window.rootViewController = loginViewController

        UIView.animate(withDuration: 0.3, animations: {
            snapShot?.layer.opacity = 0
            snapShot?.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }) { finished in
            snapShot?.removeFromSuperview()
        }
    }
    
    func swipeLoginToMain() {
        let snapShot = window.snapshotView(afterScreenUpdates: true)
        if let snapShot = snapShot {
            baseViewController.view.addSubview(snapShot)
        }
        window.rootViewController = baseViewController
        
//        guard let vc = R.storyboard.homeViewController.homeViewController() else {
//            return
//        }

        //self.navigationController?.setViewControllers([vc], animated: false)

        UIView.animate(withDuration: 0.3, animations: {
            snapShot?.layer.opacity = 0
            snapShot?.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }) { finished in
            snapShot?.removeFromSuperview()
        }
    }
    
    
    func swipeLoginToHome() {
        let snapShot = window.snapshotView(afterScreenUpdates: true)
        if let snapShot = snapShot {
            baseViewController.view.addSubview(snapShot)
        }
        window.rootViewController = mainNavigationController

        UIView.animate(withDuration: 0.3, animations: {
            snapShot?.layer.opacity = 0
            snapShot?.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }) { finished in
            snapShot?.removeFromSuperview()
        }
    }
}

extension UIStoryboard {
    static var home: UIStoryboard {
        return UIStoryboard(name: "HomeViewController", bundle: nil)
    }
    
    static var login: UIStoryboard {
        return UIStoryboard(name: "LoginViewController", bundle: nil)
    }
    
    static var base: UIStoryboard {
        return UIStoryboard(name: "BaseViewController", bundle: nil)
    }
}

extension UIStoryboard {
    var loginViewController: LoginViewController {
        guard let vc = R.storyboard.loginViewController.loginViewController() else {
            fatalError("MainViewController couldn't be found in Storyboard file")
        }
        return vc
    }
    
    var baseViewController: BaseViewController {
        guard let vc = UIStoryboard.base.instantiateViewController(withIdentifier: "BaseViewController") as? BaseViewController else {
            fatalError("MainViewController couldn't be found in Storyboard file")
        }
        return vc
    }
    
    var homeViewController: HomeViewController {
        guard let vc = UIStoryboard.home.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            fatalError("MainViewController couldn't be found in Storyboard file")
        }
        return vc
       
    }
}
