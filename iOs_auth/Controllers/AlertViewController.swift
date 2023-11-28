//
//  AlertViewController.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 12.10.2023.
//

import UIKit

class AlertViewController: UIViewController {
    var rootVCAlert = ""
    let rootVCSignup = "splashVC"
    let rootVCSignin = "signinVC"
    
    var emailLabel = ""
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        }()
    
    let alertLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 219/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 19/255, green: 19/255, blue: 19/255, alpha: 0.4)
        setupViews()
        hideKeyboardWhenTappedAraound()
    }
    
    func setupViews() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(343)
            make.centerY.equalToSuperview()
        }
        setCloseButton()
        setEmailLabel()
        setLogoImage()
    }
    
    func setLogoImage() {
        backgroundView.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.bottom.equalTo(alertLabel.snp.top).offset(-24)
            make.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
    }

    func setEmailLabel() {
        let emailLabelText = NSAttributedString(string: emailLabel, attributes: [
            .foregroundColor: UIColor(red: 93/255, green: 95/255, blue: 239/255, alpha: 1),
            .font: UIFont(name: "GothamPro-Medium", size: 18)
        ])

        let text = "На вашу почту \n«"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.append(emailLabelText)
        attributedText.append(NSAttributedString(string: "» было \n отправлено письмо"))
        alertLabel.attributedText = attributedText

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center

        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        alertLabel.attributedText = attributedText

        backgroundView.addSubview(alertLabel)
        alertLabel.snp.makeConstraints { make in
            make.bottom.equalTo(closeButton.snp.top).offset(-41)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    func setCloseButton() {
        backgroundView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    @objc func closeButtonTapped() {
        if rootVCAlert == rootVCSignup {
            let profileVC = ProfileViewController()
            profileVC.email = emailLabel
            profileVC.modalPresentationStyle = .fullScreen
            self.view.window?.rootViewController = UINavigationController(rootViewController: profileVC)
            self.view.window?.makeKeyAndVisible()
            
        } else if rootVCAlert == rootVCSignin {
            let createPassVC = CreatePasswordViewController()
            createPassVC.rootVCPassword = rootVCSignin
            createPassVC.modalPresentationStyle = .fullScreen
            self.view.window?.rootViewController = UINavigationController(rootViewController: createPassVC)
            self.view.window?.makeKeyAndVisible()
        }
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
