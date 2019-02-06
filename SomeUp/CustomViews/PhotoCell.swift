//
//  PhotoCell.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 29.01.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import UIKit
import Photos

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stopLoading()
    }

    func loadWith(image: UIImage?) {
        guard let image = image else { return }

        photoImageView.image = image
    }

    func startLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        photoImageView.alpha = 0.4
    }

    func stopLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        photoImageView.alpha = 1.0
    }
}
