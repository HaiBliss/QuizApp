//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Hà Hữu Hải on 11/06/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
//        //Home
//        guard let homeVC = R.storyboard.homeViewController.homeViewController() else {
//            return
//        }
//        let homeNavi = UINavigationController(rootViewController: homeVC)
//        
//        //ExamUpload
//        guard let examUploadVC = R.storyboard.examUploadViewController.examUploadViewController() else {
//            return
//        }
//        let examUploadNavi = UINavigationController(rootViewController: examUploadVC)
//        
//        //History
//        guard let historyVC = R.storyboard.historyViewController.historyViewController() else {
//            return
//        }
//        let historyNavi = UINavigationController(rootViewController: historyVC)
//        
//        //Profile
//        guard let userVC = R.storyboard.userInfoViewController.userInfoViewController() else {
//            return
//        }
//        let userNavi = UINavigationController(rootViewController: userVC)
//        
//        self.window = window
//        window.makeKeyAndVisible()
//        
//        //tabbar controller
//        let tabbarController = UITabBarController()
//        tabbarController.viewControllers = [homeNavi, examUploadNavi, historyNavi, userNavi]
//                
//        window.rootViewController = tabbarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

