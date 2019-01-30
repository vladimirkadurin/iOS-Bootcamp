//
//  UICollectionView+Extension.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 29.01.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func setupBackgroundViewWith(delegate: EmptyPlaceholderProtocol) {
        let emptyPlaceholderView = EmptyPlaceholderView()
        emptyPlaceholderView.delegate = delegate
        self.backgroundView = emptyPlaceholderView
    }
}
