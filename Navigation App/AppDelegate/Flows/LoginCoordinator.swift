import UIKit

class LoginCoordinator: LoginBaseCoordinator {
    func showLoginScreen() {
        print("login screen")
    }
    
    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = LogInViewController()
    
    func start() -> UIViewController {
        return rootViewController
    }
    
}
