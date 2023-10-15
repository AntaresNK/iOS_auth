//
//  ConfigureButton.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 04.10.2023.
//

import Foundation
import UIKit

extension UIButton {
    func configureButton() {
        self.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        self.layer.cornerRadius = 16
        self.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        self.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1), for: .normal)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
