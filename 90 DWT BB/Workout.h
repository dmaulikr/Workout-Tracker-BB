//
//  Workout.h
//  90 DWT BB
//
//  Created by Jared Grant on 3/14/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Workout : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * exercise;
@property (nonatomic, retain) NSNumber * exerciseCompleted;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * month;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSString * reps;
@property (nonatomic, retain) NSNumber * round;
@property (nonatomic, retain) NSString * routine;
@property (nonatomic, retain) NSString * week;
@property (nonatomic, retain) NSNumber * weekCompleted;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) NSString * workout;

@end
