//
//  AppDelegate.h
//  90 DWT BB
//
//  Created by Jared Grant on 2/1/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSString *month;          // Current month.
@property (strong, nonatomic) NSString *routine;        // Current workout routine (Normal, 2-A-Days, or Tone).
@property (strong, nonatomic) NSString *week;           // Current week of workout.
@property (strong, nonatomic) NSString *workout;        // Full name of an individual workout.
@property (strong, nonatomic) NSNumber *index;          // The number of times this workout has been done.
@property (strong, nonatomic) NSString *exerciseName;   // Full name of an individual exercise.
@property (strong, nonatomic) NSString *exerciseRound;  // Round of an individual exercise (1 or 2).

@property (strong, nonatomic) NSString *graphRoutine;
@property (strong, nonatomic) NSString *graphWorkout;
@property (strong, nonatomic) NSString *graphTitle;     // Name of exercise that will be used for the graph.
@property (strong, nonatomic) NSMutableArray *graphDataPoints;

@property (strong, nonatomic) NSArray *build_WorkoutNameArray;
@property (strong, nonatomic) NSArray *tone_WorkoutNameArray;

@property (strong, nonatomic) NSArray *build_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *tone_WorkoutIndexArray;

// Build Weeks
// Month 1
@property (strong, nonatomic) NSArray *build_Week1_WorkoutNameArray;
@property (strong, nonatomic) NSArray *build_Week2_WorkoutNameArray;
@property (strong, nonatomic) NSArray *build_Week3_WorkoutNameArray;

@property (strong, nonatomic) NSArray *build_Week1_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *build_Week2_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *build_Week3_WorkoutIndexArray;

// Month 2
@property (strong, nonatomic) NSArray *build_Week4_WorkoutNameArray;
@property (strong, nonatomic) NSArray *build_Week5_WorkoutNameArray;
@property (strong, nonatomic) NSArray *build_Week6_WorkoutNameArray;
@property (strong, nonatomic) NSArray *build_Week7_WorkoutNameArray;
@property (strong, nonatomic) NSArray *build_Week8_WorkoutNameArray;
@property (strong, nonatomic) NSArray *build_Week9_WorkoutNameArray;

@property (strong, nonatomic) NSArray *build_Week4_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *build_Week5_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *build_Week6_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *build_Week7_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *build_Week8_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *build_Week9_WorkoutIndexArray;

// Month 3
@property (strong, nonatomic) NSArray *build_Week10_WorkoutNameArray;
@property (strong, nonatomic) NSArray *build_Week11_WorkoutNameArray;
@property (strong, nonatomic) NSArray *build_Week12_WorkoutNameArray;

@property (strong, nonatomic) NSArray *build_Week10_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *build_Week11_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *build_Week12_WorkoutIndexArray;

// Tone Weeks
// Month 1
@property (strong, nonatomic) NSArray *tone_Week1_WorkoutNameArray;
@property (strong, nonatomic) NSArray *tone_Week2_WorkoutNameArray;
@property (strong, nonatomic) NSArray *tone_Week3_WorkoutNameArray;

@property (strong, nonatomic) NSArray *tone_Week1_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *tone_Week2_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *tone_Week3_WorkoutIndexArray;

// Month 2
@property (strong, nonatomic) NSArray *tone_Week4_WorkoutNameArray;
@property (strong, nonatomic) NSArray *tone_Week5_WorkoutNameArray;
@property (strong, nonatomic) NSArray *tone_Week6_WorkoutNameArray;
@property (strong, nonatomic) NSArray *tone_Week7_WorkoutNameArray;
@property (strong, nonatomic) NSArray *tone_Week8_WorkoutNameArray;

@property (strong, nonatomic) NSArray *tone_Week4_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *tone_Week5_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *tone_Week6_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *tone_Week7_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *tone_Week8_WorkoutIndexArray;

// Month 3
@property (strong, nonatomic) NSArray *tone_Week9_WorkoutNameArray;
@property (strong, nonatomic) NSArray *tone_Week10_WorkoutNameArray;
@property (strong, nonatomic) NSArray *tone_Week11_WorkoutNameArray;
@property (strong, nonatomic) NSArray *tone_Week12_WorkoutNameArray;

@property (strong, nonatomic) NSArray *tone_Week9_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *tone_Week10_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *tone_Week11_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *tone_Week12_WorkoutIndexArray;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
