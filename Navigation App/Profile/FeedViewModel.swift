import UIKit

class FeedViewModel {

    
    func guess(word: String, model: FeedModel, vc: FeedViewController) {
        if model.check(word: word) == true {
            vc.textField.backgroundColor = .green
        } else {
            vc.textField.backgroundColor = .red
        }
    }
}
