import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = ( scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainCoordinator().start()
        window?.makeKeyAndVisible()
        let tabBarController = UITabBarController()
        let feedNavigationController = UINavigationController()
        let profileNavigationController = UINavigationController()
        let logInViewController = LogInViewController()
        
        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), tag:  0)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag:  1)
        
        feedNavigationController.viewControllers = [FeedViewController()]
        
        profileNavigationController.viewControllers = [logInViewController]

        logInViewController.loginDelegate = MyLoginFactory().makeLoginInspector()
        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        tabBarController.tabBar.backgroundColor = .systemBackground
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
