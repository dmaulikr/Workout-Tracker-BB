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

- (void)exerciseMatches:(ExerciseCell*)cell :(NSIndexPath*)indexPath {
    
    //int tempSection = indexPath.section;
    //int tempRow = indexPath.row;
    
    //NSLog(@"Name = %@ Section = %d Row = %d", cell.exerciseLabel.text,tempSection, tempRow);
    
    NSArray *tempCellWeightFieldArray = @[cell.weightField1,
                                          cell.weightField2,
                                          cell.weightField3,
                                          cell.weightField4,
                                          cell.weightField5,
                                          cell.weightField6];
    
    NSArray *tempCellPreviousWFArray = @[cell.previousWF1,
                                         cell.previousWF2,
                                         cell.previousWF3,
                                         cell.previousWF4,
                                         cell.previousWF5,
                                         cell.previousWF6];
    
    // Get Data from the database.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    for (int i = 0; i < tempCellWeightFieldArray.count; i++) {
            
        UITextField *tempWeightField = tempCellWeightFieldArray[i];
        UITextField *tempPreviousWF = tempCellPreviousWFArray[i];
        
        //NSLog(@"Retreived WeightField %d = %@", i, tempWeightField.placeholder);
        NSNumber *round = [NSNumber numberWithInt:i + 1];
        
        //NSLog(@"WT Field %d = %@", i + 1, tempWeightField.text);
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                             ((DataNavController *)self.parentViewController).routine,
                             ((DataNavController *)self.parentViewController).workout,
                              cell.exerciseLabel.text,
                             [round integerValue],
                             [((DataNavController *)self.parentViewController).index integerValue]];
        [request setPredicate:pred];
        NSManagedObject *matches = nil;
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request error:&error];

        int workoutIndex = [((DataNavController *)self.parentViewController).index integerValue];
        //NSLog(@"Workout = %@ index = %@", ((DataNavController *)self.parentViewController).workout, ((DataNavController *)self.parentViewController).index);

        // 1st time exercise is done only.
        if (workoutIndex == 1) {
            // The workout has not been done before.
            // Do NOT get previous workout data.
            // Set the current placeholders to defaults/nil.

            if ([objects count] == 0) {
                //NSLog(@"viewDidLoad = No matches - Exercise has not been done before - set previous textfields to nil");
                
                tempWeightField.text = @"0.0";
                tempPreviousWF.text = @"0.0";
            }

                // The workout has been done 1 time but the user came back to the 1st week workout screen to update or view.
                // Only use the current 1st week workout data when the user comes back to this screen.

            else {
                //NSLog(@"viewDidLoad = Match found - set previous textfields to stored values for this weeks workout");

                matches = objects[[objects count] -1];
                
                tempWeightField.text = [matches valueForKey:@"weight"];
                tempPreviousWF.text = [matches valueForKey:@"weight"];
                
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
                
                tempWeightField.text = [matches valueForKey:@"weight"];
                
                pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                        ((DataNavController *)self.parentViewController).routine,
                        ((DataNavController *)self.parentViewController).workout,
                        cell.exerciseLabel.text,
                        [round integerValue],
                        [((DataNavController *)self.parentViewController).index integerValue] -1];  // Previous workout index.
                [request setPredicate:pred];
                NSManagedObject *matches = nil;
                NSError *error;
                NSArray *objects = [context executeFetchRequest:request error:&error];
                
                if ([objects count] == 1) {
                    
                    matches = objects[[objects count]-1];
                    
                    tempPreviousWF.text = [matches valueForKey:@"weight"];
                }
                
                //  The user did not do the last workout so there are no records to display in the previous secition.  Set it to 0.0.
                else {
                    
                    tempPreviousWF.text = @"0.0";
                }
            }

                // This workout with this index has NOT been done before.
                // Set the current placeholders to defaults/nil.
            else {
                
                tempWeightField.text = @"0.0";
                
                pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                        ((DataNavController *)self.parentViewController).routine,
                        ((DataNavController *)self.parentViewController).workout,
                        cell.exerciseLabel.text,
                        [round integerValue],
                        [((DataNavController *)self.parentViewController).index integerValue] -1];  // Previous workout index.
                [request setPredicate:pred];
                NSManagedObject *matches = nil;
                NSError *error;
                NSArray *objects = [context executeFetchRequest:request error:&error];
                
                if ([objects count] == 1) {
                    
                    matches = objects[[objects count]-1];
                    
                    tempPreviousWF.text = [matches valueForKey:@"weight"];
                }
                
                //  The user did not do the last workout so there are no records to display in the previous secition.  Set it to 0.0.
                else {
                    
                    tempPreviousWF.text = @"0.0";
                }
            }
        }
    }
}

-(void)saveToDatabase:(NSArray*)cell {
    
    NSDate *todaysDate = [NSDate date];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    for (int j = 0; j < cell.count; j++) {
        
        ExerciseCell *tempCell = cell[j];
        
        NSArray *tempCellRepsLabelArray = @[tempCell.repLabel1,
                                            tempCell.repLabel2,
                                            tempCell.repLabel3,
                                            tempCell.repLabel4,
                                            tempCell.repLabel5,
                                            tempCell.repLabel6];
        
        NSArray *tempCellWeightFieldArray = @[tempCell.weightField1,
                                              tempCell.weightField2,
                                              tempCell.weightField3,
                                              tempCell.weightField4,
                                              tempCell.weightField5,
                                              tempCell.weightField6];
        
        for (int i = 0; i < tempCellWeightFieldArray.count; i++) {
        
            UILabel *tempRepLabel = tempCellRepsLabelArray[i];
            UITextField *tempWeightField = tempCellWeightFieldArray[i];
            NSNumber *round = [NSNumber numberWithInt:i + 1];
            
            //NSLog(@"WT Field %d = %@", i + 1, tempWeightField.text);
            
            //NSLog(@"Round = %@ Reps = %@ WeightField = %@", round, tempRepLabel.text, tempWeightField.text);
            
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                             ((DataNavController *)self.parentViewController).routine,
                             ((DataNavController *)self.parentViewController).workout,
                             tempCell.exerciseLabel.text,
                             [round integerValue],
                             [((DataNavController *)self.parentViewController).index integerValue]];
            [request setPredicate:pred];
            NSManagedObject *matches = nil;
            NSError *error;
            NSArray *objects = [context executeFetchRequest:request error:&error];
        
            if ([objects count] == 0) {
                //NSLog(@"submitEntry = No matches - create new record and save");
                
                // Only update the fields that have been changed.
                
                if (tempWeightField.text.length != 0) {
                
                    NSManagedObject *newExercise;
                    newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:context];
                    [newExercise setValue:tempRepLabel.text forKey:@"reps"];
                    [newExercise setValue:tempWeightField.text forKey:@"weight"];
                    //[newExercise setValue:self.currentNotes.text forKey:@"notes"];
                    [newExercise setValue:todaysDate forKey:@"date"];
                    [newExercise setValue:tempCell.exerciseLabel.text forKey:@"exercise"];
                    [newExercise setValue:round forKey:@"round"];
                    [newExercise setValue:((DataNavController *)self.parentViewController).routine forKey:@"routine"];
                    [newExercise setValue:((DataNavController *)self.parentViewController).month forKey:@"month"];
                    [newExercise setValue:((DataNavController *)self.parentViewController).week forKey:@"week"];
                    [newExercise setValue:((DataNavController *)self.parentViewController).workout forKey:@"workout"];
                    [newExercise setValue:((DataNavController *)self.parentViewController).index forKey:@"index"];
                }
                
            } else {
                //NSLog(@"submitEntry = Match found - update existing record and save");
                
                matches = objects[[objects count]-1];
                
                // Only update the fields that have been changed.
                
                if (tempWeightField.text.length != 0) {
                    [matches setValue:tempWeightField.text forKey:@"weight"];
                    [matches setValue:todaysDate forKey:@"date"];
                }
            }
            
            // Save the object to persistent store
            if (![context save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            }
            
            [tempWeightField resignFirstResponder];
        }
    }
}

@end
