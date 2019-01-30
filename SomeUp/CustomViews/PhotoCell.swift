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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadWith(image: UIImage?) {
        guard let image = image else { return }

        photoImageView.image = image
    }
}
