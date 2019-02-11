//
//  PhotoLinkListVCViewController.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 5.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import UIKit

class PhotoLinkListVC: UIViewController {
    @IBOutlet weak var photoLinksTableView: UITableView!

    let viewModel = PhotoLinksViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        photoLinksTableView.register(UINib(nibName: "\(PhotoLinkCell.self)", bundle: nil), forCellReuseIdentifier: "\(PhotoLinkCell.self)")

        photoLinksTableView.dataSource = self
        photoLinksTableView.delegate = self

        DataManager.shared.refreshValue.bindAndFire { (success) in
            
            DispatchQueue.main.async { [weak self] in
                self?.photoLinksTableView.reloadData()
            }
        }
    }
}

extension PhotoLinkListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?

        if let linkCell = tableView.dequeueReusableCell(withIdentifier: "\(PhotoLinkCell.self)", for: indexPath) as? PhotoLinkCell {
            linkCell.loadWith(data: viewModel.getItemAt(index: indexPath.row))
            cell = linkCell
        }

        return cell ?? UITableViewCell()
    }
}
