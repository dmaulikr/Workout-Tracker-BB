//
//  WorkoutCompleteDate.h
//  90 DWT BB
//
//  Created by Grant, Jared on 3/25/15.
//  Copyright (c) 2015 Jared Grant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WorkoutCompleteDate : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * routine;
@property (nonatomic, retain) NSString * workout;
@property (nonatomic, retain) NSNumber * workoutCompleted;

@end
