//
//  UITableViewController+Email.m
//  90 DWT BB
//
//  Created by Grant, Jared on 3/4/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "UITableViewController+Email.h"
#import "CoreDataHelper.h"

@implementation UITableViewController (Email)

- (NSString*)stringForEmail:(NSArray*)allTitleArray {
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    // Get workout data with the current session
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (index = %d)",
                         currentSessionString,
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         [((DataNavController *)self.parentViewController).index integerValue]];
    [fetchRequest setPredicate:pred];
    Workout *matches = nil;
    NSError *error;
    NSArray *fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
    
    NSString *session;
    NSString *routine;
    NSString *month;
    NSString *week;
    NSString *workout;
    NSDate  *date;
    NSString *dateString;
    
    // Create the Header info
    if ([fetchedOjectsArray count] != 0)
    {
        
        //  Add the column headers for Routine, Month, Week, Workout, and Date to the string
        [writeString appendString:[NSString stringWithFormat:@"Session,Routine,Month,Week,Workout,Date\n"]];
        
        for (int i = 0; i < 1; i++)
        {
            matches = fetchedOjectsArray[i];
            
            session = matches.session;
            routine = matches.routine;
            month = matches.month;
            week = matches.week;
            workout = matches.workout;
            date = matches.date;
            /*
            routine =     [matches valueForKey:@"routine"];
            month =       [matches valueForKey:@"month"];
            week  =       [matches valueForKey:@"week"];
            workout =     [matches valueForKey:@"workout"];
            date =        [matches valueForKey:@"date"];
            */
            dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
            
            [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@\n",
                                       session, routine, month, week, workout, dateString]];
        }
    }
    
    NSString *tempExerciseName;
    NSString *tempWeightData;
    NSString *tempRepData;
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSNumber *roundConverted;
    int validRepFields;
    
    //  Add the workout name, reps and weight
    for (int i = 0; i < allTitleArray.count; i++) {
        
        tempExerciseName = allTitleArray[i];
        
        //  Add the title to the string
        [writeString appendString:[NSString stringWithFormat:@"%@\n", tempExerciseName]];
        validRepFields = 0;
        
        //  Add the reps to the string
        for (int round = 0; round < 6; round++) {
            
            roundConverted = [NSNumber numberWithInt:round];
            
            pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %@)",
                    currentSessionString,
                    routine,
                    workout,
                    tempExerciseName,
                    roundConverted,
                    workoutIndex];
            
            [fetchRequest setPredicate:pred];
            matches = nil;
            fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
            
            if ([fetchedOjectsArray count] >= 1) {
                
                //  Match found
                //matches = [fetchedOjectsArray objectAtIndex:0];
                matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
                
                tempRepData = matches.reps;
                //tempRepData = [matches valueForKey:@"reps"];
            }
            
            else {
                
                //  No match found
                
            }

            if (![tempRepData isEqualToString:@""]) {
                
                if (round != 5) {
                    
                    //  Add the data to the string with a "," after it
                    [writeString appendString:[NSString stringWithFormat:@"%@,", tempRepData]];
                }
                
                else {
                    
                    //  Last entry for the line so "," is not needed
                    //  Add a line break to the end of the line
                    [writeString appendString:[NSString stringWithFormat:@"%@\n", tempRepData]];
                }
                
                validRepFields++;
            }
            
            else {
                
                if (round == 5) {
                    
                    [writeString appendString:[NSString stringWithFormat:@"\n"]];
                }
            }
        }
        
            
        //  Add the weight line from the database
        for (int round = 0; round < validRepFields; round++) {
            
            roundConverted = [NSNumber numberWithInt:round];
            
            pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %@)",
                    currentSessionString,
                    routine,
                    workout,
                    tempExerciseName,
                    roundConverted,
                    workoutIndex];
            [fetchRequest setPredicate:pred];
            matches = nil;
            fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
            
            if ([fetchedOjectsArray count] >= 1) {
                
                //matches = [fetchedOjectsArray objectAtIndex:0];
                matches = fetchedOjectsArray[[fetchedOjectsArray count]-1];
                
                tempWeightData = matches.weight;
                //tempWeightData = [matches valueForKey:@"weight"];
                
                if (round != validRepFields -1) {
                    
                    //  Add  the data to the string with a "," after it
                    [writeString appendString:[NSString stringWithFormat:@"%@,", tempWeightData]];
                }
                
                else {
                    
                    //  Last entry for the line so "," is not needed
                    //  Add a line break to the end of the line
                    [writeString appendString:[NSString stringWithFormat:@"%@\n", tempWeightData]];
                }
            }
        }
    }
    
    //  Return the string
    return writeString;
}

- (void)sendEmail:(NSString*)csvString {
    
    // Create MailComposerViewController object.
    MFMailComposeViewController *mailComposer;
    mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    mailComposer.navigationBar.tintColor = [UIColor whiteColor];

    // Check to see if the device has at least 1 email account configured
    if ([MFMailComposeViewController canSendMail]) {

        NSData *csvData = [csvString dataUsingEncoding:NSASCIIStringEncoding];
        NSString *workoutName = ((DataNavController *)self.parentViewController).workout;
        workoutName = [workoutName stringByAppendingString:@".csv"];
        
        // Get the objects for the current session
        NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];

        // Fetch defaultEmail data.
        NSEntityDescription *entityDescEmail = [NSEntityDescription entityForName:@"Email" inManagedObjectContext:context];
        NSFetchRequest *requestEmail = [[NSFetchRequest alloc] init];
        [requestEmail setEntity:entityDescEmail];
        NSManagedObject *matches = nil;
        NSError *error = nil;
        NSArray *objects = [context executeFetchRequest:requestEmail error:&error];
        
        // Array to store the default email address.
        NSArray *emailAddresses;
        
        if ([objects count] != 0) {
            
            matches = objects[[objects count] - 1];
            
            // There is a default email address.
            emailAddresses = @[[matches valueForKey:@"defaultEmail"]];
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
}

- (void)sendCurrentSessionEmail:(NSString*)csvString {
    
    // Create MailComposerViewController object.
    MFMailComposeViewController *mailComposer;
    mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    mailComposer.navigationBar.tintColor = [UIColor whiteColor];
    
    // Check to see if the device has at least 1 email account configured
    if ([MFMailComposeViewController canSendMail]) {
        
        NSData *csvData = [csvString dataUsingEncoding:NSASCIIStringEncoding];
        NSString *csvTitle = @"CurrentSessionData";
        csvTitle = [csvTitle stringByAppendingString:@".csv"];
        
        // Get the objects for the current session
        NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
        
        // Fetch defaultEmail data.
        NSEntityDescription *entityDescEmail = [NSEntityDescription entityForName:@"Email" inManagedObjectContext:context];
        NSFetchRequest *requestEmail = [[NSFetchRequest alloc] init];
        [requestEmail setEntity:entityDescEmail];
        NSManagedObject *matches = nil;
        NSError *error = nil;
        NSArray *objects = [context executeFetchRequest:requestEmail error:&error];
        
        // Array to store the default email address.
        NSArray *emailAddresses;
        
        if ([objects count] != 0) {
            
            matches = objects[[objects count] - 1];
            
            // There is a default email address.
            emailAddresses = @[[matches valueForKey:@"defaultEmail"]];
        }
        else {
            
            // There is NOT a default email address.  Put an empty email address in the arrary.
            emailAddresses = @[@""];
        }
        
        [mailComposer setToRecipients:emailAddresses];
        
        // Fetch current session data.
        AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSString *currentSessionString = [mainAppDelegate getCurrentSession];
        NSString *emailSubject = [NSString stringWithFormat:@"90 DWT BB Session %@ Workout Data", currentSessionString];
        
        [mailComposer setSubject:emailSubject];
        [mailComposer addAttachmentData:csvData mimeType:@"text/csv" fileName:csvTitle];
        [self presentViewController:mailComposer animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
    }
}

- (void)sendAllSessionEmail:(NSString*)csvString {
    
    // Create MailComposerViewController object.
    MFMailComposeViewController *mailComposer;
    mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    mailComposer.navigationBar.tintColor = [UIColor whiteColor];
    
    // Check to see if the device has at least 1 email account configured
    if ([MFMailComposeViewController canSendMail]) {
        
        NSData *csvData = [csvString dataUsingEncoding:NSASCIIStringEncoding];
        NSString *csvTitle = @"AllSessionsData";
        csvTitle = [csvTitle stringByAppendingString:@".csv"];
        
        // Get the objects for the current session
        NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
        
        // Fetch defaultEmail data.
        NSEntityDescription *entityDescEmail = [NSEntityDescription entityForName:@"Email" inManagedObjectContext:context];
        NSFetchRequest *requestEmail = [[NSFetchRequest alloc] init];
        [requestEmail setEntity:entityDescEmail];
        NSManagedObject *matches = nil;
        NSError *error = nil;
        NSArray *objects = [context executeFetchRequest:requestEmail error:&error];
        
        // Array to store the default email address.
        NSArray *emailAddresses;
        
        if ([objects count] != 0) {
            
            matches = objects[[objects count] - 1];
            
            // There is a default email address.
            emailAddresses = @[[matches valueForKey:@"defaultEmail"]];
        }
        else {
            
            // There is NOT a default email address.  Put an empty email address in the arrary.
            emailAddresses = @[@""];
        }
        
        [mailComposer setToRecipients:emailAddresses];
        [mailComposer setSubject:@"90 DWT BB All Sessions Workout Data"];
        [mailComposer addAttachmentData:csvData mimeType:@"text/csv" fileName:csvTitle];
        [self presentViewController:mailComposer animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}













- (NSString*)currentSessionStringForEmail {
   
    // Get Data from the database.
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    NSArray *allWorkoutTitlesArray = [self allWorkoutTitleArray];
    NSArray *allExerciseTitlesArray = [self allExerciseTitleArray];
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
    
    NSArray *rountineArray = @[@"Bulk",
                               @"Tone"];
    
    for (int routineIndex = 0; routineIndex < rountineArray.count; routineIndex++) {
        
        for (int i = 0; i < allWorkoutTitlesArray.count; i++) {
            
            NSArray *tempExerciseTitlesArray = allExerciseTitlesArray[i];
            
            // Get workout data with the current session
            NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:entityDesc];
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@)",
                                 currentSessionString,
                                 rountineArray[routineIndex],
                                 allWorkoutTitlesArray[i]];
            [fetchRequest setPredicate:pred];
            Workout *matches = nil;
            NSError *error;
            NSArray *fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
            
            NSString *session;
            NSString *routine;
            NSString *month;
            NSString *week;
            NSString *workout;
            NSDate  *date;
            NSString *dateString;
            
            int maxIndex = [[self findMaxIndexValue:fetchedOjectsArray] intValue];
            
            NSString *tempExerciseName;
            NSString *tempWeightData;
            NSString *tempRepData;
            NSNumber *roundConverted;
            int validRepFields;
            
            // Get the values for each index that was found for this workout
            for (int index = 1; index <= maxIndex; index++) {
                
                // Add column headers
                for (int a = 0; a < 1; a++)
                {
                    
                    //  Add the column headers for Routine, Month, Week, Workout, and Date to the string
                    [writeString appendString:[NSString stringWithFormat:@"Session,Routine,Week,Try,Workout,Date\n"]];
                    
                    matches = fetchedOjectsArray[a];
                    
                    session = matches.session;
                    routine = matches.routine;
                    month = matches.month;
                    week = matches.week;
                    workout = matches.workout;
                    date = matches.date;
                    
                    dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
                    
                    // Add column headers for indivialual workouts based on workout index number
                    [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%i,%@,%@\n",
                                               session, routine, week, index, workout, dateString]];
                }

                NSNumber *workoutIndex = [NSNumber numberWithInt:index];
                
                //  Add the exercise name, reps and weight
                for (int b = 0; b < tempExerciseTitlesArray.count; b++) {
                    
                    tempExerciseName = tempExerciseTitlesArray[b];
                    
                    //  Add the exercise title to the string
                    [writeString appendString:[NSString stringWithFormat:@"%@\n", tempExerciseName]];
                    validRepFields = 0;
                    
                    //  Add the reps to the string
                    for (int round = 0; round < 6; round++) {
                        
                        roundConverted = [NSNumber numberWithInt:round];
                        
                        pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %@)",
                                currentSessionString,
                                routine,
                                workout,
                                tempExerciseName,
                                roundConverted,
                                workoutIndex];
                        
                        [fetchRequest setPredicate:pred];
                        matches = nil;
                        fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
                        
                        if ([fetchedOjectsArray count] >= 1) {
                            
                            //  Match found
                            //matches = [fetchedOjectsArray objectAtIndex:0];
                            matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
                            
                            tempRepData = matches.reps;
                            //tempRepData = [matches valueForKey:@"reps"];
                        }
                        
                        else {
                            
                            //  No match found
                            
                        }
                        
                        if (![tempRepData isEqualToString:@""]) {
                            
                            if (round != 5) {
                                
                                //  Add the data to the string with a "," after it
                                [writeString appendString:[NSString stringWithFormat:@"%@,", tempRepData]];
                            }
                            
                            else {
                                
                                //  Last entry for the line so "," is not needed
                                //  Add a line break to the end of the line
                                [writeString appendString:[NSString stringWithFormat:@"%@\n", tempRepData]];
                            }
                            
                            validRepFields++;
                        }
                        
                        else {
                            
                            if (round == 5) {
                                
                                [writeString appendString:[NSString stringWithFormat:@"\n"]];
                            }
                        }
                    }
                    
                    
                    //  Add the weight line from the database
                    for (int round = 0; round < validRepFields; round++) {
                        
                        roundConverted = [NSNumber numberWithInt:round];
                        
                        pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %@)",
                                currentSessionString,
                                routine,
                                workout,
                                tempExerciseName,
                                roundConverted,
                                workoutIndex];
                        [fetchRequest setPredicate:pred];
                        matches = nil;
                        fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
                        
                        if ([fetchedOjectsArray count] >= 1) {
                            
                            //matches = [fetchedOjectsArray objectAtIndex:0];
                            matches = fetchedOjectsArray[[fetchedOjectsArray count]-1];
                            
                            tempWeightData = matches.weight;
                            //tempWeightData = [matches valueForKey:@"weight"];
                            
                            if (round != validRepFields -1) {
                                
                                //  Add  the data to the string with a "," after it
                                [writeString appendString:[NSString stringWithFormat:@"%@,", tempWeightData]];
                            }
                            
                            else {
                                
                                //  Last entry for the line so "," is not needed
                                //  Add a line break to the end of the line
                                [writeString appendString:[NSString stringWithFormat:@"%@\n", tempWeightData]];
                            }
                        }
                    }
                }
            }
        }
    }
    
    //  Return the string
    return writeString;
}

- (NSString*)allSessionStringForEmail {
    
    // Get Data from the database.
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    
    NSArray *allWorkoutTitlesArray = [self allWorkoutTitleArray];
    NSArray *allExerciseTitlesArray = [self allExerciseTitleArray];
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
    
    NSArray *rountineArray = @[@"Bulk",
                               @"Tone"];
    
    // Get the highest session value stored in the database
    int maxSession = [[self findMaxSessionValue]intValue];
    
    // For each session, list each workouts data.  Bulk then tone.
    for (int session = 1; session <= maxSession; session++) {
        
        // Get session value.
        NSString *currentSessionString = [NSString stringWithFormat:@"%i", session];

        for (int routineIndex = 0; routineIndex < rountineArray.count; routineIndex++) {
            
            for (int i = 0; i < allWorkoutTitlesArray.count; i++) {
                
                NSArray *tempExerciseTitlesArray = allExerciseTitlesArray[i];
                
                // Get workout data with the current session
                NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                [fetchRequest setEntity:entityDesc];
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@)",
                                     currentSessionString,
                                     rountineArray[routineIndex],
                                     allWorkoutTitlesArray[i]];
                [fetchRequest setPredicate:pred];
                Workout *matches = nil;
                NSError *error;
                NSArray *fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
                
                NSString *session;
                NSString *routine;
                NSString *month;
                NSString *week;
                NSString *workout;
                NSDate  *date;
                NSString *dateString;
                
                int maxIndex = [[self findMaxIndexValue:fetchedOjectsArray] intValue];
                
                NSString *tempExerciseName;
                NSString *tempWeightData;
                NSString *tempRepData;
                NSNumber *roundConverted;
                int validRepFields;
                
                // Get the values for each index that was found for this workout
                for (int index = 1; index <= maxIndex; index++) {
                    
                    // Add column headers
                    for (int a = 0; a < 1; a++)
                    {
                        
                        //  Add the column headers for Routine, Month, Week, Workout, and Date to the string
                        [writeString appendString:[NSString stringWithFormat:@"Session,Routine,Week,Try,Workout,Date\n"]];
                        
                        matches = fetchedOjectsArray[a];
                        
                        session = matches.session;
                        routine = matches.routine;
                        month = matches.month;
                        week = matches.week;
                        workout = matches.workout;
                        date = matches.date;
                        
                        dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
                        
                        // Add column headers for indivialual workouts based on workout index number
                        [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%i,%@,%@\n",
                                                   session, routine, week, index, workout, dateString]];
                    }
                    
                    NSNumber *workoutIndex = [NSNumber numberWithInt:index];
                    
                    //  Add the exercise name, reps and weight
                    for (int b = 0; b < tempExerciseTitlesArray.count; b++) {
                        
                        tempExerciseName = tempExerciseTitlesArray[b];
                        
                        //  Add the exercise title to the string
                        [writeString appendString:[NSString stringWithFormat:@"%@\n", tempExerciseName]];
                        validRepFields = 0;
                        
                        //  Add the reps to the string
                        for (int round = 0; round < 6; round++) {
                            
                            roundConverted = [NSNumber numberWithInt:round];
                            
                            pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %@)",
                                    currentSessionString,
                                    routine,
                                    workout,
                                    tempExerciseName,
                                    roundConverted,
                                    workoutIndex];
                            
                            [fetchRequest setPredicate:pred];
                            matches = nil;
                            fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
                            
                            if ([fetchedOjectsArray count] >= 1) {
                                
                                //  Match found
                                //matches = [fetchedOjectsArray objectAtIndex:0];
                                matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
                                
                                tempRepData = matches.reps;
                                //tempRepData = [matches valueForKey:@"reps"];
                            }
                            
                            else {
                                
                                //  No match found
                                
                            }
                            
                            if (![tempRepData isEqualToString:@""]) {
                                
                                if (round != 5) {
                                    
                                    //  Add the data to the string with a "," after it
                                    [writeString appendString:[NSString stringWithFormat:@"%@,", tempRepData]];
                                }
                                
                                else {
                                    
                                    //  Last entry for the line so "," is not needed
                                    //  Add a line break to the end of the line
                                    [writeString appendString:[NSString stringWithFormat:@"%@\n", tempRepData]];
                                }
                                
                                validRepFields++;
                            }
                            
                            else {
                                
                                if (round == 5) {
                                    
                                    [writeString appendString:[NSString stringWithFormat:@"\n"]];
                                }
                            }
                        }
                        
                        
                        //  Add the weight line from the database
                        for (int round = 0; round < validRepFields; round++) {
                            
                            roundConverted = [NSNumber numberWithInt:round];
                            
                            pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %@)",
                                    currentSessionString,
                                    routine,
                                    workout,
                                    tempExerciseName,
                                    roundConverted,
                                    workoutIndex];
                            [fetchRequest setPredicate:pred];
                            matches = nil;
                            fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
                            
                            if ([fetchedOjectsArray count] >= 1) {
                                
                                //matches = [fetchedOjectsArray objectAtIndex:0];
                                matches = fetchedOjectsArray[[fetchedOjectsArray count]-1];
                                
                                tempWeightData = matches.weight;
                                //tempWeightData = [matches valueForKey:@"weight"];
                                
                                if (round != validRepFields -1) {
                                    
                                    //  Add  the data to the string with a "," after it
                                    [writeString appendString:[NSString stringWithFormat:@"%@,", tempWeightData]];
                                }
                                
                                else {
                                    
                                    //  Last entry for the line so "," is not needed
                                    //  Add a line break to the end of the line
                                    [writeString appendString:[NSString stringWithFormat:@"%@\n", tempWeightData]];
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    //  Return the string
    return writeString;
}

- (NSArray*)allExerciseTitleArray {
    
    // Get all the exercise names for each workout
    NSArray *b1_Back_Bi = @[@"Dumbbell Deadlift",
                         @"Dumbbell Pull-Over",
                         @"Pull-Up",
                         @"Curl Bar Row",
                         @"One-Arm Dumbbell Row",
                         @"Reverse Fly",
                         @"Close-Grip Chin-Up",
                         @"Seated Bicep Curl",
                         @"Hammer Curl",
                         @"Curl Bar Bicep Curl",
                         @"Superman to Airplane"];
    
    NSArray *b1_Chest_Tri = @[@"Dumbbell Chest Press",
                           @"Incline Dumbbell Fly",
                           @"Incline Dumbbell Press",
                           @"Close Grip Dumbbell Press",
                           @"Partial Dumbbell Fly",
                           @"Decline Push-Up",
                           @"Laying Tricep Extension",
                           @"Single Arm Tricep Kickback",
                           @"Diamond Push-Up",
                           @"Dips",
                           @"Abs"];

    NSArray *b1_Legs = @[@"Wide Squat",
                         @"Alt Lunge",
                         @"S-U to Reverse Lunge",
                         @"P Squat",
                         @"B Squat",
                         @"S-L Deadlift",
                         @"S-L Calf Raise",
                         @"S Calf Raise",
                         @"Abs"];

    NSArray *b1_Shoulders = @[@"Dumbbell Shoulder Press",
                              @"Dumbbell Lateral Raise",
                              @"Curl Bar Upright Row",
                              @"Curl Bar Underhand Press",
                              @"Front Raise",
                              @"Rear Fly",
                              @"Dumbbell Shrug",
                              @"Leaning Dumbbell Shrug",
                              @"6-Way Shoulder",
                              @"Abs"];

    NSArray *b2_Arms = @[@"Dumbbell Curl",
                         @"Seated Dumbbell Tricep Extension",
                         @"Curl Bar Curl",
                         @"Laying Curl Bar Tricep Extension",
                         @"Dumbbell Hammer Curl",
                         @"Leaning Dumbbell Tricep Extension",
                         @"Abs"];

    NSArray *b2_Back = @[@"Dumbbell Pull-Over",
                         @"Pull-Up",
                         @"Curl Bar Underhand Row",
                         @"One Arm Dumbbell Row",
                         @"Deadlift",
                         @"Reverse Fly",
                         @"Plank Row Arm Balance"];

    NSArray *b2_Chest = @[@"Incline Dumbbell Fly",
                          @"Incline Dumbbell Press 1",
                          @"Rotating Dumbbell Chest Press",
                          @"Incline Dumbbell Press 2",
                          @"Center Dumbbell Chest Press Fly",
                          @"Decline Push-Up",
                          @"Superman Airplane",
                          @"Russian Twist"];

    NSArray *b2_Legs = @[@"2-Way Lunge",
                         @"Dumbbell Squat",
                         @"2-Way Sumo Squat",
                         @"Curl Bar Split Squat",
                         @"S-L Deadlift",
                         @"Side to Side Squat",
                         @"S-L Calf Raise",
                         @"Abs"];

    NSArray *b2_Shoulders = @[@"Dumbbell Lateral Raise",
                              @"Dumbbell Arnold Press",
                              @"Curl Bar Upright Row",
                              @"One Arm Dumbbell Front Raise",
                              @"Two Arm Front Raise Rotate",
                              @"Reverse Fly",
                              @"Plank Opposite Arm Leg Raise",
                              @"Plank Crunch"];

    NSArray *b3_Ab_Workout = @[];

    NSArray *b3_Cardio = @[];

    NSArray *b3_Complete_Body = @[@"Pull-Up",
                                  @"Push-Up",
                                  @"Dumbbell Squat",
                                  @"Crunch",
                                  @"Dumbell Incline Press",
                                  @"Dumbell Bent-Over Row ",
                                  @"Dumbell Alt Reverse Lunge",
                                  @"Plank Crunch",
                                  @"3-Way Military Press",
                                  @"Single Arm Leaning Reverse Fly",
                                  @"S-L Deadlift",
                                  @"Russian Twist",
                                  @"Curl-Up Hammer-Down",
                                  @"Leaning Tricep Extension",
                                  @"Calf Raise",
                                  @"Side Sphinx Raise"];

    NSArray *t1_Back_Bi = @[@"Dumbbell Pull-Over",
                            @"Plank Hop",
                            @"Pull-Up",
                            @"Hanging Side-To-Side Crunch",
                            @"Curl Bar Row",
                            @"Curl Bar Twist",
                            @"Dumbbell Preacher Curl",
                            @"Hanging Crunch",
                            @"Curl Bar Multi Curl",
                            @"Mountain Climber"];

    NSArray *t1_Chest_Tri = @[@"Dumbbell Chest Press",
                              @"Crunch 1",
                              @"Incline Dumbbell Press",
                              @"Crunch 2",
                              @"Incline Dumbbell Fly",
                              @"Plank To Sphinx",
                              @"Curl Bar Tricep Extension",
                              @"Curl Bar Crunch",
                              @"Dumbbell Tricep Extension",
                              @"Dips",
                              @"Plank Crunch"];

    NSArray *rest = @[];

    NSArray *exerciseTitleArray = @[b1_Back_Bi,
                                    b1_Chest_Tri,
                                    b1_Legs,
                                    b1_Shoulders,
                                    b2_Arms,
                                    b2_Back,
                                    b2_Chest,
                                    b2_Legs,
                                    b2_Shoulders,
                                    b3_Ab_Workout,
                                    b3_Cardio,
                                    b3_Complete_Body,
                                    t1_Back_Bi,
                                    t1_Chest_Tri,
                                    rest];
    
    return exerciseTitleArray;
}

- (NSArray*)allWorkoutTitleArray {
    
    // Get all the workout titles
    NSArray *workoutTitleArray = @[@"B1: Back+Bi",
                                   @"B1: Chest+Tri",
                                   @"B1: Legs",
                                   @"B1: Shoulders",
                                   @"B2: Arms",
                                   @"B2: Back",
                                   @"B2: Chest",
                                   @"B2: Legs",
                                   @"B2: Shoulders",
                                   @"B3: Ab Workout",
                                   @"B3: Cardio",
                                   @"B3: Complete Body",
                                   @"T1: Back+Bi",
                                   @"T1: Chest+Tri",
                                   @"Rest"];
    
    return workoutTitleArray;
}

- (NSString*)findMaxSessionValue {
    
    // Workout Entity
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSError *error;
    Workout *matches;
    NSArray *fetchedOjectsArray = [context executeFetchRequest:request error:&error];
    
    int maxSession = 0;
    
    if ([fetchedOjectsArray count] != 0) {
        
        // Find max session value
        
        for (int i = 0; i < fetchedOjectsArray.count; i++)
        {
            matches = fetchedOjectsArray[i];
            
            int tempSession = [matches.session intValue];
            
            if (tempSession > maxSession) {
                
                // new maxSession
                maxSession = tempSession;
            }
        }
        
    } else {
        
        // No matches.  Set it to default value of 1.
        maxSession = 1;
    }
    
    NSString *maxSessionStringValue = [NSString stringWithFormat:@"%i", maxSession];
    
    return maxSessionStringValue;
}

- (NSString*)findMaxIndexValue :(NSArray*)fetchedObjects {
    
    NSArray *tempFetchedObjectsArray = fetchedObjects;
    Workout *matches;
    
    int maxIndex = 0;
    
    if ([tempFetchedObjectsArray count] != 0) {
        
        // Find max workout index value
        
        for (int i = 0; i < tempFetchedObjectsArray.count; i++)
        {
            matches = tempFetchedObjectsArray[i];
            
            int tempIndex = [matches.index intValue];
            
            if (tempIndex > maxIndex) {
                
                // new maxIndex
                maxIndex = tempIndex;
            }
        }
        
    } else {
        
        // No matches.  Set it to default value of 1.
        // maxIndex = 1;
    }
    
    NSString *maxIndexStringValue = [NSString stringWithFormat:@"%i", maxIndex];
    
    return maxIndexStringValue;
}
@end
