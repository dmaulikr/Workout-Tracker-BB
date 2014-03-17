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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    NSError *error;
    NSArray *fetchedOjectsArray;
    Workout *matches;
    
    NSString *tempExerciseName;
    UITextField *tempPreviousTF;
    UITextField *tempCurrentTF;
    int textFieldCount = 0;
    NSNumber *roundConverted;
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSString *month = ((DataNavController *)self.parentViewController).month;
    NSString *week = ((DataNavController *)self.parentViewController).week;
    NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
    for (int i = 0; i < exerciseTitlesArray.count; i++) {
        
        tempExerciseName = exerciseTitlesArray[i];
        
        for (int round = 0; round < 6; round++) {
            
            tempPreviousTF = previousTFArray[textFieldCount];
            tempCurrentTF = currentTFArray[textFieldCount];
            roundConverted = [NSNumber numberWithInt:round];
        
            pred = [NSPredicate predicateWithFormat:@"(routine == %@) AND (workout == %@) AND (exercise == %@) AND (round == %a) AND (index == %a)",
                    routine,
                    workout,
                    tempExerciseName,
                    roundConverted,
                    workoutIndex];
            
            [fetchRequest setPredicate:pred];
            matches = nil;
            fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
            
            // 1st time exercise is done only.
            if ([((DataNavController *)self.parentViewController).index integerValue] == 1) {
                // The workout has not been done before.
                // Do NOT get previous workout data.
                // Set the current placeholders to defaults/nil.
                
                if ([fetchedOjectsArray count] == 0) {
                    //NSLog(@"viewDidLoad = No matches - Exercise has not been done before - set previous textfields to nil");
                    
                    tempCurrentTF.text = @"0.0";
                    tempPreviousTF.text = @"0.0";
                }
                
                // The workout has been done 1 time but the user came back to the 1st week workout screen to update or view.
                // Only use the current 1st week workout data when the user comes back to this screen.
                
                else {
                    //NSLog(@"viewDidLoad = Match found - set previous textfields to stored values for this weeks workout");
                    
                    matches = fetchedOjectsArray[[fetchedOjectsArray count] -1];
                    
                    tempCurrentTF.text = [matches valueForKey:@"weight"];
                    tempCurrentTF.text =
                    tempPreviousTF.text = [matches valueForKey:@"weight"];
                    
                    //NSLog(@"PreviousTF = %@", tempWeightField.text);
                    //NSLog(@"CurrentTF  = %@", tempPreviousWF.text);
                }
            }
            
            // 2nd time exercise has been done and beyond.
            else {
                
                // This workout with this index has been done before.
                // User came back to look at his results so display this weeks results in the current results section.
                if ([fetchedOjectsArray count] == 1) {
                    matches = fetchedOjectsArray[[fetchedOjectsArray count] -1];
                    
                    tempCurrentTF.text = [matches valueForKey:@"weight"];
                    
                    pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                            ((DataNavController *)self.parentViewController).routine,
                            ((DataNavController *)self.parentViewController).workout,
                            tempExerciseName,
                            round,
                            [((DataNavController *)self.parentViewController).index integerValue] -1];  // Previous workout index.
                    [fetchRequest setPredicate:pred];
                    matches = nil;
                    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    if ([fetchedOjectsArray count] == 1) {
                        
                        matches = fetchedOjectsArray[[fetchedOjectsArray count]-1];
                        
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
                            [((DataNavController *)self.parentViewController).index integerValue]];  // Previous workout index.
                    [fetchRequest setPredicate:pred];
                    matches = nil;
                    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    if ([fetchedOjectsArray count] == 1) {
                        
                        matches = fetchedOjectsArray[[fetchedOjectsArray count]-1];
                        
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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    Workout *matches;
    
    NSError *error;
    NSArray *fetchedOjectsArray;
    
    NSString *tempExerciseName;
    NSString *tempRepName;
    UITextField *tempCurrentTF;
    int textFieldCount = 0;
    NSNumber *roundConverted;
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSString *month = ((DataNavController *)self.parentViewController).month;
    NSString *week = ((DataNavController *)self.parentViewController).week;
    NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
    for (int i = 0; i < exerciseNameArray.count; i++) {
        
        tempExerciseName = exerciseNameArray[i];
        
        for (int round = 0; round < 6; round++) {
            
            tempRepName = repLabelArray[textFieldCount];
            tempCurrentTF = currentTFArray[textFieldCount];
            roundConverted = [NSNumber numberWithInt:round];
            
            pred = [NSPredicate predicateWithFormat:@"(routine == %@) AND (workout == %@) AND (exercise == %@) AND (round == %@) AND (index == %@)",
                    routine,
                    workout,
                    tempExerciseName,
                    roundConverted,
                    workoutIndex];
            [fetchRequest setPredicate:pred];
            matches = nil;
            fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
            
            if ([fetchedOjectsArray count] == 0) {
                //NSLog(@"submitEntry = No matches - create new record and save");
                
                // Only update the fields that have been changed.
                
                if (tempCurrentTF.text.length != 0) {
                    
                    Workout *insertWorkoutInfo = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:context];
                    
                    insertWorkoutInfo.reps = tempRepName;
                    insertWorkoutInfo.weight = tempCurrentTF.text;
                    //insertWorkoutInfo.notes = currentNotes.text;
                    insertWorkoutInfo.date = todaysDate;
                    insertWorkoutInfo.exercise = tempExerciseName;
                    insertWorkoutInfo.round = roundConverted;
                    insertWorkoutInfo.routine = routine;
                    insertWorkoutInfo.month = month;
                    insertWorkoutInfo.week = week;
                    insertWorkoutInfo.workout = workout;
                    insertWorkoutInfo.index = workoutIndex;
                    
                    /*
                     NSManagedObject *newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:context];
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
                     */
                }
                
            }
            
            else {
                //NSLog(@"submitEntry = Match found - update existing record and save");
                
                //matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
                matches = [fetchedOjectsArray objectAtIndex:0];
                
                // Make sure the text field is not empty
                if (tempCurrentTF.text.length != 0) {
                    
                    if (![matches.weight isEqualToString: tempCurrentTF.text]) {
                        
                        // Only update the fields that have been changed
                        matches.weight = tempCurrentTF.text;
                        matches.date = todaysDate;
                    }
                
                    /*
                    [matches setValue:tempCurrentTF.text forKey:@"weight"];
                    [matches setValue:todaysDate forKey:@"date"];
                    */
                }
            }
            
            // Save the object to persistent store
            if (![context save:&error]) {
                
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            }
            
            // End of the round "if statement"
            textFieldCount++;
            
            [tempCurrentTF resignFirstResponder];
        }
    }
}
@end
