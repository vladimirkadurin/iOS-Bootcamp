//
//  PhotoLinksViewModel.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 5.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import Foundation

class PhotoLinksViewModel {

    func getCount() -> Int {
        return DataManager.shared.getCount()
    }

    func getItemAt(index: Int) -> String {
        return DataManager.shared.getItemAt(index: index)
    }
}
