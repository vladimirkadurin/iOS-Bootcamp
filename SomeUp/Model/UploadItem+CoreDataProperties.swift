//
//  UploadItem+CoreDataProperties.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 12.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//
//

import Foundation
import CoreData


extension UploadItem {

    @nonobjc public class func uploadItemFetchRequest() -> NSFetchRequest<UploadItem> {
        return NSFetchRequest<UploadItem>(entityName: "UploadItem")
    }

    @NSManaged public var link: String?
    @NSManaged public var createdAt: NSDate?

    class func createUploadItemWith(link: String?, managedObjectContext: NSManagedObjectContext?) {
        guard let link = link, let managedObjectContext = managedObjectContext else {
            return
        }

        guard let entityValue = NSEntityDescription.entity(forEntityName: "UploadItem", in: managedObjectContext) else {
            return
        }

        if let record = NSManagedObject(entity: entityValue, insertInto: managedObjectContext) as? UploadItem {
            record.link = link
            record.createdAt = Date() as NSDate

            do {
                try record.managedObjectContext?.save()
            } catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
            }
        }
    }
}
