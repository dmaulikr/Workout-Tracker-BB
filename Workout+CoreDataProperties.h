//
//  Workout+CoreDataProperties.h
//  90 DWT BB
//
//  Created by Grant, Jared on 12/22/15.
//  Copyright © 2015 Jared Grant. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Workout.h"

NS_ASSUME_NONNULL_BEGIN

@interface Workout (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *exercise;
@property (nullable, nonatomic, retain) NSNumber *exerciseCompleted;
@property (nullable, nonatomic, retain) NSNumber *index;
@property (nullable, nonatomic, retain) NSString *month;
@property (nullable, nonatomic, retain) NSString *notes;
@property (nullable, nonatomic, retain) NSString *photo;
@property (nullable, nonatomic, retain) NSString *reps;
@property (nullable, nonatomic, retain) NSNumber *round;
@property (nullable, nonatomic, retain) NSString *routine;
@property (nullable, nonatomic, retain) NSString *week;
@property (nullable, nonatomic, retain) NSNumber *weekCompleted;
@property (nullable, nonatomic, retain) NSString *weight;
@property (nullable, nonatomic, retain) NSString *workout;
@property (nullable, nonatomic, retain) NSString *session;

@end

NS_ASSUME_NONNULL_END
