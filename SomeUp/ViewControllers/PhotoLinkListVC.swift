//
//  PhotoLinkListVCViewController.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 5.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import UIKit
import CoreData

class PhotoLinkListVC: UIViewController {
    @IBOutlet weak var photoLinksTableView: UITableView!

    lazy var fetchedResultsController: NSFetchedResultsController<UploadItem> = {
        let fetchRequest = UploadItem.uploadItemFetchRequest()

        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let fetchRequestController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.shared.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)

        fetchRequestController.delegate = self

        return fetchRequestController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        photoLinksTableView.register(UINib(nibName: "\(PhotoLinkCell.self)", bundle: nil), forCellReuseIdentifier: "\(PhotoLinkCell.self)")

        photoLinksTableView.dataSource = self
        photoLinksTableView.delegate = self
    }
}

extension PhotoLinkListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO:
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?

        if let linkCell = tableView.dequeueReusableCell(withIdentifier: "\(PhotoLinkCell.self)", for: indexPath) as? PhotoLinkCell {
            // TODO:
            //linkCell.loadWith(data: viewModel.getItemAt(index: indexPath.row))
            cell = linkCell
        }

        return cell ?? UITableViewCell()
    }
}

extension PhotoLinkListVC: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        photoLinksTableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        photoLinksTableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = indexPath {
                photoLinksTableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                photoLinksTableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath, let linkCell = photoLinksTableView.cellForRow(at: indexPath) as? PhotoLinkCell {
                linkCell.loadWith(data: fetchedResultsController.object(at: indexPath))
            }
        case .move:
            if let indexPath = indexPath {
                photoLinksTableView.deleteRows(at: [indexPath], with: .fade)
            }

            if let newIndexPath = newIndexPath {
                photoLinksTableView.insertRows(at: [newIndexPath], with: .fade)
            }
        }

    }
}
