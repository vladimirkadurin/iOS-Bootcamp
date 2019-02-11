//
//  DataManager.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 7.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import Foundation

class DataManager {
    static let shared = DataManager()

    private var dataSource = [String]()

    var refreshValue = BindableObject([String]())

    func add(item: String) {
        dataSource.append(item)
        refreshValue.value = dataSource
    }

    func getCount() -> Int {
        return dataSource.count
    }

    func getItemAt(index: Int) -> String {
        return dataSource[index]
    }
}
