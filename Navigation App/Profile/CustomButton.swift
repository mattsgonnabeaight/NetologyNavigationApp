//
//  CustomButton.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 1.12.24..
//

import UIKit

class CustomButton: UIButton {
    var title: String
    var titleColor: UIColor
    var buttonColor: UIColor
    var action: String
    
    var alert: UIAlertController?
    var loginButtonDelegate: LogInViewController?
    var vc: UIViewController?
    var guessButtonDelegate: FeedViewController?
    
    required init(title: String, titleColor: UIColor, buttonColor: UIColor, action: String) {
        self.title = title
        self.titleColor = titleColor
        self.buttonColor = buttonColor
        self.action = action
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = buttonColor
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowOpacity = 0.7
        setTitle(title, for: .normal)
        
        switch action {
        case "login":
            addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        case "status":
            addTarget(self, action: #selector(showStatusButtonPressed), for: .touchUpInside)
        case "guess":
            addTarget(self, action: #selector(guessButtonPressed), for: .touchUpInside)
        default:
            print("action for button is not specified")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CustomButton {

    @objc
    private func loginButtonTapped() {
        print("felt into delegate func")
        if self.loginButtonDelegate?.loginDelegate?.check(login: loginButtonDelegate!.usernameTextField.text!, password: loginButtonDelegate!.passwordTextField.text!) == true {
            self.loginButtonDelegate?.navigationController?.pushViewController(vc!, animated: true)
        } else {
            alert?.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
            self.loginButtonDelegate?.present(alert!, animated: true, completion: nil)
        }
    }
    
    @objc
    private func showStatusButtonPressed() {
        print("button pressed")
    }
    
    @objc
    private func guessButtonPressed() {
        print("guess button pressed")
        if self.guessButtonDelegate?.model.check(word: (self.guessButtonDelegate?.guessTextField.text)!) == true {
            self.backgroundColor = .green
            self.guessButtonDelegate?.guessTextField.backgroundColor = .green
        } else {
            self.backgroundColor = .red
            self.guessButtonDelegate?.guessTextField.backgroundColor = .red
        }
    }
}
