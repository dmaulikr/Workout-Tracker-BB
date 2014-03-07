//
//  UITableViewController+Email.m
//  90 DWT BB
//
//  Created by Grant, Jared on 3/4/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "UITableViewController+Email.h"

@implementation UITableViewController (Email)

- (NSString*)stringForEmail:(NSArray*)allTitleArray :(NSArray*)allRepArray :(int)numOfRows {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (index = %d)",
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         [((DataNavController *)self.parentViewController).index integerValue]];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
    
    // Create the Header info
    if ([objects count] != 0)
    {
        
        //  Add the column headers for Routine, Month, Week, Workout, and Date to the string
        [writeString appendString:[NSString stringWithFormat:@"Routine,Month,Week,Workout,Date\n"]];
        
        for (int i = 0; i < 1; i++)
        {
            matches = objects[i];
            NSString *routine =     [matches valueForKey:@"routine"];
            NSString *month =       [matches valueForKey:@"month"];
            NSString *week  =       [matches valueForKey:@"week"];
            NSString *workout =     [matches valueForKey:@"workout"];
            NSDate  *date =        [matches valueForKey:@"date"];
            
            NSString *dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
            
            [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@\n\n",
                                       routine, month, week, workout, dateString]];
        }
    }
    
    //  Add the workout name, reps and weight
    for (int i = 0; i < allTitleArray.count; i++) {
        
        NSArray *tempTitleArray1 = allTitleArray[i];
        NSArray *tempRepArray1 = allRepArray[i];
        
        for (int j = 0; j < tempTitleArray1.count; j++) {
            
            //  Add the title to the string
            [writeString appendString:[NSString stringWithFormat:@"%@\n", tempTitleArray1[j]]];
            
            NSArray *tempRepArray2 = tempRepArray1[j];
            
            for (int k = 0; k < tempRepArray2.count; k++) {
                
                //  Add the rep line
                if (k != tempRepArray2.count - 1) {
                    
                    //  Add  the data to the string with a "," after it
                    [writeString appendString:[NSString stringWithFormat:@"%@,", tempRepArray2[k]]];
                }
                
                else {
                    
                    //  Last entry for the line so "," is not needed
                    //  Add a line break to the end of the line
                    [writeString appendString:[NSString stringWithFormat:@"%@\n", tempRepArray2[k]]];
                }
                
                //  Add the weight line from the database
                for (int w = 0; w < tempRepArray2.count; w++) {
                    
                    //
                }
            }
        }
    }
    
    NSLog(@"%@", writeString);
     
    /*
    if ([objects count] != 0)
    {
        [writeString appendString:[NSString stringWithFormat:@"Routine,Month,Week,Workout,Round,Exercise,Reps,Weight,Notes,Date\n"]];
        for (int a = 0; a < [self.exerciseNames count]; a++)
        {
            BOOL matchFound = false;
            NSString *arrayExerciseNameRound = self.exerciseNames[a];
            
            // Remove the (Round #) at the end of the exercise name.
            NSString *exerciseNameClean = [arrayExerciseNameRound substringToIndex:[arrayExerciseNameRound length] - 8];
            
            for (int i = 0; i < [objects count]; i++)
            {
                matches = objects[i];
                NSString *routine =     [matches valueForKey:@"routine"];
                NSString *month =       [matches valueForKey:@"month"];
                NSString *week  =       [matches valueForKey:@"week"];
                NSString *workout =     [matches valueForKey:@"workout"];
                NSString *round =       [matches valueForKey:@"round"];
                NSString *exercise =    [matches valueForKey:@"exercise"];
                NSString *reps =        [matches valueForKey:@"reps"];
                NSString *weight =      [matches valueForKey:@"weight"];
                NSString *notes =       [matches valueForKey:@"notes"];
                NSString *date =        [matches valueForKey:@"date"];
                
                NSString *combinedExerciseNameRound = [exercise stringByAppendingString:@" "];
                combinedExerciseNameRound = [combinedExerciseNameRound stringByAppendingString:round];
                
                if ([arrayExerciseNameRound isEqualToString:combinedExerciseNameRound])
                {
                    [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@\n",
                                               routine, month, week, workout, round, exercise, reps, weight, notes, date]];
                    matchFound = true;
                }
            }
            
            if (!matchFound)
            {
                [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,,%@,,,,\n",
                                           ((DataNavController *)self.parentViewController).routine,
                                           ((DataNavController *)self.parentViewController).month,
                                           ((DataNavController *)self.parentViewController).week,
                                           ((DataNavController *)self.parentViewController).workout,
                                           exerciseNameClean]];
            }
        }
    }
     */

    
    return writeString;
}

- (void)sendEmail:(NSString*)csvString {
    
    NSData *csvData = [csvString dataUsingEncoding:NSASCIIStringEncoding];
    NSString *workoutName = ((DataNavController *)self.parentViewController).workout;
    workoutName = [workoutName stringByAppendingString:@".csv"];
    
    // Create MailComposerViewController object.
    MFMailComposeViewController *mailComposer;
    mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    mailComposer.navigationBar.tintColor = [UIColor whiteColor];
    
    // Array to store the default email address.
    NSArray *emailAddresses;
    
    // Get path to documents directory to get default email address.
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *defaultEmailFile = nil;
    defaultEmailFile = [docDir stringByAppendingPathComponent:@"Default Email.out"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:defaultEmailFile]) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:defaultEmailFile];
        
        NSString *defaultEmail = [[NSString alloc] initWithData:[fileHandle availableData] encoding:NSUTF8StringEncoding];
        [fileHandle closeFile];
        
        // There is a default email address.
        emailAddresses = @[defaultEmail];
    }
    else {
        // There is NOT a default email address.  Put an empty email address in the arrary.
        emailAddresses = @[@""];
    }
    
    [mailComposer setToRecipients:emailAddresses];
    [mailComposer setSubject:@"90 DWT BB Workout Data"];
    [mailComposer addAttachmentData:csvData mimeType:@"text/csv" fileName:workoutName];
    [self presentViewController:mailComposer animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
