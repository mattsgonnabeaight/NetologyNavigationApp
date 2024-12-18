import UIKit
import StorageService

class FeedViewController: UIViewController {

    let model = FeedModel()
    let feedViewModel = FeedViewModel()
    
    lazy var textField : UITextField = {
       let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.font = UIFont.systemFont(ofSize: 16)
       textField.layer.borderColor = UIColor.lightGray.cgColor
       textField.layer.borderWidth = 0.5
       textField.placeholder = "Email or phone"
       textField.autocapitalizationType = .none
       textField.textColor = .black
       return textField
   }()
    
    lazy var guessButton : CustomButton = {
        let button = CustomButton(title: "Guess", titleColor: .white, buttonColor: .gray) { [unowned self] in
            guard let word = textField.text else { return }
            feedViewModel.guess(word: word, model: model, vc: self)
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        setupViews()
        setupConstraints()
        
    }
    
    func setupViews() {
        view.addSubview(textField)
        view.addSubview(guessButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50.0),
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            
            guessButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            guessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16.0),
            guessButton.heightAnchor.constraint(equalToConstant: 50.0),
            guessButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            guessButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
        ])
    }
}
