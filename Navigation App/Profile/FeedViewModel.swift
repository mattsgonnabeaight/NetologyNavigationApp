//
//  FeedViewModel.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 16.12.24..
//

import UIKit

class FeedViewModel {
    private let desiredPassword: String = "qwerty"
    
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
            check(word: word)
        }
        return button
    }()

    func check(word: String) -> Bool {
        if word == self.desiredPassword {
            textField.backgroundColor = .green
            return true
        } else {
            textField.backgroundColor = .red
            return false
        }
    }
}
