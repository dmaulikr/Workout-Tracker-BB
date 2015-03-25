//
//  AppDelegate.m
//  90 DWT BB
//
//  Created by Jared Grant on 2/1/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "AppDelegate.h"
#import "90DWTBBIAPHelper.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // For In App Purchases - check to see if any transactions were purchased but not completed due to network loss or somethign similar.
    [_0DWTBBIAPHelper sharedInstance];
        
    //  Configure for iOS 7
    
    // style the navigation bar
    //UIColor* navColor = [UIColor colorWithRed:0.175f green:0.458f blue:0.831f alpha:1.0f];
    
    //UIColor *darkGrey = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f];
    
    UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
    
    [[UINavigationBar appearance] setBarTintColor:green];
    
    // make the status bar white
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    /*
     UIColor* navColor = [UIColor colorWithRed:0/255.0f green:167/255.0f blue:255/255.0f alpha:1.0f];
     [[UINavigationBar appearance] setBarTintColor:navColor];
     [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
     [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
     
     // make the status bar white
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
     //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
     
     //[[UITabBar appearance] setBarTintColor:navColor];
     [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
     [[UITabBar appearance] setBackgroundColor:[UIColor blackColor]];
     */
    
    [[UITabBar appearance] setTintColor: [UIColor orangeColor]];
    
    [UIViewController prepareInterstitialAds];
    
    [self loadArrays];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"_0_DWT_BB" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"_0_DWT_BB.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = @{
                              NSMigratePersistentStoresAutomaticallyOption : @YES,
                              NSInferMappingModelAutomaticallyOption : @YES
                              };
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)loadArrays {
    
    // Build
    self.build_Week1_WorkoutNameArray = @[@"B1: Chest+Tri",
                                          @"B1: Legs",
                                          @"B1: Back+Bi",
                                          @"B1: Shoulders",
                                          @"B3: Cardio",
                                          @"B3: Complete Body",
                                          @"B3: Ab Workout",
                                          @"Rest",
                                          @"B1: Chest+Tri",
                                          @"T1: Chest+Tri"];
    
    self.build_Week2_WorkoutNameArray = @[@"B1: Legs",
                                          @"B1: Back+Bi",
                                          @"T1: Back+Bi",
                                          @"B1: Shoulders",
                                          @"B3: Ab Workout",
                                          @"Rest",
                                          @"B1: Chest+Tri",
                                          @"T1: Chest+Tri",
                                          @"B1: Legs",
                                          @"B1: Back+Bi",
                                          @"T1: Back+Bi"];
    
    self.build_Week3_WorkoutNameArray = @[@"B1: Shoulders",
                                          @"B3: Ab Workout",
                                          @"Rest",
                                          @"B1: Chest+Tri",
                                          @"T1: Chest+Tri",
                                          @"B1: Legs",
                                          @"B1: Back+Bi",
                                          @"T1: Back+Bi",
                                          @"B1: Shoulders",
                                          @"B3: Ab Workout",
                                          @"B3: Cardio",
                                          @"B3: Complete Body",
                                          @"B3: Ab Workout"];
    
    self.build_Week4_WorkoutNameArray = @[@"B2: Chest",
                                          @"B2: Legs",
                                          @"B2: Back",
                                          @"B2: Arms",
                                          @"B3: Ab Workout",
                                          @"B2: Shoulders",
                                          @"Rest",
                                          @"B2: Chest"];
    
    self.build_Week5_WorkoutNameArray = @[@"B2: Legs",
                                          @"B2: Back",
                                          @"B2: Arms",
                                          @"B3: Ab Workout",
                                          @"B2: Shoulders",
                                          @"Rest",
                                          @"B2: Chest",
                                          @"B2: Legs"];
    
    self.build_Week6_WorkoutNameArray = @[@"B2: Back",
                                          @"B2: Arms",
                                          @"B3: Ab Workout",
                                          @"B2: Shoulders",
                                          @"Rest",
                                          @"B2: Chest",
                                          @"B2: Legs",
                                          @"B2: Back"];
    
    self.build_Week7_WorkoutNameArray = @[@"B2: Arms",
                                          @"B3: Ab Workout",
                                          @"B2: Shoulders",
                                          @"Rest",
                                          @"B2: Chest",
                                          @"B2: Legs",
                                          @"B2: Back",
                                          @"B2: Arms",
                                          @"B3: Ab Workout"];
    
    self.build_Week8_WorkoutNameArray = @[@"B2: Shoulders",
                                          @"Rest",
                                          @"B2: Chest",
                                          @"B2: Legs",
                                          @"B2: Back",
                                          @"B2: Arms",
                                          @"B3: Ab Workout",
                                          @"B2: Shoulders"];
    
    self.build_Week9_WorkoutNameArray = @[@"Rest",
                                          @"B2: Chest",
                                          @"B2: Legs",
                                          @"B2: Back",
                                          @"B2: Arms",
                                          @"B3: Ab Workout",
                                          @"B2: Shoulders",
                                          @"Rest"];
    
    self.build_Week10_WorkoutNameArray = @[@"B1: Chest+Tri",
                                           @"T1: Chest+Tri",
                                           @"B2: Legs",
                                           @"B1: Back+Bi",
                                           @"T1: Back+Bi",
                                           @"B3: Cardio",
                                           @"B3: Ab Workout",
                                           @"Rest",
                                           @"B2: Arms",
                                           @"B1: Shoulders"];
    
    self.build_Week11_WorkoutNameArray = @[@"B2: Chest",
                                           @"B1: Legs",
                                           @"B3: Cardio",
                                           @"B3: Complete Body",
                                           @"B3: Ab Workout",
                                           @"Rest",
                                           @"B2: Back",
                                           @"B2: Arms",
                                           @"B3: Ab Workout",
                                           @"B3: Cardio"];
    
    self.build_Week12_WorkoutNameArray = @[@"B1: Chest+Tri",
                                           @"T1: Chest+Tri",
                                           @"B2: Legs",
                                           @"B3: Cardio",
                                           @"B3: Ab Workout",
                                           @"Rest",
                                           @"B1: Back+Bi",
                                           @"T1: Back+Bi",
                                           @"B2: Shoulders",
                                           @"B3: Cardio",
                                           @"B3: Complete Body",
                                           @"B3: Ab Workout"];
    
    self.build_WorkoutNameArray = @[self.build_Week1_WorkoutNameArray,
                                    self.build_Week2_WorkoutNameArray,
                                    self.build_Week3_WorkoutNameArray,
                                    self.build_Week4_WorkoutNameArray,
                                    self.build_Week5_WorkoutNameArray,
                                    self.build_Week6_WorkoutNameArray,
                                    self.build_Week7_WorkoutNameArray,
                                    self.build_Week8_WorkoutNameArray,
                                    self.build_Week9_WorkoutNameArray,
                                    self.build_Week10_WorkoutNameArray,
                                    self.build_Week11_WorkoutNameArray,
                                    self.build_Week12_WorkoutNameArray];
    
    
    
    // Tone
    self.tone_Week1_WorkoutNameArray = @[@"B1: Chest+Tri",
                                         @"B1: Legs",
                                         @"B1: Back+Bi",
                                         @"B3: Cardio",
                                         @"B3: Ab Workout",
                                         @"B1: Shoulders",
                                         @"Rest",
                                         @"B1: Chest+Tri",
                                         @"T1: Chest+Tri"];
    
    self.tone_Week2_WorkoutNameArray = @[@"B1: Legs",
                                         @"B1: Back+Bi",
                                         @"T1: Back+Bi",
                                         @"B3: Cardio",
                                         @"B3: Ab Workout",
                                         @"B1: Shoulders",
                                         @"Rest",
                                         @"B1: Chest+Tri",
                                         @"T1: Chest+Tri",
                                         @"B1: Legs"];
    
    self.tone_Week3_WorkoutNameArray = @[@"B1: Back+Bi",
                                         @"T1: Back+Bi",
                                         @"B3: Cardio",
                                         @"B3: Ab Workout",
                                         @"B1: Shoulders",
                                         @"Rest",
                                         @"B1: Chest+Tri",
                                         @"T1: Chest+Tri",
                                         @"B1: Legs",
                                         @"B1: Back+Bi",
                                         @"T1: Back+Bi"];
    
    self.tone_Week4_WorkoutNameArray = @[@"B2: Chest",
                                         @"B2: Legs",
                                         @"B2: Arms",
                                         @"B3: Cardio",
                                         @"B3: Ab Workout",
                                         @"B2: Back",
                                         @"B2: Shoulders",
                                         @"Rest"];
    
    self.tone_Week5_WorkoutNameArray = @[@"B2: Chest",
                                         @"B2: Legs",
                                         @"B2: Arms",
                                         @"B3: Cardio",
                                         @"B3: Ab Workout",
                                         @"B2: Back",
                                         @"B2: Shoulders",
                                         @"Rest"];
    
    self.tone_Week6_WorkoutNameArray = @[@"B2: Chest",
                                         @"B2: Legs",
                                         @"B2: Arms",
                                         @"B3: Cardio",
                                         @"B3: Ab Workout",
                                         @"B2: Back",
                                         @"B2: Shoulders",
                                         @"Rest"];
    
    self.tone_Week7_WorkoutNameArray = @[@"B2: Chest",
                                         @"B2: Legs",
                                         @"B2: Arms",
                                         @"B3: Cardio",
                                         @"B3: Ab Workout",
                                         @"B2: Back",
                                         @"B2: Shoulders",
                                         @"Rest"];
    
    self.tone_Week8_WorkoutNameArray = @[@"B2: Chest",
                                         @"B2: Legs",
                                         @"B2: Arms",
                                         @"B3: Cardio",
                                         @"B3: Ab Workout",
                                         @"B2: Back",
                                         @"B2: Shoulders",
                                         @"Rest"];
    
    self.tone_Week9_WorkoutNameArray = @[@"B1: Chest+Tri",
                                         @"T1: Chest+Tri",
                                         @"B2: Legs",
                                         @"B1: Back+Bi",
                                         @"T1: Back+Bi",
                                         @"B3: Cardio",
                                         @"B3: Ab Workout",
                                         @"B1: Shoulders",
                                         @"Rest",
                                         @"B3: Cardio",
                                         @"B3: Complete Body",
                                         @"B3: Ab Workout"];
    
    self.tone_Week10_WorkoutNameArray = @[@"B2: Chest",
                                          @"B1: Legs",
                                          @"B2: Shoulders",
                                          @"B2: Back",
                                          @"B2: Arms",
                                          @"B3: Cardio",
                                          @"B3: Ab Workout",
                                          @"Rest"];
    
    self.tone_Week11_WorkoutNameArray = @[@"B1: Chest+Tri",
                                          @"T1: Chest+Tri",
                                          @"B2: Legs",
                                          @"B1: Back+Bi",
                                          @"T1: Back+Bi",
                                          @"B3: Cardio",
                                          @"B3: Ab Workout",
                                          @"B1: Shoulders",
                                          @"Rest",
                                          @"B3: Cardio",
                                          @"B3: Complete Body",
                                          @"B3: Ab Workout"];
    
    self.tone_Week12_WorkoutNameArray = @[@"B2: Chest",
                                          @"B1: Legs",
                                          @"B2: Shoulders",
                                          @"B2: Back",
                                          @"B2: Arms",
                                          @"B3: Cardio",
                                          @"B3: Ab Workout",
                                          @"Rest"];
    
    self.tone_WorkoutNameArray = @[self.tone_Week1_WorkoutNameArray,
                                   self.tone_Week2_WorkoutNameArray,
                                   self.tone_Week3_WorkoutNameArray,
                                   self.tone_Week4_WorkoutNameArray,
                                   self.tone_Week5_WorkoutNameArray,
                                   self.tone_Week6_WorkoutNameArray,
                                   self.tone_Week7_WorkoutNameArray,
                                   self.tone_Week8_WorkoutNameArray,
                                   self.tone_Week9_WorkoutNameArray,
                                   self.tone_Week10_WorkoutNameArray,
                                   self.tone_Week11_WorkoutNameArray,
                                   self.tone_Week12_WorkoutNameArray];
    
    
    
    self.build_Week1_WorkoutIndexArray = @[@1,
                                           @1,
                                           @1,
                                           @1,
                                           @1,
                                           @1,
                                           @1,
                                           @1,
                                           @2,
                                           @1];
    
    self.build_Week2_WorkoutIndexArray = @[@2,
                                           @2,
                                           @1,
                                           @2,
                                           @2,
                                           @2,
                                           @3,
                                           @2,
                                           @3,
                                           @3,
                                           @2];
    
    self.build_Week3_WorkoutIndexArray = @[@3,
                                           @3,
                                           @3,
                                           @4,
                                           @3,
                                           @4,
                                           @4,
                                           @3,
                                           @4,
                                           @4,
                                           @2,
                                           @2,
                                           @5];
    
    self.build_Week4_WorkoutIndexArray = @[@1,
                                           @1,
                                           @1,
                                           @1,
                                           @6,
                                           @1,
                                           @4,
                                           @2];
    
    self.build_Week5_WorkoutIndexArray = @[@2,
                                           @2,
                                           @2,
                                           @7,
                                           @2,
                                           @5,
                                           @3,
                                           @3];
    
    self.build_Week6_WorkoutIndexArray = @[@3,
                                           @3,
                                           @8,
                                           @3,
                                           @6,
                                           @4,
                                           @4,
                                           @4];
    
    self.build_Week7_WorkoutIndexArray = @[@4,
                                           @9,
                                           @4,
                                           @7,
                                           @5,
                                           @5,
                                           @5,
                                           @5,
                                           @10];
    
    self.build_Week8_WorkoutIndexArray = @[@5,
                                           @8,
                                           @6,
                                           @6,
                                           @6,
                                           @6,
                                           @11,
                                           @6];
    
    self.build_Week9_WorkoutIndexArray = @[@9,
                                           @7,
                                           @7,
                                           @7,
                                           @7,
                                           @12,
                                           @7,
                                           @10];
    
    self.build_Week10_WorkoutIndexArray = @[@5,
                                            @4,
                                            @8,
                                            @5,
                                            @4,
                                            @3,
                                            @13,
                                            @11,
                                            @8,
                                            @5];
    
    self.build_Week11_WorkoutIndexArray = @[@8,
                                            @5,
                                            @4,
                                            @3,
                                            @14,
                                            @12,
                                            @8,
                                            @9,
                                            @15,
                                            @5];
    
    self.build_Week12_WorkoutIndexArray = @[@6,
                                            @5,
                                            @9,
                                            @6,
                                            @16,
                                            @13,
                                            @6,
                                            @5,
                                            @8,
                                            @7,
                                            @4,
                                            @17];
    
    self.build_WorkoutIndexArray = @[self.build_Week1_WorkoutIndexArray,
                                     self.build_Week2_WorkoutIndexArray,
                                     self.build_Week3_WorkoutIndexArray,
                                     self.build_Week4_WorkoutIndexArray,
                                     self.build_Week5_WorkoutIndexArray,
                                     self.build_Week6_WorkoutIndexArray,
                                     self.build_Week7_WorkoutIndexArray,
                                     self.build_Week8_WorkoutIndexArray,
                                     self.build_Week9_WorkoutIndexArray,
                                     self.build_Week10_WorkoutIndexArray,
                                     self.build_Week11_WorkoutIndexArray,
                                     self.build_Week12_WorkoutIndexArray,];
    
    
    
    self.tone_Week1_WorkoutIndexArray = @[@1,
                                          @1,
                                          @1,
                                          @1,
                                          @1,
                                          @1,
                                          @1,
                                          @2,
                                          @1];
    
    self.tone_Week2_WorkoutIndexArray = @[@2,
                                          @2,
                                          @1,
                                          @2,
                                          @2,
                                          @2,
                                          @2,
                                          @3,
                                          @2,
                                          @3];
    
    self.tone_Week3_WorkoutIndexArray = @[@3,
                                          @2,
                                          @3,
                                          @3,
                                          @3,
                                          @3,
                                          @4,
                                          @3,
                                          @4,
                                          @4,
                                          @3];
    
    self.tone_Week4_WorkoutIndexArray = @[@1,
                                          @1,
                                          @1,
                                          @4,
                                          @4,
                                          @1,
                                          @1,
                                          @4];
    
    self.tone_Week5_WorkoutIndexArray = @[@2,
                                          @2,
                                          @2,
                                          @5,
                                          @5,
                                          @2,
                                          @2,
                                          @5];
    
    self.tone_Week6_WorkoutIndexArray = @[@3,
                                          @3,
                                          @3,
                                          @6,
                                          @6,
                                          @3,
                                          @3,
                                          @6];
    
    self.tone_Week7_WorkoutIndexArray = @[@4,
                                          @4,
                                          @4,
                                          @7,
                                          @7,
                                          @4,
                                          @4,
                                          @7];
    
    self.tone_Week8_WorkoutIndexArray = @[@5,
                                          @5,
                                          @5,
                                          @8,
                                          @8,
                                          @5,
                                          @5,
                                          @8];
    
    self.tone_Week9_WorkoutIndexArray = @[@5,
                                          @4,
                                          @6,
                                          @5,
                                          @4,
                                          @9,
                                          @9,
                                          @4,
                                          @9,
                                          @10,
                                          @1,
                                          @10];
    
    self.tone_Week10_WorkoutIndexArray = @[@6,
                                           @5,
                                           @6,
                                           @6,
                                           @6,
                                           @11,
                                           @11,
                                           @10];
    
    self.tone_Week11_WorkoutIndexArray = @[@6,
                                           @5,
                                           @7,
                                           @6,
                                           @5,
                                           @12,
                                           @12,
                                           @5,
                                           @11,
                                           @13,
                                           @2,
                                           @13];
    
    self.tone_Week12_WorkoutIndexArray = @[@7,
                                           @6,
                                           @7,
                                           @7,
                                           @7,
                                           @14,
                                           @14,
                                           @12];
    
    self.tone_WorkoutIndexArray = @[self.tone_Week1_WorkoutIndexArray,
                                    self.tone_Week2_WorkoutIndexArray,
                                    self.tone_Week3_WorkoutIndexArray,
                                    self.tone_Week4_WorkoutIndexArray,
                                    self.tone_Week5_WorkoutIndexArray,
                                    self.tone_Week6_WorkoutIndexArray,
                                    self.tone_Week7_WorkoutIndexArray,
                                    self.tone_Week8_WorkoutIndexArray,
                                    self.tone_Week9_WorkoutIndexArray,
                                    self.tone_Week10_WorkoutIndexArray,
                                    self.tone_Week11_WorkoutIndexArray,
                                    self.tone_Week12_WorkoutIndexArray,];
}

@end
