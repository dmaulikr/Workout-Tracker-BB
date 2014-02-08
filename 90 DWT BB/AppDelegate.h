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

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
