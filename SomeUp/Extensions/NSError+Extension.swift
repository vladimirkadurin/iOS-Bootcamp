//
//  NSError+Extension.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 5.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import Foundation

extension NSError {
    static func createUploadErrorWith(message: String, code: Int? = nil) -> NSError {
        return NSError(domain: "someup.imgur.upload", code: code ?? 400, userInfo: [NSLocalizedDescriptionKey: message])
    }

    static func defaultNetworkError() -> NSError {
        return NSError(domain: "someup.network.error", code: 400, userInfo: [NSLocalizedDescriptionKey: "Problem with the network request. Please try again."])
    }
}
