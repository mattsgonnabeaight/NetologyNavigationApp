//
//  LogInViewController.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 18.8.24..
//

import UIKit

class LogInViewController: UIViewController {
    
    var loginDelegate: LogInViewControllerDelegate?
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var view1: UIView = {
            let view = UIView()
            view.backgroundColor = .systemBackground
            return view
        }()
            
        
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBackground
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
    
    private lazy var credentialsBlock: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.addArrangedSubview(self.usernameTextField)
        stackView.addArrangedSubview(self.passwordTextField)
        return stackView
    }()
    
    fileprivate lazy var usernameTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 16)
        //textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.placeholder = "Email or phone"
        //textField.leftView = paddingView
        textField.autocapitalizationType = .none
        textField.textColor = .black
        textField.delegate = self
        addPadding(textField)
        return textField
    }()
    
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        //textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        addPadding(textField)
        return textField
    }()
    
    private lazy var loginButton : UIButton = {
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
        self.view.backgroundColor = .systemBackground
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
        contentView.addSubview(credentialsBlock)
        contentView.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 120.0),
            logoView.heightAnchor.constraint(equalToConstant: 100.0),
            logoView.widthAnchor.constraint(equalToConstant: 100.0),
            
            credentialsBlock.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16.0),
            credentialsBlock.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16.0),
            credentialsBlock.topAnchor.constraint(equalTo: logoView.bottomAnchor,constant: 120.0),
            credentialsBlock.heightAnchor.constraint(equalToConstant: 105),
            
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: credentialsBlock.bottomAnchor, constant: 16.0),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
        ])
    }
    @objc 
    func willShowKeyboard(_ notification: NSNotification) {
        lazy var keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
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
        self.loginDelegate?.check(login: usernameTextField.text!, password: passwordTextField.text!)
        let pvc = ProfileViewController()
        let alert = UIAlertController(title: "Ошибка", message: "Некорретный логин", preferredStyle: .alert)
        print(pvc.user)
//        if usernameTextField.text == pvc.user.login {
//            self.navigationController?.pushViewController(pvc, animated: true)
//        } else {
//            alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
    private func addPadding(_ textField: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
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

protocol LogInViewControllerDelegate {
    func check(login: String, password: String)
}
