import UIKit

class LoginCoordinator: LoginBaseCoordinator {

    let logInViewController = LogInViewController()
    
    
    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = LogInViewController()
    
    
    func start() -> UIViewController {
        showLoginScreen()
        rootViewController = logInViewController
        return rootViewController
    }
    
    
    func showLoginScreen() {
        print("login screen")
        logInViewController.loginDelegate = MyLoginFactory().makeLoginInspector()
    }
}
