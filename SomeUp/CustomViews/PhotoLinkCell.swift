//
//  PhotoLinkCell.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 5.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import UIKit

class PhotoLinkCell: UITableViewCell {
    @IBOutlet weak var photoLinkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadWith(data: String) {
        photoLinkLabel.text = data
    }
}
