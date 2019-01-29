//
//  GalleryViewModel.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 24.01.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import Foundation
import Photos

class GalleryViewModel {
    private var allPhotos: PHFetchResult<PHAsset>?

    func fetchImages() {
        allPhotos = PHAsset.fetchAssets(with: .image, options: nil)
    }

    func getAssetCount() -> Int {
        return allPhotos?.countOfAssets(with: .image) ?? 0
    }

    func getAsset(index: Int) -> PHAsset? {
        return allPhotos?[index]
    }
}
