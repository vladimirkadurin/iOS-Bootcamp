//
//  GalleryPermissionHandler.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 24.01.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import Foundation
import Photos

protocol GalleryPermissionHandler where Self: UIViewController {

}

extension GalleryPermissionHandler {
    func handleGalleryPermission(callback: @escaping (Bool) -> ()) {
        let status = PHPhotoLibrary.authorizationStatus()

        switch status {
        case .authorized:
            callback(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] (status) in
                if status == .authorized {
                    callback(true)
                } else {
                    callback(false)
                    self?.showGalleryNotAccesiblePopup()
                }
            }
        case .denied, .restricted:
            callback(false)
            DispatchQueue.main.async { [weak self] in
                self?.showDeniedPermissionPopup()
            }
        }
    }

    private func showGalleryNotAccesiblePopup() {
        let alert = UIAlertController(title: "Warning", message: "Permission Denied. Can not get images from photo library", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }

    private func showDeniedPermissionPopup() {
        let alert = UIAlertController(title: "Warning", message: "Permission Denied. Please prooced to Settings", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { [weak self] (action) in
            self?.openSettings()
        }))

        present(alert, animated: true, completion: nil)
    }

    private func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(settingsUrl)
            }
        }
    }
}
