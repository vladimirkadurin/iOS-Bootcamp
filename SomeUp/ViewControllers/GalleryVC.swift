//
//  GalleryVC.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 24.01.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import UIKit

class GalleryVC: UIViewController, GalleryPermissionHandler {

    let viewModel = GalleryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(handlePermission), name: NSNotification.Name(rawValue: Constants.NotificationNames.permissionNotification), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        handlePermission()
    }

    @objc func handlePermission() {
        handleGalleryPermission { [weak self] (authorized) in
            if authorized {
                self?.viewModel.fetchImages()
            }
        }
    }
}
