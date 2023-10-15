//
//  ProfileViewController.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 13.10.2023.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    var email = ""
    let rootVCSplash = "splashVC"
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameTextField: TextFieldDelegate = {
        let textField = TextFieldDelegate()
        textField.setPlaceholderText(text: "Имя")
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let lastnameTextField: TextFieldDelegate = {
        let textField = TextFieldDelegate()
        textField.setPlaceholderText(text: "Фамилия")
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let birthDateTextField: TextFieldDelegate = {
        let textField = TextFieldDelegate()
        textField.setPlaceholderText(text: "Дата рождения")
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let emailTextField: TextFieldDelegate = {
        let textField = TextFieldDelegate()
        textField.setPlaceholderText(text: "Электронная почта")
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.configureButton()
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Профиль"
        navigationController?.customize()
   //     birthDateTextField.delegate = self
        hideKeyboardWhenTappedAraound()
        setupViews()
        setSignupButton()
        
    }
    
    func setupViews() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        setTextFields()
    }
    
    func setTextFields() {
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(lastnameTextField)
        stackView.addArrangedSubview(birthDateTextField)
        stackView.addArrangedSubview(emailTextField)
        emailTextField.text = email
    }
    
    func setSignupButton() {
        view.addSubview(signupButton)
        signupButton.isEnabled = false
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
        }
    }
    
    
    func shouldChangeCharactersIn(currentText: String, range: NSRange, replacementString: String) -> Bool {
        let currentText = (birthDateTextField.text ?? "") as NSString
        
        if replacementString.isEmpty {
            return true
        }
        
        if replacementString.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
            if currentText.length < 10 {
                switch currentText.length {
                case 2, 5:
                    birthDateTextField.text = birthDateTextField.text! + ".\(replacementString)"
                case 10:
                    return false
                default:
                    birthDateTextField.text = birthDateTextField.text! + replacementString
                }
                return false
            }
        }
        return false
    }
    
    @objc func textFieldDidChange() {
        enableSignupButton()
    }
    
    func enableSignupButton() {
        let email = emailTextField.text!
       
        let isNameFieldEmpty = nameTextField.text?.isEmpty ?? true
        let isLastnameFieldEmpty = lastnameTextField.text?.isEmpty ?? true
        let isBirthDateFieldEmpty = birthDateTextField.text?.isEmpty ?? true
        let isEmailFieldEmpty = emailTextField.text?.isEmpty ?? true

        if !isNameFieldEmpty && !isLastnameFieldEmpty && !isBirthDateFieldEmpty && !isEmailFieldEmpty {
            if isValidEmail(email) {
                signupButton.isEnabled = true
                signupButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 219/255, alpha: 1)
                signupButton.setTitleColor(.white, for: .normal)
            }
        } else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
            signupButton.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1), for: .normal)
        }
        
     }
    
    func isValidEmail(_ email: String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

       let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailPred.evaluate(with: email)
   }
    
    @objc func signupButtonTapped() {
        let createPassVC = CreatePasswordViewController()
        createPassVC.modalPresentationStyle = .overFullScreen
        createPassVC.rootVCPassword = rootVCSplash
        navigationItem.title = ""
        navigationController?.show(createPassVC, sender: self)
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
