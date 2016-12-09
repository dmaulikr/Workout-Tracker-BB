//
//  WorkoutCompleteDate+CoreDataProperties.swift
//  90 DWT BB
//
//  Created by Grant, Jared on 12/9/16.
//  Copyright © 2016 Jared Grant. All rights reserved.
//

import Foundation
import CoreData


extension WorkoutCompleteDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutCompleteDate> {
        return NSFetchRequest<WorkoutCompleteDate>(entityName: "WorkoutCompleteDate");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var index: NSNumber?
    @NSManaged public var routine: String?
    @NSManaged public var session: String?
    @NSManaged public var workout: String?
    @NSManaged public var workoutCompleted: NSNumber?

}
