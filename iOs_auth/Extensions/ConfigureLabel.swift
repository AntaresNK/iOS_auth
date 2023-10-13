//
//  ConfigureLabel.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 13.10.2023.
//

import Foundation
import UIKit

extension UILabel {
    func configureLabel() {
        self.font = UIFont(name: "GothamPro-Medium", size: 16)
        self.textAlignment = .left
        self.textColor = .lightGray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
