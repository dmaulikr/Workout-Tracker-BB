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

-(void)exerciseMatches:(NSArray*)exerciseTitlesArray :(NSArray*)previousTFArray :(NSArray*)currentTFArray {
    
    // Get Data from the database.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred;
    NSManagedObject *matches;
    NSError *error;
    NSArray *objects;
    
    NSString *tempExerciseName;
    UITextField *tempPreviousTF;
    UITextField *tempCurrentTF;
    int textFieldCount = 0;
    int workoutIndex = [((DataNavController *)self.parentViewController).index integerValue];
    
    for (int i = 0; i < exerciseTitlesArray.count; i++) {
        
        tempExerciseName = exerciseTitlesArray[i];
        
        for (int round = 0; round < 6; round++) {
            
            tempPreviousTF = previousTFArray[textFieldCount];
            tempCurrentTF = currentTFArray[textFieldCount];
        
            pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                    ((DataNavController *)self.parentViewController).routine,
                    ((DataNavController *)self.parentViewController).workout,
                    tempExerciseName,
                    round,
                    workoutIndex];
            
            [request setPredicate:pred];
            matches = nil;
            objects = [context executeFetchRequest:request error:&error];
            
            // 1st time exercise is done only.
            if (workoutIndex == 1) {
                // The workout has not been done before.
                // Do NOT get previous workout data.
                // Set the current placeholders to defaults/nil.
                
                if ([objects count] == 0) {
                    //NSLog(@"viewDidLoad = No matches - Exercise has not been done before - set previous textfields to nil");
                    
                    tempCurrentTF.text = @"0.0";
                    tempPreviousTF.text = @"0.0";
                }
                
                // The workout has been done 1 time but the user came back to the 1st week workout screen to update or view.
                // Only use the current 1st week workout data when the user comes back to this screen.
                
                else {
                    //NSLog(@"viewDidLoad = Match found - set previous textfields to stored values for this weeks workout");
                    
                    matches = objects[[objects count] -1];
                    
                    tempCurrentTF.text = [matches valueForKey:@"weight"];
                    tempPreviousTF.text = [matches valueForKey:@"weight"];
                    
                    //NSLog(@"PreviousTF = %@", tempWeightField.text);
                    //NSLog(@"CurrentTF  = %@", tempPreviousWF.text);
                }
            }
            
            // 2nd time exercise has been done and beyond.
            else {
                
                // This workout with this index has been done before.
                // User came back to look at his results so display this weeks results in the current results section.
                if ([objects count] == 1) {
                    matches = objects[[objects count] -1];
                    
                    tempCurrentTF.text = [matches valueForKey:@"weight"];
                    
                    pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                            ((DataNavController *)self.parentViewController).routine,
                            ((DataNavController *)self.parentViewController).workout,
                            tempExerciseName,
                            round,
                            [((DataNavController *)self.parentViewController).index integerValue] -1];  // Previous workout index.
                    [request setPredicate:pred];
                    matches = nil;
                    objects = [context executeFetchRequest:request error:&error];
                    
                    if ([objects count] == 1) {
                        
                        matches = objects[[objects count]-1];
                        
                        tempPreviousTF.text = [matches valueForKey:@"weight"];
                    }
                    
                    //  The user did not do the last workout so there are no records to display in the previous secition.  Set it to 0.0.
                    else {
                        
                        tempPreviousTF.text = @"0.0";
                    }
                }
                
                // This workout with this index has NOT been done before.
                // Set the current placeholders to defaults/nil.
                else {
                    
                    tempCurrentTF.text = @"0.0";
                    
                    pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                            ((DataNavController *)self.parentViewController).routine,
                            ((DataNavController *)self.parentViewController).workout,
                            tempExerciseName,
                            round,
                            workoutIndex];  // Previous workout index.
                    [request setPredicate:pred];
                    matches = nil;
                    objects = [context executeFetchRequest:request error:&error];
                    
                    if ([objects count] == 1) {
                        
                        matches = objects[[objects count]-1];
                        
                        tempPreviousTF.text = [matches valueForKey:@"weight"];
                    }
                    
                    //  The user did not do the last workout so there are no records to display in the previous secition.  Set it to 0.0.
                    else {
                        
                        tempPreviousTF.text = @"0.0";
                    }
                }
            }
            
            // End of the round "if statement"
            textFieldCount++;
        }
    }
}

-(void)saveToDatabase:(NSArray*)exerciseNameArray :(NSArray*)repLabelArray :(NSArray*)currentTFArray {
    
    NSDate *todaysDate = [NSDate date];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred;
    NSManagedObject *matches;
    NSManagedObject *newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:context];
    NSError *error;
    NSArray *objects;
    
    NSString *tempExerciseName;
    NSString *tempRepName;
    UITextField *tempCurrentTF;
    int textFieldCount = 0;
    NSNumber *roundConverted;
    
    int workoutIndex = [((DataNavController *)self.parentViewController).index integerValue];
    
    for (int i = 0; i < exerciseNameArray.count; i++) {
        
        tempExerciseName = exerciseNameArray[i];
        
        for (int round = 0; round < 6; round++) {
            
            tempRepName = repLabelArray[textFieldCount];
            tempCurrentTF = currentTFArray[textFieldCount];
            roundConverted = [NSNumber numberWithInt:round];
            
            pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                    ((DataNavController *)self.parentViewController).routine,
                    ((DataNavController *)self.parentViewController).workout,
                    tempExerciseName,
                    roundConverted,
                    workoutIndex];
            [request setPredicate:pred];
            matches = nil;
            objects = [context executeFetchRequest:request error:&error];
            
            if ([objects count] == 0) {
                //NSLog(@"submitEntry = No matches - create new record and save");
                
                // Only update the fields that have been changed.
                
                if (tempCurrentTF.text.length != 0) {
                    
                    [newExercise setValue:tempRepName forKey:@"reps"];
                    [newExercise setValue:tempCurrentTF.text forKey:@"weight"];
                    //[newExercise setValue:self.currentNotes.text forKey:@"notes"];
                    [newExercise setValue:todaysDate forKey:@"date"];
                    [newExercise setValue:tempExerciseName forKey:@"exercise"];
                    [newExercise setValue:roundConverted forKey:@"round"];
                    [newExercise setValue:((DataNavController *)self.parentViewController).routine forKey:@"routine"];
                    [newExercise setValue:((DataNavController *)self.parentViewController).month forKey:@"month"];
                    [newExercise setValue:((DataNavController *)self.parentViewController).week forKey:@"week"];
                    [newExercise setValue:((DataNavController *)self.parentViewController).workout forKey:@"workout"];
                    [newExercise setValue:((DataNavController *)self.parentViewController).index forKey:@"index"];
                }
                
            }
            
            else {
                //NSLog(@"submitEntry = Match found - update existing record and save");
                
                matches = objects[[objects count] - 1];
                
                // Only update the fields that have been changed.
                
                if (tempCurrentTF.text.length != 0) {
                    [matches setValue:tempCurrentTF.text forKey:@"weight"];
                    [matches setValue:todaysDate forKey:@"date"];
                }
            }
            
            // Save the object to persistent store
            if (![context save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            
            // End of the round "if statement"
            textFieldCount++;
            
            [tempCurrentTF resignFirstResponder];
            }
        }
    }
}
@end
