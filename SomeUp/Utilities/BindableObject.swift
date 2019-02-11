//
//  BindableObject.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 7.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import Foundation

class BindableObject<T> {
    typealias Closure = (T?) -> ()

    private var closures = [Closure]()

    var value: T? {
        didSet {
            executeClosure(newValue: value)
        }
    }

    init(_ value: T?) {
        self.value = value
    }

    func executeClosure(newValue: T?) {
        _ = closures.map({$0(newValue)})
    }

    func bindAndFire(closure: Closure?) {
        if let closure = closure {
            closures.append(closure)
        }

        executeClosure(newValue: value)
    }
}
