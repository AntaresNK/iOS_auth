//
//  SplashScreenViewController.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 03.10.2023.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    let rootVCSplash = "splashVC"
    
    
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
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 239/255, alpha: 1)
        button.tintColor = .white
        button.setTitle("Начать пользоваться", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(signupButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signinButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Есть аккаунт? Войти", for: .normal)
        button.setTitleColor(UIColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.addTarget(self, action: #selector(signinButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.customize()
        setupViews()
    }
    
    func setupViews() {
        setSigninButton()
        setSignupButton()
        setMotoLabel()
        setLogoImage()
    }
    
    func setLogoImage() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.bottom.equalTo(motoLabel.snp.top).offset(-60)
            make.centerX.equalToSuperview()
        }
    }
    
    func setMotoLabel() {
        view.addSubview(motoLabel)
        motoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(signupButton.snp.top).offset(-64)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func setSignupButton() {
        view.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.bottom.equalTo(signinButton.snp.top).offset(-16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
        }
    }
    
    func setSigninButton() {
        view.addSubview(signinButton)
        signinButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-44)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
        }
    }
    
    @objc func signupButtonTouched() {
        let signupVC = SignupViewController()
        signupVC.rootVCSignup = rootVCSplash
        signupVC.modalPresentationStyle = .overFullScreen
        navigationItem.title = ""
        navigationController?.show(signupVC, sender: self)
    }
    
    @objc func signinButtonTouched() {
        let signinVC = SigninViewController()
        signinVC.modalPresentationStyle = .overFullScreen
        navigationItem.title = ""
        navigationController?.show(signinVC, sender: self)
    }
    
}
