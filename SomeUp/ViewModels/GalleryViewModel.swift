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

    private var currentUploadList = [Int]()

    private var queue = DispatchQueue(label: "imgure.upload.photo")
    private var dispatchGroup = DispatchGroup()

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

        let options = PHImageRequestOptions()
        options.isSynchronous = true

        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: options) { (image, info) in
            callback(image)
        }
    }

    func uploadImageWith(indexPath: IndexPath) {
        guard let currentImage = allPhotos?[indexPath.row], !isCurrentlyUploadingWith(index: indexPath.row) else {
            return
        }

        print("Start uploading")

        currentUploadList.append(indexPath.row)

        delegate?.didStartUploadingWith(indexPath: indexPath)


        queue.async { [weak self] in
            self?.dispatchGroup.wait()
            self?.dispatchGroup.enter()

            self?.extractImageFrom(asset: currentImage, size: PHImageManagerMaximumSize) { (image) in
                if let image = image {
                    print("Photo extracted")
                    NetworkManager.upload(image: image, completion: { [weak self] (error, imageUrl) in
                        // Save to DB
                        print("Finish uploading")
                        if let imageUrl = imageUrl {
                            DataManager.shared.add(item: imageUrl)
                        }

                        self?.removePhotoIndex(indexPath.row)
                        self?.delegate?.didFinishUploadingWith(error: error, indexPath: indexPath)
                        self?.dispatchGroup.leave()
                    })
                }
            }
        }
    }

    private func removePhotoIndex(_ index: Int) {

        currentUploadList = currentUploadList.filter { (current) -> Bool in
            return current != index
        }

    }

    func isCurrentlyUploadingWith(index: Int) -> Bool {
        for currentIndex in 0..<currentUploadList.count {
            if currentUploadList[currentIndex] == index {
                return true
            }
        }

        return false
    }
}
