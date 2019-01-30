//
//  EmptyPlaceholderView.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 29.01.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import UIKit

protocol EmptyPlaceholderProtocol: class {
    func emptyPlaceholderView(_ view: EmptyPlaceholderView, didTapOn: UIButton)
}

class EmptyPlaceholderView: UIView {
    @IBOutlet var contentView: UIView!

    weak var delegate: EmptyPlaceholderProtocol?

    override init(frame: CGRect) { // create form code
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) { // create from SB
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("\(EmptyPlaceholderView.self)", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    @IBAction func retryButtonTapped(_ sender: UIButton) {
        delegate?.emptyPlaceholderView(self, didTapOn: sender)
    }

}
