//
//  GalleryViewModel.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 24.01.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import Foundation
import Photos

protocol ImageUploadProtocol: class {
    func didStartUploadingWith(indexPath: IndexPath)
    func didFinishUploadingWith(error: NSError?, indexPath: IndexPath)
}

class GalleryViewModel {
    private var allPhotos: PHFetchResult<PHAsset>?

    weak var delegate: ImageUploadProtocol?

    func fetchImages() {
        allPhotos = PHAsset.fetchAssets(with: .image, options: nil)
    }

    func getAssetCount() -> Int {
        return allPhotos?.countOfAssets(with: .image) ?? 0
    }

    func getAsset(index: Int) -> PHAsset? {
        return allPhotos?[index]
    }

    func extractImageFrom(asset: PHAsset?, size: CGSize, callback: @escaping (UIImage?) -> ()) {
        guard let asset = asset else {
            callback(nil)
            return
        }

        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: nil) { (image, info) in
            callback(image)
        }
    }

    func uploadImageWith(indexPath: IndexPath) {
        guard let currentImage = allPhotos?[indexPath.row] else {
            return
        }

        delegate?.didStartUploadingWith(indexPath: indexPath)

        extractImageFrom(asset: currentImage, size: PHImageManagerMaximumSize) { (image) in
            if let image = image {
                NetworkManager.upload(image: image, completion: { [weak self] (error, imageUrl) in
                    // Save to DB
                    self?.delegate?.didFinishUploadingWith(error: error, indexPath: indexPath)
                })
            }
        }
    }
}
