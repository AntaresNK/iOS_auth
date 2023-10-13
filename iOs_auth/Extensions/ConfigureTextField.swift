//
//  configureTextField.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 04.10.2023.
//

import Foundation
import UIKit

//class TextFieldDelegate: NSObject, UITextFieldDelegate {
//    weak var placeholderLabel: UILabel?
//    
//    init(placeholderLabel: UILabel) {
//        self.placeholderLabel = placeholderLabel
//    }
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.3) {
//            self.placeholderLabel?.transform = CGAffineTransform(translationX: 0, y: -20)
//            self.placeholderLabel?.font = UIFont.systemFont(ofSize: 12)
//        }
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//      
//        UIView.animate(withDuration: 0.3) {
//            self.placeholderLabel?.transform = CGAffineTransform.identity
//            self.placeholderLabel?.font = UIFont.systemFont(ofSize: 17)
//        }
//    }
//}



extension UITextField {
    func configureTextField() {
        self.font = UIFont(name: "GothamPro-Medium", size: 16)
        self.textAlignment = .left
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = 8
        self.layer.borderColor = CGColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 22))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
}
