//
//  UITableViewController+Database.m
//  90 DWT BB
//
//  Created by Grant, Jared on 2/19/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "UITableViewController+Database.h"
#import "DataNavController.h"

@implementation UITableViewController (Database)

/*
- (NSArray *)exerciseMatches:(NSString*)exerciseName :(NSInteger*)round {
    
    // Get Data from the database.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %d)",
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         self.currentExercise.title,
                         self.renamedRound,
                         [((DataNavController *)self.parentViewController).index integerValue]];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    //NSLog(@"Objects = %d", [objects count]);
    
    return objects;
}
*/

@end
