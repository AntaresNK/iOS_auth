//
//  PopUpViewController.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 28.11.2023.
//

import UIKit

class PopUpViewController: UIViewController {
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor(red: 80/255, green: 85/255, blue: 92/255, alpha: 0.12).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 12
        view.layer.shadowOpacity = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let warningImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ring")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль успешно сброшен!"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupViews() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
        
        setupWarningLabel()
        setupWarningImage()
    }
    
    func setupWarningLabel() {
        backgroundView.addSubview(warningLabel)
        warningLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setupWarningImage() {
        backgroundView.addSubview(warningImage)
        warningImage.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.trailing.equalTo(warningLabel.snp.leading).inset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !backgroundView.frame.contains(location) {
            backgroundView.removeFromSuperview()
            let signinVC = SigninViewController()
            self.view.window?.rootViewController = UINavigationController(rootViewController: signinVC)
            self.view.window?.makeKeyAndVisible()
            navigationController?.pushViewController(signinVC, animated: true)
        }
    }
}
