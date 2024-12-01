//
//  FeedViewController.swift
//  Navigation
//
//  Created by Matvey Krasnov on 7.8.24..
//

import UIKit
import StorageService

class FeedViewController: UIViewController {

    var model = FeedModel()
    
    lazy var guessTextField : UITextField = {
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
    
    private lazy var checkGuessButton : CustomButton = {
        let button = CustomButton(title: "Guess", titleColor: .white, buttonColor: .gray, action: "guess")
        button.guessButtonDelegate = self
        button.alert = UIAlertController(title: "Ошибка", message: "Некорретный логин", preferredStyle: .alert)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        
        view.addSubview(guessTextField)
        view.addSubview(checkGuessButton)
        
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
