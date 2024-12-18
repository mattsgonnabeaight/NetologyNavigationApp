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
        
        credentialsBlock.addArrangedSubview(self.usernameTextField)
        credentialsBlock.addArrangedSubview(self.passwordTextField)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
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
    @objc 
    func willShowKeyboard(_ notification: NSNotification) {
        lazy var keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
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
    func check(login: String, password: String) -> Bool
}

extension LogInViewController {
    func loginInProfile() {
        if self.loginDelegate?.check(login: usernameTextField.text!, password: passwordTextField.text!) == true {
                    self.navigationController?.pushViewController(pvc, animated: true)
                } else {
                    alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
    }
}
