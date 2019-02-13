//
//  AppDelegate+Extension.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 12.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import Foundation
import UIKit

extension UIApplicationDelegate {
    static var shared: Self {
        return UIApplication.shared.delegate! as! Self
    }
}
