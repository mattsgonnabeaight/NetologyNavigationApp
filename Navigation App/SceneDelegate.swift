import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appConfiguration: AppConfiguration?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = ( scene as? UIWindowScene) else { return }
        
        let urls = [
                    AppConfiguration.people(URL(string: "https://swapi.dev/api/people/8")!),
                    AppConfiguration.starship(URL(string: "https://swapi.dev/api/starships/3")!),
                    AppConfiguration.planet(URL(string: "https://swapi.dev/api/planets/5")!)
        ]
        appConfiguration = urls.randomElement()
        
        if let config = appConfiguration {
                    NetworkService.request(for: config)
        }
        
        window = UIWindow(windowScene: windowScene)
        
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
