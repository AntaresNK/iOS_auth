//
//  CreatePasswordViewController.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 13.10.2023.
//

import UIKit

class CreatePasswordViewController: UIViewController, UITextFieldDelegate {
    
    let navigationBar: UINavigationBar = {
        let backButton = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .plain, target: self, action: #selector(backButtonTouched))
        
        let navigationBar = UINavigationBar()
        navigationBar.setItems([UINavigationItem(title: "Создать пароль")], animated: false)
        navigationBar.topItem?.setLeftBarButton(backButton, animated: false)
        navigationBar.backgroundColor = nil
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.configureTextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Придумайте пароль"
        textField.addTarget(self, action: #selector(isValidPassword), for: .allEditingEvents)
        return textField
    }()
    
    let repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.configureTextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Повторите пароль"
        textField.addTarget(self, action: #selector(isValidPassword), for: .allEditingEvents)
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
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        button.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1), for: .normal)
        //button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        passwordTextField.delegate = self
        
        setupViews()
    }

    func setupViews() {
        hideKeyboardWhenTappedAraound()
        setNavigationView()
        setTextFields()
        setShowPassword()
        setShowPassword1()
        setStackView()
        setNextButton()
    }

    
    func setNavigationView() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
        }
    }
    
    func setTextFields() {
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(40)
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
            make.bottom.equalTo(passwordTextField.snp.bottom).offset(-9)
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
    
    @objc func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func showPassword1() {
        repeatPasswordTextField.isSecureTextEntry.toggle()
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
    
    @objc func isValidPassword() {
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
        
        if !text.isEmpty && !text1.isEmpty && text==text1 {
            equalPassLabel.textColor = UIColor(red: 93/255, green: 95/255, blue: 239/255, alpha: 1)
            if containsUppercaseLetter(text: text) && containsNumber(text: text) && containsSpecialSymbol(text: text) {
                nextButton.isEnabled = true
                nextButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 219/255, alpha: 1)
                nextButton.setTitleColor(.white, for: .normal)
            }
        } else {
            equalPassLabel.textColor = .lightGray
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
