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

-(void)exerciseMatches:(NSArray*)exerciseTitlesArray :(NSArray*)previousTFArray :(NSArray*)currentTFArray :(NSArray*)prevNotesArray :(NSArray*)curNotesArray{
    
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
    UITextField *tempPreviousNotes;
    UITextField *tempCurrentNotes;
    int textFieldCount = 0;
    NSNumber *roundConverted;
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSNumber *previousWorkoutIndex = @([workoutIndex integerValue] - 1);
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
    appDelegate.index = workoutIndex;
    
    for (int i = 0; i < exerciseTitlesArray.count; i++) {
        
        tempExerciseName = exerciseTitlesArray[i];
        tempPreviousNotes = prevNotesArray[i];
        tempCurrentNotes = curNotesArray[i];
        
        // Get data for previousTF and currentTF and Previous Notes and Current Notes.
        for (int round = 0; round < 6; round++) {
            
            tempPreviousTF = previousTFArray[textFieldCount];
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
            
            // 1st time exercise is done only.
            if ([workoutIndex integerValue] == 1) {
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
                    
                    matches = [fetchedOjectsArray objectAtIndex:0];
                    
                    tempCurrentTF.text = matches.weight;
                    tempPreviousTF.text = matches.weight;
                    
                    tempCurrentNotes.text = matches.notes;
                    tempPreviousNotes.text = matches.notes;
                }
            }
            
            // 2nd time exercise has been done and beyond.
            else {
                
                // This workout with this index has been done before.
                // User came back to look at his results so display this weeks results in the current results section.
                if ([fetchedOjectsArray count] == 1) {
                    
                    matches = [fetchedOjectsArray objectAtIndex:0];
                    
                    tempCurrentTF.text = matches.weight;
                    tempCurrentNotes.text = matches.notes;
                    
                    pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %@)",
                            routine,
                            workout,
                            tempExerciseName,
                            roundConverted,
                            previousWorkoutIndex];  // Previous workout index.
                    [fetchRequest setPredicate:pred];
                    matches = nil;
                    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    if ([fetchedOjectsArray count] == 1) {
                        
                        matches = [fetchedOjectsArray objectAtIndex:0];
                        
                        tempPreviousTF.text = matches.weight;
                        tempPreviousNotes.text = matches.notes;
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
                    
                    pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %@)",
                            routine,
                            workout,
                            tempExerciseName,
                            roundConverted,
                            previousWorkoutIndex];  // Previous workout index.
                    [fetchRequest setPredicate:pred];
                    matches = nil;
                    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    if ([fetchedOjectsArray count] == 1) {
                        
                        matches = [fetchedOjectsArray objectAtIndex:0];
                        
                        tempPreviousTF.text = matches.weight;
                        tempPreviousNotes.text = matches.notes;
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

-(void)saveToDatabase:(NSArray*)exerciseNameArray :(NSArray*)repLabelArray :(NSArray*)currentTFArray :(NSArray*)curNotesArray {
    
    NSDate *todaysDate = [NSDate date];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    Workout *matches;
    Workout *insertWorkoutInfo;
    
    NSError *error;
    NSArray *fetchedOjectsArray;
    
    NSString *tempExerciseName;
    NSString *tempRepName;
    UITextField *tempCurrentTF;
    UITextField *tempCurrentNotes;
    int textFieldCount = 0;
    NSNumber *roundConverted;
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSString *month = ((DataNavController *)self.parentViewController).month;
    NSString *week = ((DataNavController *)self.parentViewController).week;
    NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
    for (int i = 0; i < exerciseNameArray.count; i++) {
        
        tempExerciseName = exerciseNameArray[i];
        tempCurrentNotes = curNotesArray[i];
        
        // Save the Current Weight text field and Current Notes text field
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
                    
                    insertWorkoutInfo = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:context];
                    
                    insertWorkoutInfo.reps = tempRepName;
                    insertWorkoutInfo.weight = tempCurrentTF.text;
                    insertWorkoutInfo.notes = tempCurrentNotes.text;
                    insertWorkoutInfo.date = todaysDate;
                    insertWorkoutInfo.exercise = tempExerciseName;
                    insertWorkoutInfo.round = roundConverted;
                    insertWorkoutInfo.routine = routine;
                    insertWorkoutInfo.month = month;
                    insertWorkoutInfo.week = week;
                    insertWorkoutInfo.workout = workout;
                    insertWorkoutInfo.index = workoutIndex;
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
                }
                
                // Make sure the text field is not empty
                if (tempCurrentNotes.text.length != 0) {
                    
                    if (![matches.notes isEqualToString: tempCurrentNotes.text]) {
                        
                        // Only update the fields that have been changed
                        matches.notes = tempCurrentNotes.text;
                        matches.date = todaysDate;
                    }
                }
            }
            
            // Save the object to persistent store
            if (![context save:&error]) {
                
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            }
            
            // End of the round "if statement"
            textFieldCount++;
            
            [tempCurrentTF resignFirstResponder];
            [tempCurrentNotes resignFirstResponder];
        }
    }
}
@end
