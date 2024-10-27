import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = ( scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let tabBarController = UITabBarController()
        let feedNavigationController = UINavigationController()
        let profileNavigationController = UINavigationController()
        
        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), tag:  0)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag:  1)
        
        feedNavigationController.viewControllers = [FeedViewController()]
        
        profileNavigationController.viewControllers = [LogInViewController()]

        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        tabBarController.tabBar.backgroundColor = .systemBackground
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}
