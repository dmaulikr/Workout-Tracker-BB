//
//  Routine+CoreDataProperties.swift
//  90 DWT BB
//
//  Created by Grant, Jared on 12/9/16.
//  Copyright © 2016 Jared Grant. All rights reserved.
//

import Foundation
import CoreData


extension Routine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Routine> {
        return NSFetchRequest<Routine>(entityName: "Routine");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var defaultRoutine: String?

}
