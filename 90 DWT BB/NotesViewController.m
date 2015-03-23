//
//  NotesViewController.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/17/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "NotesViewController.h"
#import "90DWTBBIAPHelper.h"
//#import "SWRevealViewController.h"
#import "DatePickerViewController.h"

@interface NotesViewController ()

@end

@implementation NotesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self saveDataNavControllerToAppDelegate];
    
    [self updateWorkoutCompleteCell];
    
    [self configureViewForIOSVersion];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (index = %@)",
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         self.navigationItem.title,
                         ((DataNavController *)self.parentViewController).index];
    [fetchRequest setPredicate:pred];
    Workout *matches = nil;
    NSError *error;
    NSArray *fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSNumber *previousWorkoutIndex = @([workoutIndex integerValue] - 1);
    //NSLog(@"%@ index = %@", ((DataNavController *)self.parentViewController).workout, ((DataNavController *)self.parentViewController).index);
    
    // 1st time exercise is done only.
    if ([workoutIndex integerValue] == 1) {
        // The workout has not been done before.
        // Do NOT get previous workout data.
        
        if ([fetchedOjectsArray count] == 0) {
            //NSLog(@"viewDidLoad = No matches - Exercise has not been done before - set previous textfields to nil");
            
            self.currentNotes.text = @"Type any notes here";
            self.previousNotes.text = @"";
        }
        
        // The workout has been done 1 time but the user came back to the 1st week workout screen to update or view.
        // Only use the current 1st week workout data when the user comes back to this screen.
        
        else {
            //NSLog(@"viewDidLoad = Match found - set previous textfields to stored values for this weeks workout");
            
            matches = [fetchedOjectsArray objectAtIndex:0];
            
            self.currentNotes.text = @"";
            self.previousNotes.text = matches.notes;
        }
        
    }
    
    // 2nd time exercise has been done and beyond.
    else {
        // This workout with this index has been done before.
        // User came back to look at his results so display this weeks results in the current results section.
        
        if ([fetchedOjectsArray count] == 1) {
            
            matches = [fetchedOjectsArray objectAtIndex:0];
            
            self.currentNotes.text = matches.notes;
        }
        
        // This workout with this index has NOT been done befoe.
        // Set the current placeholders to defaults/nil.
        else {
            self.currentNotes.text = @"Type any notes here";
        }
        
        // This is at least the 2nd time a particular workout has been started.
        // Get the previous workout data and present it to the user in the previous section.
        
        pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (index = %@)",
                                                ((DataNavController *)self.parentViewController).routine,
                                                ((DataNavController *)self.parentViewController).workout,
                                                self.navigationItem.title,
                                                previousWorkoutIndex];  // Previous workout index.
        [fetchRequest setPredicate:pred];
        matches = nil;
        fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
        
        if ([fetchedOjectsArray count] == 1) {
            
            matches = [fetchedOjectsArray objectAtIndex:0];
            
            self.previousNotes.text = matches.notes;
        }
        
        else {
            
            self.previousNotes.text = @"No record for the last workout";
        }
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView setText:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [self viewDidLoad];
    
    [self updateWorkoutCompleteCell];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //  Save to the database
    [self submitEntry:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)submitEntry:(id)sender {
    NSDate *todaysDate = [NSDate date];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (index = %@)",
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         self.navigationItem.title,
                         ((DataNavController *)self.parentViewController).index];
    [fetchRequest setPredicate:pred];
    Workout *matches = nil;
    NSError *error;
    NSArray *fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedOjectsArray count] == 0) {
        //NSLog(@"submitEntry = No matches - create new record and save");
        
        Workout *newExercise;
        newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:context];
        
        newExercise.notes = self.currentNotes.text;
        newExercise.date =  todaysDate;
        newExercise.exercise = self.navigationItem.title;
        newExercise.routine = ((DataNavController *)self.parentViewController).routine;
        newExercise.month = ((DataNavController *)self.parentViewController).month;
        newExercise.week = ((DataNavController *)self.parentViewController).week;
        newExercise.workout = ((DataNavController *)self.parentViewController).workout;
        newExercise.index = ((DataNavController *)self.parentViewController).index;
        
    } else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        
        matches = [fetchedOjectsArray objectAtIndex:0];
        
        // Only update the fields that have been changed.
        if (self.currentNotes.text.length != 0) {
            
            matches.notes = self.currentNotes.text;
            //[matches setValue:self.currentNotes.text forKey:@"notes"];
        }
        
        matches.date = todaysDate;
        //[matches setValue:todaysDate forKey:@"date"];
        
    }
    
    [context save:&error];
    
    self.currentNotes.textColor = [UIColor grayColor];
    
    [self hideKeyboard:sender];
}

- (IBAction)hideKeyboard:(id)sender {
    [self.currentNotes resignFirstResponder];
}

- (IBAction)shareActionSheet:(UIBarButtonItem *)sender {
    
    // Save to Database
    [self submitEntry:self];
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email", @"Facebook", @"Twitter", nil];
    
    [action showFromBarButtonItem:sender animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self emailResults];
    }
    
    if (buttonIndex == 1) {
        [self facebook];
    }
    
    if (buttonIndex == 2) {
        [self twitter];
    }
}

- (void)configureViewForIOSVersion {
    
    // Colors
    UIColor *lightGrey = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f];
    //UIColor *midGrey = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0f];
    UIColor *darkGrey = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f];
    //UIColor* blueColor = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:255/255.0f alpha:1.0f];
    UIColor *lightGreyBlueColor = [UIColor colorWithRed:219/255.0f green:224/255.0f blue:234/255.0f alpha:1.0f];
    
    // Apply Text Colors
    self.currentNotesLabel.textColor = [UIColor orangeColor];
    
    self.previousNotesLabel.textColor = darkGrey;
    
    self.round.hidden = YES;
    
    // Apply Background Colors
    self.currentNotes.backgroundColor = [UIColor whiteColor];
    self.previousNotes.backgroundColor = lightGreyBlueColor;
    
    self.view.backgroundColor = lightGrey;
    //self.toolbar.backgroundColor = midGrey;
    
    // Apply Border to TextViews
    self.currentNotes.layer.borderWidth = 0.5f;
    self.currentNotes.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.currentNotes.layer.cornerRadius = 5;
    self.currentNotes.clipsToBounds = YES;
    
    self.previousNotes.layer.borderWidth = 0.5f;
    self.previousNotes.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.previousNotes.layer.cornerRadius = 5;
    self.previousNotes.clipsToBounds = YES;
     
    // Apply Keyboard Color
    self.currentNotes.keyboardAppearance = UIKeyboardAppearanceDark;
    
    // iOS 7 Style
    // Show or Hide Ads
    if ([[_0DWTBBIAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWTBB.removeads"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        self.canDisplayBannerAds = NO;
        
    } else {
        
        // Show the Banner Ad
        self.canDisplayBannerAds = YES;
    }
}

- (void)emailResults
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (index = %@)",
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         ((DataNavController *)self.parentViewController).index];
    [request setPredicate:pred];
    Workout *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
    
    if ([objects count] != 0)
    {
        // Get data from database
        
        [writeString appendString:[NSString stringWithFormat:@"Routine,Month,Week,Workout,Notes,Date\n"]];
        
        for (int i = 0; i < [objects count]; i++) {
            matches = objects[i];
            
            NSString *routine = matches.routine;
            NSString *month = matches.month;
            NSString *week  = matches.week;
            NSString *workout = matches.workout;
            NSString *notes = matches.notes;
            NSDate *date = matches.date;
            
            NSString *dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
            
            [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@\n",
                                       routine, month, week, workout, notes, dateString]];
        }
    }
    
    // Send email
    
    NSData *csvData = [writeString dataUsingEncoding:NSASCIIStringEncoding];
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

#pragma mark - Popover methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *destNav = segue.destinationViewController;
    
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (sysVer >= 8.0) {
        
        // iOS 8 or greater show popover of chart/grid
        
        // This is the important part
        UIPopoverPresentationController *popPC = destNav.popoverPresentationController;
        popPC.delegate = self;
        popPC.sourceView = sender;
        //popPC.sourceRect = sender.bounds;
        popPC.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    else {
        
        if ([[segue identifier] isEqualToString:@"showPush"]) {
            
            AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            destNav.title = mainAppDelegate.graphTitle;
        }
        
        if ([[segue identifier] isEqualToString:@"iOS7_ModalDatePicker"]) {
            
            // Put code here.
        }
        
        if ([[segue identifier] isEqualToString:@"iOS7_PopoverDatePicker"]) {
            
            // Put code here.
            ((UIStoryboardPopoverSegue *)segue).popoverController.delegate = self ;
        }
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    [self updateWorkoutCompleteCell];
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
    [self updateWorkoutCompleteCell];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}

- (IBAction)workoutCompletedToday:(UIButton *)sender {
    
    [self submitEntry:self];
    
    [self saveWorkoutComplete:[NSDate date]];
    
    [self updateWorkoutCompleteCell];
}

- (IBAction)workoutCompletedPrevious:(UIButton *)sender {
    
    [self submitEntry:self];
    
    
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (sysVer >= 8.0) {
        
        // iOS 8 or greater show popover of chart/grid
        [self performSegueWithIdentifier:@"iOS8_PopoverDatePicker" sender:sender];
        
    } else {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //  iOS 7 iPad and below show datepicker in popover
            [self performSegueWithIdentifier:@"iOS7_PopoverDatePicker" sender:sender];
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            // iOS 7 iPhone and below modally show the datepicker
            [self performSegueWithIdentifier:@"iOS7_ModalDatePicker" sender:sender];
        }
    }
}

- (IBAction)workoutCompletedDelete:(UIButton *)sender {
    
    [self submitEntry:self];
    
    [self deleteDate];
    
    [self updateWorkoutCompleteCell];
}

- (void)updateWorkoutCompleteCell {
    
    UIColor *orange = [UIColor colorWithRed:251/255.0f green:105/255.0f blue:55/255.0f alpha:1.0f];
    UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
    UIColor *red = [UIColor colorWithRed:178/255.0f green:42/255.0f blue:9/255.0f alpha:1.0f];
    
    UIColor *lightOrange = [UIColor colorWithRed:251/255.0f green:105/255.0f blue:55/255.0f alpha:0.75f];
    UIColor *lightGreen = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:0.75f];
    UIColor *lightRed = [UIColor colorWithRed:178/255.0f green:42/255.0f blue:9/255.0f alpha:0.75f];
    
    BOOL tempWorkoutCompleted = [self workoutCompleted];
    
    if (tempWorkoutCompleted == YES) {
        
        //  Workout Completed
        
        // Cell
        self.datePickerView.backgroundColor = [UIColor darkGrayColor];
        
        // Label
        self.dateLabel.text = [NSString stringWithFormat:@"Workout Completed: %@", [self getWorkoutCompletedDate]];
        self.dateLabel.textColor = [UIColor whiteColor];
    }
    else {
        
        // Workout Not Completed
        
        // Cell
        self.datePickerView.backgroundColor = [UIColor whiteColor];
        
        // Label
        self.dateLabel.text = @"Workout Completed: __/__/__";
        self.dateLabel.textColor = [UIColor blackColor];
    }
    
    // Delete Button
    self.deleteDateButton.tintColor = [UIColor whiteColor];
    self.deleteDateButton.backgroundColor = lightRed;
    self.deleteDateButton.layer.borderWidth = 1.0f;
    self.deleteDateButton.layer.borderColor = [red CGColor];
    self.deleteDateButton.layer.cornerRadius = 5;
    self.deleteDateButton.clipsToBounds = YES;
    
    // Today Button
    self.todayDateButton.tintColor = [UIColor whiteColor];
    self.todayDateButton.backgroundColor = lightGreen;
    self.todayDateButton.layer.borderWidth = 1.0f;
    self.todayDateButton.layer.borderColor = [green CGColor];
    self.todayDateButton.layer.cornerRadius = 5;
    self.todayDateButton.clipsToBounds = YES;
    
    // Previous Button
    self.previousDateButton.tintColor = [UIColor whiteColor];
    self.previousDateButton.backgroundColor = lightOrange;
    self.previousDateButton.layer.borderWidth = 1.0f;
    self.previousDateButton.layer.borderColor = [orange CGColor];
    self.previousDateButton.layer.cornerRadius = 5;
    self.previousDateButton.clipsToBounds = YES;
}

@end