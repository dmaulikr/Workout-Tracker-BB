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
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    Workout *matches;
    
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
        
    }
    
    else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        
        //matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
        // Mark the workout completed to the last object in the workout database which isn't used by anything else.
        matches = [fetchedOjectsArray objectAtIndex:[fetchedOjectsArray count] - 1];
        
        matches.exerciseCompleted = [NSNumber numberWithBool:YES];
        matches.date = useDate;
    }
    
    // Save the object to persistent store
    if (![context save:&error]) {
        
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}
@end
