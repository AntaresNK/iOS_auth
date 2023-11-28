//
//  CreatePasswordViewController.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 13.10.2023.
//

import UIKit

class CreatePasswordViewController: UIViewController, UITextFieldDelegate {
    var rootVCPassword = ""
    let rootVCSignup = "splashVC"
    let rootVCSignin = "signinVC"
    let rootVCReset = "resetVC"
    
    let passwordTextField: TextFieldDelegate = {
        let textField = TextFieldDelegate()
        textField.setPlaceholderText(text: "Придумайте пароль")
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Минимальная длина — 8 символов"
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.textColor = .red
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repeatPasswordTextField: TextFieldDelegate = {
        let textField = TextFieldDelegate()
        textField.setPlaceholderText(text: "Повторите пароль")
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let showPasswordButton1: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.addTarget(self, action: #selector(showPassword1), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let uppercaseLabel: UILabel = {
        let label = UILabel()
        label.text = "• Заглавная буква"
        label.configureLabel()
        return label
    }()
    
    let numbersLabel: UILabel = {
        let label = UILabel()
        label.text = "• Цифры"
        label.configureLabel()
        return label
    }()
    
    let symbolsLabel: UILabel = {
        let label = UILabel()
        label.text = "• Специальные символы"
        label.configureLabel()
        return label
    }()
    
    let equalPassLabel: UILabel = {
        let label = UILabel()
        label.text = "• Совпадение пароля"
        label.configureLabel()
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Далее", for: .normal)
        button.configureButton()
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        passwordTextField.delegate = self
        setupViews()
        hideKeyboardWhenTappedAraound()
    }

    func setupViews() {
        if rootVCPassword == rootVCSignup {
            title = "Создать пароль"
        } else if rootVCPassword == rootVCSignin {
            title = "Сброс пароля"
        }
        setTextFields()
        setShowPassword()
        setShowPassword1()
        setStackView()
        setNextButton()
        setWarningLabel()
    }
    
    func setTextFields() {
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        view.addSubview(repeatPasswordTextField)
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func setShowPassword() {
        view.addSubview(showPasswordButton)
        showPasswordButton.snp.makeConstraints { make in
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-10)
            make.bottom.equalTo(passwordTextField.snp.bottom).offset(-10)
            make.size.equalTo(24)
        }
    }
    
    func setShowPassword1() {
        view.addSubview(showPasswordButton1)
        showPasswordButton1.snp.makeConstraints { make in
            make.trailing.equalTo(repeatPasswordTextField.snp.trailing).offset(-10)
            make.bottom.equalTo(repeatPasswordTextField.snp.bottom).offset(-9)
            make.size.equalTo(24)
        }
    }
    
    func setWarningLabel() {
        view.addSubview(warningLabel)
        warningLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
        }
    }
    
    func setStackView() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        setLabels()
    }
    
    func setLabels() {
        stackView.addArrangedSubview(uppercaseLabel)
        stackView.addArrangedSubview(numbersLabel)
        stackView.addArrangedSubview(symbolsLabel)
        stackView.addArrangedSubview(equalPassLabel)
    }
    
    func setNextButton() {
        nextButton.isEnabled = false
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(stackView.snp.bottom).offset(40)
        }
    }
    
    @objc func textFieldDidChange() {
        let isPasswordFieldEmpty = passwordTextField.text?.isEmpty ?? true
        let isRepeatPasswordTextField = repeatPasswordTextField.text?.isEmpty ?? true
        
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
        
        if !isRepeatPasswordTextField {
            showPasswordButton1.setImage(UIImage(named: "eye-disable"), for: .normal)
            showPasswordButton1.snp.remakeConstraints { make in
                make.trailing.equalTo(repeatPasswordTextField.snp.trailing).offset(-10)
                make.bottom.equalTo(repeatPasswordTextField.snp.bottom).offset(-10)
                make.size.equalTo(24)
            }
        } else {
            showPasswordButton1.setImage(UIImage(named: "Vector"), for: .normal)
            showPasswordButton1.snp.remakeConstraints { make in
                make.trailing.equalTo(repeatPasswordTextField.snp.trailing).offset(-10)
                make.bottom.equalTo(repeatPasswordTextField.snp.bottom).offset(-18)
                make.size.equalTo(24)
            }
        }
        isValidPassword()
    }
    
    @objc func showPassword() {
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
    
    @objc func showPassword1() {
        repeatPasswordTextField.isSecureTextEntry.toggle()
        if repeatPasswordTextField.isSecureTextEntry {
            showPasswordButton1.setImage(UIImage(named: "eye-disable"), for: .normal)
            showPasswordButton1.snp.remakeConstraints { make in
                make.trailing.equalTo(repeatPasswordTextField.snp.trailing).offset(-10)
                make.bottom.equalTo(repeatPasswordTextField.snp.bottom).offset(-10)
                make.size.equalTo(24)
            }
        } else {
            showPasswordButton1.setImage(UIImage(named: "Vector"), for: .normal)
            showPasswordButton1.snp.remakeConstraints { make in
                make.trailing.equalTo(repeatPasswordTextField.snp.trailing).offset(-10)
                make.bottom.equalTo(repeatPasswordTextField.snp.bottom).offset(-10)
                make.size.equalTo(24)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.rangeOfCharacter(from: .whitespaces) != nil {
            return false
        }
        return true
    }
    
    func containsUppercaseLetter(text: String) -> Bool {
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex).evaluate(with: text)
    }

    func containsNumber(text: String) -> Bool {
        let numberRegex = ".*\\d+.*"
        return NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: text)
    }

    func containsSpecialSymbol(text: String) -> Bool {
        let specialSymbolRegex = ".*[@$#!%*?&]+.*"
        return NSPredicate(format: "SELF MATCHES %@", specialSymbolRegex).evaluate(with: text)
    }
    
    func countsEight(text: String) -> Bool {
        return text.count > 7 && text.count < 16
    }
    
    func isValidPassword() {
        let text = passwordTextField.text ?? ""
        let text1 = repeatPasswordTextField.text ?? ""
        
        if containsUppercaseLetter(text: text) {
            uppercaseLabel.textColor = UIColor(red: 93/255, green: 95/255, blue: 239/255, alpha: 1)
        } else {
            uppercaseLabel.textColor = .lightGray
        }
        
        if containsNumber(text: text) {
            numbersLabel.textColor = UIColor(red: 93/255, green: 95/255, blue: 239/255, alpha: 1)
        } else {
            numbersLabel.textColor = .lightGray
        }
        
        if containsSpecialSymbol(text: text) {
            symbolsLabel.textColor = UIColor(red: 93/255, green: 95/255, blue: 239/255, alpha: 1)
        } else {
            symbolsLabel.textColor = .lightGray
        }
        
        if countsEight(text: text) {
            warningLabel.isHidden = true
        } else {
            warningLabel.isHidden = false
        }
        
        if !text.isEmpty && !text1.isEmpty && text==text1 {
            equalPassLabel.textColor = UIColor(red: 93/255, green: 95/255, blue: 239/255, alpha: 1)
            if containsUppercaseLetter(text: text) && containsNumber(text: text) && containsSpecialSymbol(text: text) && countsEight(text: text) {
                nextButton.isEnabled = true
                nextButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 219/255, alpha: 1)
                nextButton.setTitleColor(.white, for: .normal)
            }
        } else {
            equalPassLabel.textColor = .lightGray
        }
    }
    
    @objc func nextButtonTapped() {
        if rootVCPassword == rootVCSignup {
            let splashVC = SplashViewController()
            splashVC.modalPresentationStyle = .overFullScreen
            present(splashVC, animated: true)
        } else if rootVCPassword == rootVCSignin{
            let signinVC = SigninViewController()
            signinVC.rootVCReset = rootVCReset
            signinVC.modalPresentationStyle = .overFullScreen
            present(signinVC, animated: true)
        }
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
