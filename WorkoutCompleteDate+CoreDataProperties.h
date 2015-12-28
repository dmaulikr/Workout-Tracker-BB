//
//  WorkoutCompleteDate+CoreDataProperties.h
//  90 DWT BB
//
//  Created by Grant, Jared on 12/22/15.
//  Copyright © 2015 Jared Grant. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WorkoutCompleteDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkoutCompleteDate (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *index;
@property (nullable, nonatomic, retain) NSString *routine;
@property (nullable, nonatomic, retain) NSString *workout;
@property (nullable, nonatomic, retain) NSNumber *workoutCompleted;
@property (nullable, nonatomic, retain) NSString *session;

@end

NS_ASSUME_NONNULL_END
