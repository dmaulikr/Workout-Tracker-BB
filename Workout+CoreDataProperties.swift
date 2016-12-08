//
//  Workout+CoreDataProperties.swift
//  90 DWT BB
//
//  Created by Grant, Jared on 10/5/16.
//  Copyright © 2016 Jared Grant. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Workout {

    @NSManaged var date: Date?
    @NSManaged var exercise: String?
    @NSManaged var exerciseCompleted: NSNumber?
    @NSManaged var index: NSNumber?
    @NSManaged var month: String?
    @NSManaged var notes: String?
    @NSManaged var photo: String?
    @NSManaged var reps: String?
    @NSManaged var round: NSNumber?
    @NSManaged var routine: String?
    @NSManaged var session: String?
    @NSManaged var week: String?
    @NSManaged var weekCompleted: NSNumber?
    @NSManaged var weight: String?
    @NSManaged var workout: String?

}
