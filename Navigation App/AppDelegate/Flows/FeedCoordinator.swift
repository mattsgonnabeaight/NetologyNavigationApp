import UIKit

class FeedCoordinator: FeedBaseCoordinator {
    func showFeedScreen() {
        print("feed screen")
    }
    
    
    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = FeedViewController()
    
    func start() -> UIViewController {
        return rootViewController
    }
    
}
