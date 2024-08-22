//
//  LogInViewController.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 18.8.24..
//

import UIKit

class LogInViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
        
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
    }()
    
    let logoView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = ProfileAvatarRounded(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.cornerRadius = 5.0
        return imageView
    }()
    
    private lazy var usernameTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.placeholder = "Email or phone"
        textField.autocapitalizationType = .none
        textField.textColor = .black
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "logoColor")
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupContentOfScrollView()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        removeKeyboardObservers()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
        
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
                
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func setupContentOfScrollView() {
        contentView.addSubview(logoView)
        contentView.addSubview(usernameTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 120.0),
            logoView.heightAnchor.constraint(equalToConstant: 100.0),
            logoView.widthAnchor.constraint(equalToConstant: 100.0),
            
            usernameTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120.0),
            usernameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            usernameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50.0),
            
            passwordTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
            
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16.0),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
        ])
    }
    @objc 
    func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        //scrollView.contentInset.bottom += keyboardHeight ?? 0.0
    }
        
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
            
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
        
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    
    @objc
    private func loginButtonPressed() {
        let pvc = ProfileViewController()
        self.navigationController?.pushViewController(pvc, animated: true)
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
