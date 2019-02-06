//
//  GalleryVC.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 24.01.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import UIKit

class GalleryVC: UIViewController, GalleryPermissionHandler {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    let viewModel = GalleryViewModel()

    let photoOffset: CGFloat = 10

    var currentIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(handlePermission), name: NSNotification.Name(rawValue: Constants.NotificationNames.permissionNotification), object: nil)

        photoCollectionView.register(UINib(nibName: "\(PhotoCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(PhotoCell.self)")
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.setupBackgroundViewWith(delegate: self)

        viewModel.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        handlePermission()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        photoCollectionView.reloadData()
    }

    @objc func handlePermission() {
        handleGalleryPermission { [weak self] (authorized) in
            if authorized {
                self?.viewModel.fetchImages()
                self?.photoCollectionView.reloadData()
            }
        }
    }
}

extension GalleryVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let assetCount = viewModel.getAssetCount()
        photoCollectionView.backgroundView?.isHidden = assetCount > 0
        return assetCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?

        if let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotoCell.self)", for: indexPath) as? PhotoCell {
            viewModel.extractImageFrom(asset: viewModel.getAsset(index: indexPath.row), size: photoCell.bounds.size) { (image) in
                photoCell.loadWith(image: image)
            }
            cell = photoCell
        }

        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.uploadImageWith(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var columnCount: CGFloat = 3
        if collectionView.bounds.size.width > collectionView.bounds.size.height {
            columnCount = 5
        }

        let cellDimension = (collectionView.bounds.size.width - ((columnCount - 1)*photoOffset))/columnCount
        return CGSize(width: cellDimension, height: cellDimension)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return photoOffset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return photoOffset
    }
}

extension GalleryVC: EmptyPlaceholderProtocol {
    func emptyPlaceholderView(_ view: EmptyPlaceholderView, didTapOn: UIButton) {
        handlePermission()
    }
}

extension GalleryVC: ImageUploadProtocol {
    func didStartUploadingWith(indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            if let currentCell = self?.photoCollectionView.cellForItem(at: indexPath) as? PhotoCell {
                currentCell.startLoading()
            }
        }
    }

    func didFinishUploadingWith(error: NSError?, indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            if let currentCell = self?.photoCollectionView.cellForItem(at: indexPath) as? PhotoCell {
                currentCell.stopLoading()
            }

            if let error = error {
                self?.showPopupWith(message: error.localizedDescription)
            }
        }
    }
}
