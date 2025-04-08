import UIKit

class LogInViewController: UIViewController {
    
    var loginDelegate: LogInViewControllerDelegate?
    let pvc = ProfileViewController()
    let alert = UIAlertController(title: "Ошибка", message: "Некорретный логин", preferredStyle: .alert)
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
        
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var credentialsBlock: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        return stackView
    }()

    var usernameTextField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.placeholder = "Log In"
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.borderWidth = 0.25
        login.leftViewMode = .always
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: login.frame.height))
        login.keyboardType = .emailAddress
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.returnKeyType = .done
        return login
    }()
    
    var passwordTextField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leftViewMode = .always
        password.placeholder = "Password"
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.25
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.isSecureTextEntry = true
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.returnKeyType = .done
        return password
    }()
   
    private lazy var customLoginButton : CustomButton = {
        let button = CustomButton(title: "Log in", titleColor: .white, buttonColor: UIColor(named: "logoColor")!){ [unowned self] in
            guard let login = usernameTextField.text, let password = passwordTextField.text else { return }
            loginInProfile()
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupViews()
        setupContentOfScrollView()
        setupConstraints()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    var didAppearOnce = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !didAppearOnce {
            didAppearOnce = true
            usernameTextField.becomeFirstResponder()
        }
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
        
        credentialsBlock.addArrangedSubview(self.usernameTextField)
        credentialsBlock.addArrangedSubview(self.passwordTextField)
        
        
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
        contentView.addSubview(customLoginButton)
        
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 120.0),
            logoView.heightAnchor.constraint(equalToConstant: 100.0),
            logoView.widthAnchor.constraint(equalToConstant: 100.0),
            
            credentialsBlock.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16.0),
            credentialsBlock.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16.0),
            credentialsBlock.topAnchor.constraint(equalTo: logoView.bottomAnchor,constant: 120.0),
            credentialsBlock.heightAnchor.constraint(equalToConstant: 105),
            
            customLoginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            customLoginButton.topAnchor.constraint(equalTo: credentialsBlock.bottomAnchor, constant: 16.0),
            customLoginButton.heightAnchor.constraint(equalToConstant: 50.0),
            customLoginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            customLoginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
        ])
    }
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardHeight = keyboardFrame.cgRectValue.height
        let extraPadding: CGFloat = 80 

        scrollView.contentInset.bottom = keyboardHeight + extraPadding
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight + extraPadding

        let loginButtonFrameInScroll = scrollView.convert(customLoginButton.frame, from: contentView)

        if loginButtonFrameInScroll.maxY > (view.frame.height - keyboardHeight) {
            scrollView.scrollRectToVisible(loginButtonFrameInScroll, animated: true)
        }
    }
        
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(self.keyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
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
    
    private func addPadding(_ textField: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    @objc func keyboardWillChangeFrame(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardHeight = view.frame.height - keyboardFrame.origin.y
        let extraPadding: CGFloat = 80

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: curve << 16),
            animations: {
                self.scrollView.contentInset.bottom = keyboardHeight + extraPadding
                self.scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight + extraPadding

                let loginButtonFrameInScroll = self.scrollView.convert(self.customLoginButton.frame, from: self.contentView)
                if loginButtonFrameInScroll.maxY > (self.view.frame.height - keyboardHeight) {
                    self.scrollView.scrollRectToVisible(loginButtonFrameInScroll, animated: false)
                }
            }
        )
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
    func check(login: String, password: String) -> Bool
}

extension LogInViewController {
    func loginInProfile() {
        do {
            try attemptLogin()
            self.navigationController?.pushViewController(pvc, animated: true)
        } catch let error as LoginError {
            presentErrorAlert(for: error)
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    private func attemptLogin() throws {
        guard let username = usernameTextField.text, !username.isEmpty else {
            throw LoginError.emptyUsername
        }

        guard let password = passwordTextField.text, !password.isEmpty else {
            throw LoginError.emptyPassword
        }

        guard loginDelegate?.check(login: username, password: password) == true else {
            throw LoginError.invalidCredentials
        }
    }

    private func presentErrorAlert(for error: LoginError) {
        let alert = UIAlertController(title: "Ошибка входа", message: nil, preferredStyle: .alert)

        switch error {
        case .emptyUsername:
            alert.message = "Пожалуйста, введите имя пользователя."
        case .emptyPassword:
            alert.message = "Пожалуйста, введите пароль."
        case .invalidCredentials:
            alert.message = "Неверное имя пользователя или пароль."
        }

        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}
