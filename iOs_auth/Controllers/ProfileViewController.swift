//
//  ProfileViewController.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 13.10.2023.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.configureTextField()
        textField.placeholder = "Имя"
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let lastnameTextField: UITextField = {
        let textField = UITextField()
        textField.configureTextField()
        textField.placeholder = "Фамилия"
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.configureTextField()
        textField.placeholder = "Дата рождения"
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.configureTextField()
        textField.placeholder = "Электронная почта"
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        button.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        birthDateTextField.delegate = self
        
        hideKeyboardWhenTappedAraound()
        setupViews()
        setSignupButton()
        
    }
    
    func setupViews() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        setTextFields()
    }
    
    func setTextFields() {
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(lastnameTextField)
        stackView.addArrangedSubview(birthDateTextField)
        stackView.addArrangedSubview(emailTextField)
    }
    
    func setSignupButton() {
        view.addSubview(signupButton)
        signupButton.isEnabled = false
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(44)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text ?? "") as NSString
        
        if string.isEmpty {
            return true
        }
        
        if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
            if currentText.length < 10 {
                switch currentText.length {
                case 2, 5:
                    textField.text = textField.text! + ".\(string)"
                case 10:
                    return false
                default:
                    textField.text = textField.text! + string
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
        present(createPassVC, animated: true)
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
