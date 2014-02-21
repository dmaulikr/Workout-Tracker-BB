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
    
    for (int i = 0; i < weightFieldArray.count; i++) {
        
        UITextField *tempWeightField = weightFieldArray[i];
        int round = i+1;
        
         // Get Data from the database.
         AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
         NSManagedObjectContext *context = [appDelegate managedObjectContext];
         NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
         NSFetchRequest *request = [[NSFetchRequest alloc] init];
         [request setEntity:entityDesc];
         NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                             ((DataNavController *)self.parentViewController).routine,
                             ((DataNavController *)self.parentViewController).workout,
                              tempCell.exerciseLabel.text,
                             round,
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
                 tempWeightField.placeholder = @"0";
                 /*
                 self.currentReps.placeholder = @"0";
                 self.currentWeight.placeholder = @"0.0";
                 self.currentNotes.placeholder = @"Type any notes here";
                 */
                 /*
                 self.previousReps.text = @"";
                 self.previousWeight.text = @"";
                 self.previousNotes.text = @"";
                  */
             }
         
             // The workout has been done 1 time but the user came back to the 1st week workout screen to update or view.
             // Only use the current 1st week workout data when the user comes back to this screen.
             
             else {
                 //NSLog(@"viewDidLoad = Match found - set previous textfields to stored values for this weeks workout");
                 
                 matches = objects[[objects count] -1];
                 /*
                 self.currentReps.placeholder = @"";
                 self.currentWeight.placeholder = @"";
                 self.currentNotes.placeholder = @"";
                 
                 self.previousReps.text = [matches valueForKey:@"reps"];
                 self.previousWeight.text = [matches valueForKey:@"weight"];
                 self.previousNotes.text = [matches valueForKey:@"notes"];
                  */
             }
             
         }
         
         // 2nd time exercise has been done and beyond.
         else {
         
             // This workout with this index has been done before.
             // User came back to look at his results so display this weeks results in the current results section.
             if ([objects count] == 1) {
                 matches = objects[[objects count] -1];
                 
                 tempWeightField.placeholder = @"1";
                 /*
                 self.currentReps.placeholder = [matches valueForKey:@"reps"];
                 self.currentWeight.placeholder = [matches valueForKey:@"weight"];
                 self.currentNotes.placeholder = [matches valueForKey:@"notes"];
                 //NSLog(@"Current Reps = %@", self.currentReps.placeholder);
                 //NSLog(@"Current Weight = %@", self.currentWeight.placeholder);
                 //NSLog(@"Current Notes = %@", self.currentNotes.placeholder);
                  */
             }
         
             // This workout with this index has NOT been done before.
             // Set the current placeholders to defaults/nil.
             else {
                 tempWeightField.placeholder = @"2";
                 /*
                 self.currentReps.placeholder = @"0";
                 self.currentWeight.placeholder = @"0.0";
                 self.currentNotes.placeholder = @"Type any notes here";
                  */
             }
         
             // This is at least the 2nd time a particular workout has been started.
             // Get the previous workout data and present it to the user in the previous section.
             
             /*
             NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %d)",
             ((DataNavController *)self.parentViewController).routine,
             ((DataNavController *)self.parentViewController).workout,
             self.currentExercise.title,
             self.renamedRound,
             [((DataNavController *)self.parentViewController).index integerValue] -1];  // Previous workout index.
             [request setPredicate:pred];
             NSManagedObject *matches = nil;
             NSError *error;
             NSArray *objects = [context executeFetchRequest:request error:&error];
             
             if ([objects count] == 1) {
                 matches = objects[[objects count]-1];
                 
                 self.previousReps.text = [matches valueForKey:@"reps"];
                 self.previousWeight.text = [matches valueForKey:@"weight"];
                 self.previousNotes.text = [matches valueForKey:@"notes"];
                 //NSLog(@"Previous Reps = %@", self.previousReps.text);
                 //NSLog(@"Previous Weight = %@", self.previousWeight.text);
                 //NSLog(@"Previous Notes = %@", self.previousNotes.text);
             }
             
             else {
                 self.previousReps.text = @"";
                 self.previousWeight.text = @"";
                 self.previousNotes.text = @"No record for the last workout";
             }
              */
         }
    }
}

-(void)saveToDatabase:(NSArray*)cell :(NSArray*)repLabelArray :(NSArray*)weightFieldArray {
    
}

@end
