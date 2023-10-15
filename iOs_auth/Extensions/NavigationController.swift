//
//  NavigationController.swift
//  iOs_auth
//
//  Created by Nazym Sayakhmet on 13.10.2023.
//

import Foundation
import UIKit

extension UINavigationController {
    func customize() {
        self.navigationBar.backIndicatorImage = UIImage(named: "backIcon")
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backIcon")
        
        self.navigationBar.tintColor = UIColor(red: 101/255, green: 101/255, blue: 101/255, alpha: 1)

        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                .foregroundColor: UIColor(white: 0, alpha: 0)
            ],
            for: .normal
        )
    }
}
