import UIKit
import StorageService

class FeedViewController: UIViewController {

    let model = FeedModel()
    let feedViewModel = FeedViewModel()
    var guessTimer: Timer?
    var countdownTimer: Timer?
    var remainingSeconds: Int = 10
    
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
    
    lazy var countdownLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textAlignment = .center
            label.text = "Time: 10"
            return label
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
        startGuessTimer()
    }
    
    func setupViews() {
        view.addSubview(textField)
        view.addSubview(guessButton)
        view.addSubview(countdownLabel)
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
            
            countdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countdownLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -20)
        ])
    }
    
    func startGuessTimer() {
        guessTimer?.invalidate()
        countdownTimer?.invalidate()
        
        remainingSeconds = 10
        updateCountdownLabel()

        guessTimer = Timer.scheduledTimer(timeInterval: 10.0,
                                          target: self,
                                          selector: #selector(timerFired),
                                          userInfo: nil,
                                          repeats: false)

        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(updateCountdown),
                                              userInfo: nil,
                                              repeats: true)
    }

    @objc func updateCountdown() {
        remainingSeconds -= 1
        updateCountdownLabel()

        if remainingSeconds <= 0 {
            countdownTimer?.invalidate()
        }
    }

    func updateCountdownLabel() {
        countdownLabel.text = "Осталось времени чтобы угадать: \(remainingSeconds)"
    }

    func resetTimer() {
        guessTimer?.invalidate()
        countdownTimer?.invalidate()
    }

    @objc func timerFired() {
        textField.backgroundColor = .gray
        showTimeExpiredAlert()
    }

    func showTimeExpiredAlert() {
        let alert = UIAlertController(title: "⏰ Время вышло!",
                                      message: "Вы не успели ввести слово вовремя.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
