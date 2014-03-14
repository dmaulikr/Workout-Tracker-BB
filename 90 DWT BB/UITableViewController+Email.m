//
//  UITableViewController+Email.m
//  90 DWT BB
//
//  Created by Grant, Jared on 3/4/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "UITableViewController+Email.h"

@implementation UITableViewController (Email)

- (NSString*)stringForEmail:(NSArray*)allTitleArray {
    
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
            
            NSString *dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
            
            [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@\n",
                                       routine, month, week, workout, dateString]];
        }
    }
    
    NSString *tempExerciseName;
    NSString *tempWeightData;
    NSString *tempRepData;
    
    //  Add the workout name, reps and weight
    for (int i = 0; i < allTitleArray.count; i++) {
        
        tempExerciseName = allTitleArray[i];
        
        //  Add the title to the string
        [writeString appendString:[NSString stringWithFormat:@"%@\n", tempExerciseName]];
        
        //  Add the reps to the string
        for (int round = 0; round < 6; round++) {
            
            pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                    ((DataNavController *)self.parentViewController).routine,
                    ((DataNavController *)self.parentViewController).workout,
                    tempExerciseName,
                    round,
                    [((DataNavController *)self.parentViewController).index integerValue]];
            
            [request setPredicate:pred];
            matches = nil;
            objects = [context executeFetchRequest:request error:&error];
            
            if ([objects count] == 1) {
                
                //  Match found
                matches = objects[[objects count] - 1];
                
                tempRepData = [matches valueForKey:@"reps"];
            }
            
            else {
                
                //  No match found
                
            }

            if (![tempRepData isEqualToString:@""]) {
                
                if (round != 5) {
                    
                    //  Add  the data to the string with a "," after it
                    [writeString appendString:[NSString stringWithFormat:@"%@,", tempRepData]];
                }
                
                else {
                    
                    //  Last entry for the line so "," is not needed
                    //  Add a line break to the end of the line
                    [writeString appendString:[NSString stringWithFormat:@"%@\n", tempRepData]];
                }
            }
        }
        
            
        //  Add the weight line from the database
        for (int round = 0; round < 6; round++) {
                
            pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %d) AND (index = %d)",
                    ((DataNavController *)self.parentViewController).routine,
                    ((DataNavController *)self.parentViewController).workout,
                    tempExerciseName,
                    round,
                    [((DataNavController *)self.parentViewController).index integerValue]];
            [request setPredicate:pred];
            matches = nil;
            objects = [context executeFetchRequest:request error:&error];
            
            if ([objects count] == 1) {
                
                matches = objects[[objects count]-1];
                
                tempWeightData = [matches valueForKey:@"weight"];
                
                if (round != 5) {
                    
                    //  Add  the data to the string with a "," after it
                    [writeString appendString:[NSString stringWithFormat:@"%@,", tempWeightData]];
                }
                
                else {
                    
                    //  Last entry for the line so "," is not needed
                    //  Add a line break to the end of the line
                    [writeString appendString:[NSString stringWithFormat:@"%@\n", tempWeightData]];
                }
            }
            
            //  The user did not do the last workout so there are no records to display in the previous secition.  Set it to 0.0.
            else {
                
                if (round != 5) {
                    
                    //  Add  0.0 with a "," after it
                    [writeString appendString:[NSString stringWithFormat:@"0.0,"]];
                }
                
                else {
                    
                    //  Last entry for the line so "," is not needed
                    //  Add a line break to the end of the line
                    [writeString appendString:[NSString stringWithFormat:@"0.0\n" ]];
                }
            }
        }
    }
    
    //  Return the string
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
