//
//  AppDelegate.m
//  90 DWT BB
//
//  Created by Jared Grant on 2/1/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "AppDelegate.h"
#import "90DWTBBIAPHelper.h"
#import "CoreDataHelper.h"
#import "Workout.h"
#import "MainTBC.h"

@implementation AppDelegate

#define debug 0

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // For In App Purchases - check to see if any transactions were purchased but not completed due to network loss or somethign similar.
    [_0DWTBBIAPHelper sharedInstance];
    
    UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
    
    [[UINavigationBar appearance] setBarTintColor:green];
    
    // make the status bar white
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [[UITabBar appearance] setTintColor: [UIColor orangeColor]];
    
    //[UIViewController prepareInterstitialAds];
    
    if ([[_0DWTBBIAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWTBB.removeads"]) {
        
        self.purchasedAdRemoveBeforeAppLaunch = YES;
    }
    
    [[ CoreDataHelper sharedHelper] iCloudAccountIsSignedIn];

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
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    [[ CoreDataHelper sharedHelper] backgroundSaveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    [[ CoreDataHelper sharedHelper] ensureAppropriateStoreIsLoaded];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    //[self saveContext];
    [[ CoreDataHelper sharedHelper] backgroundSaveContext];
}

- (NSString *)getCurrentSession {
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    
    // Fetch current session data.
    NSEntityDescription *entityDescSession = [NSEntityDescription entityForName:@"Session" inManagedObjectContext:context];
    NSFetchRequest *requestSession = [[NSFetchRequest alloc] init];
    [requestSession setEntity:entityDescSession];
    
    NSManagedObject *matches = nil;
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:requestSession error:&error];
    NSString *currentSessionString;
    
    if ([objects count] == 0) {
        
        // No matches.
        currentSessionString = @"1";
    }
    
    else {
        
        // Multiple session matches.
        matches = objects[[objects count] - 1];
        
        currentSessionString = [matches valueForKey:@"currentSession"];
    }
    
    return currentSessionString;
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
                                           @"B3: Complete Body",// Added
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
                                           @"B3: Cardio",
                                           @"B3: Complete Body"];// Added
    
    self.build_Week12_WorkoutNameArray = @[@"B1: Chest+Tri",
                                           @"T1: Chest+Tri",
                                           @"B2: Legs",
                                           @"B3: Cardio",
                                           @"B3: Complete Body",// Added
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
                                         @"B3: Complete Body",// Added
                                         @"B3: Ab Workout",
                                         @"B1: Shoulders",
                                         @"Rest",
                                         @"B1: Chest+Tri",
                                         @"T1: Chest+Tri"];
    
    self.tone_Week2_WorkoutNameArray = @[@"B1: Legs",
                                         @"B1: Back+Bi",
                                         @"T1: Back+Bi",
                                         @"B3: Cardio",
                                         @"B3: Complete Body",// Added
                                         @"B3: Ab Workout",
                                         @"B1: Shoulders",
                                         @"Rest",
                                         @"B1: Chest+Tri",
                                         @"T1: Chest+Tri",
                                         @"B1: Legs"];
    
    self.tone_Week3_WorkoutNameArray = @[@"B1: Back+Bi",
                                         @"T1: Back+Bi",
                                         @"B3: Cardio",
                                         @"B3: Complete Body",// Added
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
                                         @"B3: Complete Body",// Added
                                         @"B3: Ab Workout",
                                         @"B2: Back",
                                         @"B2: Shoulders",
                                         @"Rest"];
    
    self.tone_Week5_WorkoutNameArray = @[@"B2: Chest",
                                         @"B2: Legs",
                                         @"B2: Arms",
                                         @"B3: Cardio",
                                         @"B3: Complete Body",// Added
                                         @"B3: Ab Workout",
                                         @"B2: Back",
                                         @"B2: Shoulders",
                                         @"Rest"];
    
    self.tone_Week6_WorkoutNameArray = @[@"B2: Chest",
                                         @"B2: Legs",
                                         @"B2: Arms",
                                         @"B3: Cardio",
                                         @"B3: Complete Body",// Added
                                         @"B3: Ab Workout",
                                         @"B2: Back",
                                         @"B2: Shoulders",
                                         @"Rest"];
    
    self.tone_Week7_WorkoutNameArray = @[@"B2: Chest",
                                         @"B2: Legs",
                                         @"B2: Arms",
                                         @"B3: Cardio",
                                         @"B3: Complete Body",// Added
                                         @"B3: Ab Workout",
                                         @"B2: Back",
                                         @"B2: Shoulders",
                                         @"Rest"];
    
    self.tone_Week8_WorkoutNameArray = @[@"B2: Chest",
                                         @"B2: Legs",
                                         @"B2: Arms",
                                         @"B3: Cardio",
                                         @"B3: Complete Body",// Added
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
                                         @"B3: Complete Body",// Added
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
                                          @"B3: Complete Body",// Added
                                          @"B3: Ab Workout",
                                          @"Rest"];
    
    self.tone_Week11_WorkoutNameArray = @[@"B1: Chest+Tri",
                                          @"T1: Chest+Tri",
                                          @"B2: Legs",
                                          @"B1: Back+Bi",
                                          @"T1: Back+Bi",
                                          @"B3: Cardio",
                                          @"B3: Complete Body",// Added
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
                                          @"B3: Complete Body",// Added
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
                                            @3,
                                            @13,
                                            @11,
                                            @8,
                                            @5];
    
    self.build_Week11_WorkoutIndexArray = @[@8,
                                            @5,
                                            @4,
                                            @4,
                                            @14,
                                            @12,
                                            @8,
                                            @9,
                                            @15,
                                            @5,
                                            @5];
    
    self.build_Week12_WorkoutIndexArray = @[@6,
                                            @5,
                                            @9,
                                            @6,
                                            @6,
                                            @16,
                                            @13,
                                            @6,
                                            @5,
                                            @8,
                                            @7,
                                            @7,
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
                                          @4,
                                          @1,
                                          @1,
                                          @4];
    
    self.tone_Week5_WorkoutIndexArray = @[@2,
                                          @2,
                                          @2,
                                          @5,
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
                                          @6,
                                          @3,
                                          @3,
                                          @6];
    
    self.tone_Week7_WorkoutIndexArray = @[@4,
                                          @4,
                                          @4,
                                          @7,
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
                                          @9,
                                          @4,
                                          @9,
                                          @10,
                                          @10,
                                          @10];
    
    self.tone_Week10_WorkoutIndexArray = @[@6,
                                           @5,
                                           @6,
                                           @6,
                                           @6,
                                           @11,
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
                                           @12,
                                           @5,
                                           @11,
                                           @13,
                                           @13,
                                           @13];
    
    self.tone_Week12_WorkoutIndexArray = @[@7,
                                           @6,
                                           @7,
                                           @7,
                                           @7,
                                           @14,
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
