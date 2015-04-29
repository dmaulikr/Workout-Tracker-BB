//
//  UIViewController+CoreData.m
//  90 DWT 1
//
//  Created by Jared Grant on 5/8/13.
//  Copyright (c) 2013 Grant, Jared. All rights reserved.
//

#import "UIViewController+CoreData.h"
#import "DataNavController.h"

@implementation UIViewController (CoreData)

- (NSArray *)databaseMatches {
    
    // Get Data from the database.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@)",
                         appDelegate.routine,
                         appDelegate.workout,
                         appDelegate.exerciseName,
                         appDelegate.exerciseRound];
    [request setPredicate:pred];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    //NSLog(@"Objects = %d", [objects count]);
    
    return objects;
}

-(void)saveWorkoutComplete:(NSDate*)useDate {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    WorkoutCompleteDate *matches;
    WorkoutCompleteDate *insertWorkoutInfo;
    
    NSError *error;
    NSArray *fetchedOjectsArray;
    
    NSNumber *workoutIndex = appDelegate.index;
    NSString *routine = appDelegate.routine;
    NSString *workout = appDelegate.workout;
    
    pred = [NSPredicate predicateWithFormat:@"(routine == %@) AND (workout == %@) AND (index == %@)",
            routine,
            workout,
            workoutIndex];
    [fetchRequest setPredicate:pred];
    matches = nil;
    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedOjectsArray count] == 0) {
        
        //NSLog(@"submitEntry = No matches - create new record and save");
        insertWorkoutInfo = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
        
        insertWorkoutInfo.routine = routine;
        insertWorkoutInfo.workout = workout;
        insertWorkoutInfo.index = workoutIndex;
        insertWorkoutInfo.workoutCompleted = [NSNumber numberWithBool:YES];
        insertWorkoutInfo.date = useDate;
    }
    
    else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        
        //matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
        // Mark the workout completed to the last object in the workout database which isn't used by anything else.
        matches = [fetchedOjectsArray objectAtIndex:[fetchedOjectsArray count] - 1];
        
        matches.workoutCompleted = [NSNumber numberWithBool:YES];
        matches.date = useDate;
    }
    
    // Save the object to persistent store
    if (![context save:&error]) {
        
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

-(void)deleteDate {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    WorkoutCompleteDate *matches;
    
    NSError *error;
    NSArray *fetchedOjectsArray;
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
    pred = [NSPredicate predicateWithFormat:@"(routine == %@) AND (workout == %@) AND (index == %@)",
            routine,
            workout,
            workoutIndex];
    [fetchRequest setPredicate:pred];
    matches = nil;
    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedOjectsArray count] == 0) {
        //NSLog(@"submitEntry = No matches - create new record and save");
        
    }
    
    else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        
        //matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
        // Mark the workout completed to the last object in the workout database which isn't used by anything else.
        matches = [fetchedOjectsArray objectAtIndex:[fetchedOjectsArray count] - 1];
        
        matches.workoutCompleted = [NSNumber numberWithBool:NO];
        matches.date = nil;
        
        //NSLog(@"Date = %@", matches.date);
    }
    
    // Save the object to persistent store
    if (![context save:&error]) {
        
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    //NSLog(@"Exercise Completed = %@", matches.exerciseCompleted);
    //NSLog(@"Exercise Completed = %@", insertWorkoutInfo.exerciseCompleted);
}

-(void)saveDataNavControllerToAppDelegate {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.index = ((DataNavController *)self.parentViewController).index;
    appDelegate.routine = ((DataNavController *)self.parentViewController).routine;
    appDelegate.workout = ((DataNavController *)self.parentViewController).workout;
}

-(BOOL)workoutCompleted {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    WorkoutCompleteDate *matches;
    //WorkoutCompleteDate *insertWorkoutInfo;
    
    NSError *error;
    NSArray *fetchedOjectsArray;
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
    pred = [NSPredicate predicateWithFormat:@"(routine == %@) AND (workout == %@) AND (index == %@)",
            routine,
            workout,
            workoutIndex];
    [fetchRequest setPredicate:pred];
    matches = nil;
    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
    
    BOOL tempWorkoutCompleted = false;
    
    if ([fetchedOjectsArray count] == 0) {
        
        //NSLog(@"submitEntry = No matches - create new record and save");
        tempWorkoutCompleted = NO;
    }
    
    else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        // Mark the workout completed to the last object in the workout database which isn't used by anything else.
        matches = [fetchedOjectsArray objectAtIndex:[fetchedOjectsArray count] - 1];
        
        tempWorkoutCompleted = [matches.workoutCompleted boolValue];
    }
    
    return tempWorkoutCompleted;
}

-(NSString*)getWorkoutCompletedDate {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    WorkoutCompleteDate *matches;
    //WorkoutCompleteDate *insertWorkoutInfo;
    
    NSError *error;
    NSArray *fetchedOjectsArray;
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
    pred = [NSPredicate predicateWithFormat:@"(routine == %@) AND (workout == %@) AND (index == %@)",
            routine,
            workout,
            workoutIndex];
    [fetchRequest setPredicate:pred];
    matches = nil;
    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
    
    NSDate *myDate;
    NSString *getDate;
    
    if ([fetchedOjectsArray count] == 0) {
        
        //NSLog(@"submitEntry = No matches - create new record and save");
        getDate = nil;
    }
    
    else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        // Mark the workout completed to the last object in the workout database which isn't used by anything else.
        matches = [fetchedOjectsArray objectAtIndex:[fetchedOjectsArray count] - 1];
        
        myDate = matches.date;
        
        //NSLog(@"Date = %@", matches.date);
        getDate = [NSDateFormatter localizedStringFromDate:myDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    }
    
    return getDate;
}

@end
