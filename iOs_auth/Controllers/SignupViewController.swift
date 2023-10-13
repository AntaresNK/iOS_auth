//
//  ViewController.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 30.09.2023.
//

import UIKit
import SnapKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    var email = ""
    
    let navigationBar: UINavigationBar = {
        let backButton = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .plain, target: self, action: #selector(backButtonTouched))
        
        let navigationBar = UINavigationBar()
        navigationBar.setItems([UINavigationItem(title: "Регистрация")], animated: false)
        navigationBar.topItem?.setLeftBarButton(backButton, animated: false)
        navigationBar.backgroundColor = nil
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    let logoImage: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "logo")
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
    
    let motoLabel: UILabel = {
        let label = UILabel()
        let text = "Смейся \nи улыбайся \nкаждый день"
        label.font = UIFont(name: "GothamPro-Medium", size: 40)
        label.textColor = UIColor(red: 93/255, green: 95/255, blue: 239/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.configureTextField()
        textField.placeholder = "Электронная почта"
        let placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.systemFont(ofSize: 17)
        placeholderLabel.textColor = UIColor.lightGray
        textField.addSubview(placeholderLabel)
        textField.addTarget(self, action: #selector(emailTyped), for: .allEditingEvents)
        return textField
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Данная почта уже зарегистривана"
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
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        button.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    func setupViews() {
        hideKeyboardWhenTappedAraound()
        setNavigationView()
        setLogoImage()
        setMotoLabel()
        setEmailTextField()
        setWarningLabel()
        setNextButton()
        }
        
    
    func setNavigationView() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
        }
    }
    
    func setLogoImage() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(13)
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(80)
        }
    }
    
    func setMotoLabel() {
        view.addSubview(motoLabel)
        motoLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func setEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(motoLabel.snp.bottom).offset(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    
    func setWarningLabel() {
        view.addSubview(warningLabel)
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(emailTextField)
        }
    }
    
    func setNextButton() {
        nextButton.isEnabled = false
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(emailTextField.snp.bottom).offset(60)
        }
    }
    
   @objc func emailTyped() {
        email = emailTextField.text!
        
        if email.isEmpty {
            return
        }
        
        if isValidEmail(email) {
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 219/255, alpha: 1)
            nextButton.setTitleColor(.white, for: .normal)
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
            nextButton.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1), for: .normal)
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

       let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailPred.evaluate(with: email)
   }
    
    @objc func nextButtonTapped() {
        if nextButton.isEnabled {
            let alertVC = AlertViewController()
            alertVC.emailLabel = email
            alertVC.modalPresentationStyle = .overFullScreen
            present(alertVC, animated: true)
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

