//
//  SigninViewController.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 13.10.2023.
//

import UIKit

class SigninViewController: UIViewController, UITextFieldDelegate {
    let rootVCSignin = "signinVC"
    let email = "qwerty@gmail.co"
    let password = "Qwer23#"
    
    let logoImage: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "logo")
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
    
    let emailTextField: TextFieldDelegate = {
        let textField = TextFieldDelegate()
        textField.setPlaceholderText(text: "Электронная почта")
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(isAuthorised), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField: TextFieldDelegate = {
        let textField = TextFieldDelegate()
        textField.setPlaceholderText(text: "Пароль")
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        return textField
    }()
    
    let showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Неверный логин или пароль"
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.configureButton()
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(UIColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    func setupViews() {
        title = "Авторизация"
        hideKeyboardWhenTappedAraound()
        setLogoImage()
        setEmailTexfield()
        setPasswordTexfield()
        setShowPassword()
        setWarningLabel()
        setNextButton()
        setForgotPasswordButton()
    }
    
    func setLogoImage() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            make.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
    }
    
    func setEmailTexfield() {
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func setPasswordTexfield() {
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func setShowPassword() {
        view.addSubview(showPasswordButton)
        showPasswordButton.snp.makeConstraints { make in
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-10)
            make.bottom.equalTo(passwordTextField.snp.bottom).offset(-18)
            make.size.equalTo(24)
        }
    }
    
    func setWarningLabel() {
        view.addSubview(warningLabel)
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    func setNextButton() {
        nextButton.isEnabled = false
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(65)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(60)
        }
    }
    
    func setForgotPasswordButton() {
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
        }
    }
    
    @objc func textFieldDidChange() {
        let isPasswordFieldEmpty = passwordTextField.text?.isEmpty ?? true
        
        if !isPasswordFieldEmpty {
            showPasswordButton.setImage(UIImage(named: "eye-disable"), for: .normal)
            showPasswordButton.snp.remakeConstraints { make in
                make.trailing.equalTo(passwordTextField.snp.trailing).offset(-10)
                make.bottom.equalTo(passwordTextField.snp.bottom).offset(-10)
                make.size.equalTo(24)
            }
        } else {
            showPasswordButton.setImage(UIImage(named: "Vector"), for: .normal)
            showPasswordButton.snp.remakeConstraints { make in
                make.trailing.equalTo(passwordTextField.snp.trailing).offset(-10)
                make.bottom.equalTo(passwordTextField.snp.bottom).offset(-18)
                make.size.equalTo(24)
            }
        }
        isAuthorised()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let currentEmail = emailTextField.text!
        let currentPassword = passwordTextField.text!
        
        if currentEmail.lowercased() != email || currentPassword != password {
            let attributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.red ]
            emailTextField.attributedText = NSAttributedString(string: emailTextField.text ?? "", attributes: attributes)
            emailTextField.layer.borderWidth = 1.0
            emailTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.attributedText = NSAttributedString(string: passwordTextField.text ?? "", attributes: attributes)
            passwordTextField.layer.borderWidth = 1.0
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            warningLabel.isHidden = false
        } else {
            let attributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.black ]
            emailTextField.attributedText = NSAttributedString(string: emailTextField.text ?? "", attributes: attributes)
             emailTextField.layer.borderColor = CGColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            passwordTextField.layer.borderColor = CGColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            
             warningLabel.isHidden = true
        }
    }
    
    @objc func showPassword() {
        let isPasswordFieldEmpty = passwordTextField.text?.isEmpty ?? true
        
        if isPasswordFieldEmpty {
            return
        }
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            showPasswordButton.setImage(UIImage(named: "eye-disable"), for: .normal)
            showPasswordButton.snp.remakeConstraints { make in
                make.trailing.equalTo(passwordTextField.snp.trailing).offset(-10)
                make.bottom.equalTo(passwordTextField.snp.bottom).offset(-10)
                make.size.equalTo(24)
            }
        } else {
            showPasswordButton.setImage(UIImage(named: "Vector"), for: .normal)
            showPasswordButton.snp.remakeConstraints { make in
                make.trailing.equalTo(passwordTextField.snp.trailing).offset(-10)
                make.bottom.equalTo(passwordTextField.snp.bottom).offset(-10)
                make.size.equalTo(24)
            }
        }
    }
    
    @objc func isAuthorised() {
        let isEmailFieldEmpty = emailTextField.text?.isEmpty ?? true
        
        if isEmailFieldEmpty {
            passwordTextField.text = ""
            passwordTextField.isEnabled = false
        } else {
            passwordTextField.isEnabled = true
        }
        
        let currentEmail = emailTextField.text!.lowercased()
        let currentPassword = passwordTextField.text!
        if email == currentEmail && password == currentPassword {
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 219/255, alpha: 1)
            nextButton.setTitleColor(.white, for: .normal)
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
            nextButton.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1), for: .normal)
        }
    }
    
    @objc func forgotPassword() {
        let signupVC = SignupViewController()
        signupVC.rootVCSignup = rootVCSignin
        signupVC.modalPresentationStyle = .overFullScreen
        navigationItem.title = ""
        navigationController?.show(signupVC, sender: self)
    }
    
    @objc func nextButtonTapped() {
        let splashVC = SplashViewController()
        splashVC.modalPresentationStyle = .overFullScreen
        present(splashVC, animated: true)
    }
    
    @objc func backButtonTouched() {
        self.dismissView()
    }
    
    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAraound() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
