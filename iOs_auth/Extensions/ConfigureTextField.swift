//
//  configureTextField.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 04.10.2023.
//

import Foundation
import UIKit

class TextFieldDelegate: UITextField {
    
    var placeholderLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
        
    required init?(coder: NSCoder){
        super.init(coder: coder)
        configureTextField()
    }
    
    @objc dynamic func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            UIView.animate(withDuration: 0.3) {
                self.placeholderLabel.frame.origin = CGPoint(x: 16, y: 5)
                self.placeholderLabel.font = UIFont(name: "GothamPro", size: 12)
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.placeholderLabel.frame.origin = CGPoint(x: 16, y: 22)
                self.placeholderLabel.font = UIFont(name: "GothamPro", size: 16)
                self.configureTextField()
            }
        }
    }
    
    func textFieldHasText() {
        UIView.animate(withDuration: 0.1) {
            self.placeholderLabel.frame.origin = CGPoint(x: 16, y: 5)
            self.placeholderLabel.font = UIFont(name: "GothamPro", size: 12)
        }
    }
    
    func configurePlaceholder() {
        placeholderLabel.font = UIFont(name: "GothamPro", size: 16)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.frame.origin = CGPoint(x: 16, y: 22)
        placeholderLabel.sizeToFit()
        addSubview(placeholderLabel)
    }
    
    func setPlaceholderText(text: String) {
        self.placeholderLabel.text = text
        configurePlaceholder()
    }
    
    func configureTextField() {
        self.font = UIFont(name: "GothamPro-Medium", size: 16)
        self.textAlignment = .left
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = 8
        self.layer.borderColor = CGColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        self.textColor = .black
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 22))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        configurePlaceholder()
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
}

class BirthDateTextField: TextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTextField()
    }
    
    override func configureTextField() {
        super.configureTextField()
        self.keyboardType = .numbersAndPunctuation
        
        addTarget(self, action: #selector(birthDateTextFieldDidChange), for: .editingChanged)
    }
    
    @objc func birthDateTextFieldDidChange() {
        if var text = self.text {
            text = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            
            if text.count > 8 {
                text = String(text.prefix(8))
            }
            
            if text.count > 2 && text.index(text.startIndex, offsetBy: 2) != text.index(text.startIndex, offsetBy: 3) {
                text.insert(".", at: text.index(text.startIndex, offsetBy: 2))
            }
            
            if text.count > 5 && text.index(text.startIndex, offsetBy: 5) != text.index(text.startIndex, offsetBy: 6) {
                text.insert(".", at: text.index(text.startIndex, offsetBy: 5))
            }
            self.text = text
        }
    }
}
