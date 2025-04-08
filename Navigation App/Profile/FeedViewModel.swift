import UIKit

class FeedViewModel {

    
    func guess(word: String, model: FeedModel, vc: FeedViewController) {
        vc.resetTimer()
        let result = checkGuess(word: word, model: model)

        switch result {
        case .success:
            vc.textField.backgroundColor = .green
        case .failure:
            vc.textField.backgroundColor = .red
        }
        vc.startGuessTimer()
    }

    func checkGuess(word: String, model: FeedModel) -> Result<Void, GuessError> {
        if model.check(word: word) {
            return .success(())
        } else {
            return .failure(.incorrectGuess)
        }
    }

}
