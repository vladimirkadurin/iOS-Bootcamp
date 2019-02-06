//
//  UIViewController+Extension.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 5.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showPopupWith(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title ?? "Error", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}
