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
    
    lazy var phraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Загрузка..."
        return label
    }()
    
    lazy var planetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Загрузка данных о планете..."
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        setupViews()
        setupConstraints()
        startGuessTimer()
        fetchPhrase()
    }
    
    func setupViews() {
        view.addSubview(textField)
        view.addSubview(guessButton)
        view.addSubview(countdownLabel)
        view.addSubview(phraseLabel)
        view.addSubview(planetLabel)

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
            countdownLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -20),
            
            phraseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phraseLabel.bottomAnchor.constraint(equalTo: countdownLabel.topAnchor, constant: -60),
            
            planetLabel.topAnchor.constraint(equalTo: phraseLabel.bottomAnchor, constant: 16),
            planetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            planetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
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
    
    func fetchPhrase() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let title = json["title"] as? String {
                    DispatchQueue.main.async {
                        self.phraseLabel.text = "Phrase: \(title)"
                    }
                }
            } catch {
                print("Ошибка при парсинге JSON: \(error)")
            }
        }

        task.resume()
    }
    
    func fetchPlanet() {
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else {
            self.planetLabel.text = "❌ Неверный URL"
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка сети: \(error)")
                DispatchQueue.main.async {
                    self.planetLabel.text = "❌ Ошибка сети: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                print("Нет данных от сервера")
                DispatchQueue.main.async {
                    self.planetLabel.text = "❌ Нет данных от сервера."
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let planet = try decoder.decode(Planet.self, from: data)
                print("✅ Успешно получили планету: \(planet)")
                DispatchQueue.main.async {
                    self.planetLabel.text = "🪐 Орбитальный период Татуина: \(planet.orbitalPeriod) дней"
                }
            } catch {
                print("❌ Ошибка декодирования: \(error)")
                DispatchQueue.main.async {
                    self.planetLabel.text = "❌ Ошибка при разборе JSON"
                }
            }
        }

        task.resume()
    }


}
