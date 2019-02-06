//
//  PhotoLinksViewModel.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 5.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import Foundation

class PhotoLinksViewModel {
    private var dataSource = ["link1", "link2", "link3"]

    func getCount() -> Int {
        return dataSource.count
    }

    func getItemAt(index: Int) -> String {
        return dataSource[index]
    }
}
