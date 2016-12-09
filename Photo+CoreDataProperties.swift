//
//  Photo+CoreDataProperties.swift
//  90 DWT BB
//
//  Created by Grant, Jared on 12/9/16.
//  Copyright © 2016 Jared Grant. All rights reserved.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo");
    }

    @NSManaged public var angle: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var image: NSData?
    @NSManaged public var month: String?
    @NSManaged public var session: String?

}
