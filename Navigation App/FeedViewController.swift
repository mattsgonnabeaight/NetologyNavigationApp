import UIKit
import StorageService

class FeedViewController: UIViewController {

    var model = FeedModel()
    let feedViewModel = FeedViewModel()
    
    lazy var guessTextField = feedViewModel.textField
    lazy var checkGuessButton = feedViewModel.guessButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        setupViews()
        setupConstraints()
        
    }
    
    func setupViews() {
        view.addSubview(guessTextField)
        view.addSubview(checkGuessButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            guessTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            guessTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            guessTextField.heightAnchor.constraint(equalToConstant: 50.0),
            guessTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            guessTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            
            checkGuessButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            checkGuessButton.topAnchor.constraint(equalTo: guessTextField.bottomAnchor, constant: 16.0),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50.0),
            checkGuessButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            checkGuessButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
        ])
    }
}
