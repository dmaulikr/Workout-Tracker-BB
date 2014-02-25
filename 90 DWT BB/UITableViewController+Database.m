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

- (void)exerciseMatches:(ExerciseCell*)cell :(NSInteger*)section :(NSArray*)weightFieldArray {
    
    ExerciseCell *tempCell = cell;
    int tempSection = *section;
    //NSLog(@"Section = %d", [section intValue]);
    
    // Get Data from the database.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    for (int i = 0; i < weightFieldArray.count; i++) {
            
        UITextField *tempWeightField;
        //NSLog(@"Retreived WeightField %d = %@", i, tempWeightField.placeholder);
        NSNumber *round = [NSNumber numberWithInt:i + 1];
        
        if (i == 0) {
            tempWeightField = tempCell.weightField1;
        }
        else if (i == 1) {
            tempWeightField = tempCell.weightField2;
        }
        else if (i == 2) {
            tempWeightField = tempCell.weightField3;
        }
        else if (i == 3) {
            tempWeightField = tempCell.weightField4;
        }
        else if (i == 4) {
            tempWeightField = tempCell.weightField5;
        }
        else if (i == 5) {
            tempWeightField = tempCell.weightField6;
        }
        
        NSLog(@"WT Field %d = %@", i + 1, tempWeightField.text);
        
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDesc];
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

        int workoutIndex = [((DataNavController *)self.parentViewController).index integerValue];
        //NSLog(@"Workout = %@ index = %@", ((DataNavController *)self.parentViewController).workout, ((DataNavController *)self.parentViewController).index);

        // 1st time exercise is done only.
        if (workoutIndex == 1) {
            // The workout has not been done before.
            // Do NOT get previous workout data.
            // Set the current placeholders to defaults/nil.

            if ([objects count] == 0) {
                //NSLog(@"viewDidLoad = No matches - Exercise has not been done before - set previous textfields to nil");
                
                if (tempSection == 0) {
                    tempWeightField.placeholder = @"0.0";
                }
                
                else {
                    tempWeightField.text = @"0.0";
                }
            }

                // The workout has been done 1 time but the user came back to the 1st week workout screen to update or view.
                // Only use the current 1st week workout data when the user comes back to this screen.

            else {
                //NSLog(@"viewDidLoad = Match found - set previous textfields to stored values for this weeks workout");

                matches = objects[[objects count] -1];
                
                if (tempSection == 0) {
                    tempWeightField.placeholder = [matches valueForKey:@"weight"];
                }
                
                else {
                    tempWeightField.text = [matches valueForKey:@"weight"];
                }
            }
        }

        // 2nd time exercise has been done and beyond.
        else {

            // This workout with this index has been done before.
            // User came back to look at his results so display this weeks results in the current results section.
            if ([objects count] == 1) {
                matches = objects[[objects count] -1];
                
                if (tempSection == 0) {
                    
                    tempWeightField.placeholder = [matches valueForKey:@"weight"];
                }
                
                else {
                    
                    NSManagedObjectContext *context = [appDelegate managedObjectContext];
                    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
                    NSFetchRequest *request = [[NSFetchRequest alloc] init];
                    [request setEntity:entityDesc];
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                                         ((DataNavController *)self.parentViewController).routine,
                                         ((DataNavController *)self.parentViewController).workout,
                                         tempCell.exerciseLabel.text,
                                         [round integerValue],
                                         [((DataNavController *)self.parentViewController).index integerValue] -1];  // Previous workout index.
                    [request setPredicate:pred];
                    NSManagedObject *matches = nil;
                    NSError *error;
                    NSArray *objects = [context executeFetchRequest:request error:&error];
                    
                    if ([objects count] == 1) {
                        
                        matches = objects[[objects count]-1];
                        
                        if (tempSection == 1) {
                            
                            tempWeightField.text = [matches valueForKey:@"weight"];
                        }
                    }
                    
                    //  The user did not do the last workout so there are no records to display in the previous secition.  Set it to 0.0.
                    else {
                        
                        if (tempSection == 1) {
                            
                            tempWeightField.text = @"0.0";
                        }
                    }
                }
            }

                // This workout with this index has NOT been done before.
                // Set the current placeholders to defaults/nil.
            else {
                
                if (tempSection == 0) {
                    
                    tempWeightField.placeholder = @"0.0";
                }
                
                else {
                    
                    NSManagedObjectContext *context = [appDelegate managedObjectContext];
                    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
                    NSFetchRequest *request = [[NSFetchRequest alloc] init];
                    [request setEntity:entityDesc];
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                                         ((DataNavController *)self.parentViewController).routine,
                                         ((DataNavController *)self.parentViewController).workout,
                                         tempCell.exerciseLabel.text,
                                         [round integerValue],
                                         [((DataNavController *)self.parentViewController).index integerValue] -1];  // Previous workout index.
                    [request setPredicate:pred];
                    NSManagedObject *matches = nil;
                    NSError *error;
                    NSArray *objects = [context executeFetchRequest:request error:&error];
                    
                    if ([objects count] == 1) {
                        
                        matches = objects[[objects count]-1];
                        
                        if (tempSection == 1) {
                            
                            tempWeightField.text = [matches valueForKey:@"weight"];
                        }
                    }
                    
                    //  The user did not do the last workout so there are no records to display in the previous secition.  Set it to 0.0.
                    else {
                        
                        if (tempSection == 1) {
                            
                            tempWeightField.text = @"0.0";
                        }
                    }
                }
            }
        }
    }
}

-(void)saveToDatabase:(NSArray*)cell :(NSArray*)repLabelArray :(NSArray*)weightFieldArray {
    
    NSDate *todaysDate = [NSDate date];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    for (int j = 0; j < cell.count; j++) {
        
        ExerciseCell *tempCell = cell[j];
        
        for (int i = 0; i < weightFieldArray.count; i++) {
        
            UILabel *tempRepLabel = repLabelArray[i];
            UITextField *tempWeightField;
            NSNumber *round = [NSNumber numberWithInt:i + 1];
            
            if (i == 0) {
                tempWeightField = tempCell.weightField1;
            }
            else if (i == 1) {
                tempWeightField = tempCell.weightField2;
            }
            else if (i == 2) {
                tempWeightField = tempCell.weightField3;
            }
            else if (i == 3) {
                tempWeightField = tempCell.weightField4;
            }
            else if (i == 4) {
                tempWeightField = tempCell.weightField5;
            }
            else if (i == 5) {
                tempWeightField = tempCell.weightField6;
            }
            
            
            NSLog(@"WT Field %d = %@", i + 1, tempWeightField.text);
            
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
