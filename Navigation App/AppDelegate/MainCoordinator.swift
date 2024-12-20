//
//  MainCoordinator.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 18.12.24..
//

import UIKit

enum AppFlow {
    case feed
    case login
}

class MainCoordinator: MainBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var feedCoordinator: FeedBaseCoordinator = FeedCoordinator()
    lazy var loginCoordinator: LoginBaseCoordinator = LoginCoordinator()
    
    var rootViewController: UIViewController = UITabBarController()
    
    func start() -> UIViewController {
        let feedViewController = feedCoordinator.start()
        feedCoordinator.parentCoordinator = self
        feedViewController.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "house"),
            tag: 0)
        
        let loginViewController = loginCoordinator.start()
        loginCoordinator.parentCoordinator = self
        loginViewController.tabBarItem = UITabBarItem(
            title: "Login",
            image: UIImage(systemName: "person.fill"),
            tag: 1)
        
        (rootViewController as? UITabBarController)?.viewControllers = [feedViewController, loginViewController]
        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .feed:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .login:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        }
    }
    
    func resetToRoot() -> Self {
        feedCoordinator.resetToRoot()
        moveTo(flow: .feed)
        return self
    }
}
