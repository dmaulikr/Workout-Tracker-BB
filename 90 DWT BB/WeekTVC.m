//
//  WeekTVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/11/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WeekTVC.h"
#import "90DWTBBIAPHelper.h"

@interface WeekTVC ()

@end

@implementation WeekTVC

#define debug 0

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    // Respond to changes in underlying store
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI)
                                                 name:@"SomethingChanged"
                                               object:nil];

    self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"weight_lifting_selected"];
    
    // Show or Hide Ads
    if ([[_0DWTBBIAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWTBB.removeads"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        //self.canDisplayBannerAds = NO;
        
    } else {
        
        // Show the Banner Ad
        //self.canDisplayBannerAds = YES;
        
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            // iPhone
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"4046208fc4a74de38212426cf30fc747"
                                                        size:MOPUB_BANNER_SIZE];
            self.bannerSize = MOPUB_BANNER_SIZE;
            
        } else {
            
            // iPad
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"302f462a787f4f7fb4b9f1610af40697"
                                                        size:MOPUB_LEADERBOARD_SIZE];
            self.bannerSize = MOPUB_LEADERBOARD_SIZE;
            
        }
        
        self.adView.delegate = self;
        self.adView.frame = CGRectMake((self.view.bounds.size.width - self.bannerSize.width) / 2,
                                       self.bannerSize.height - self.bannerSize.height,
                                       self.bannerSize.width, self.bannerSize.height);
        
        [self.headerView addSubview:self.adView];
        
        [self.adView loadAd];
    }
    
    // Add a long press gesture recognizer
    //UILongPressGestureRecognizer *longPGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGRAction:)];
    self.longPGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGRAction:)];
    self.longPGR.minimumPressDuration = 1.0f;
    self.longPGR.allowableMovement = 10.0f;
    [self.tableView addGestureRecognizer:self.longPGR];
    
    [self convertPhotosToCoreData];
    [self convertMeasurementsToCoreData];
    [self convertSettingsToCoreData];
    [self addSession1ToExistingCoreDataObjects];
    [self findAutoLockSetting];
    
    [self findDefaultRoutine];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    // Show or Hide Ads
    if ([[_0DWTBBIAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWTBB.removeads"]) {
        
        // Don't show ads.
        self.tableView.tableHeaderView = nil;
        self.adView.delegate = nil;
        self.adView = nil;
        
    } else {
        
        // Show ads
        self.adView.hidden = YES;
    }

    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self findDefaultRoutine];
    
    // Show or Hide Ads
    if ([[_0DWTBBIAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWTBB.removeads"]) {
        
        // Don't show ads.
        self.tableView.tableHeaderView = nil;
        self.adView.delegate = nil;
        self.adView = nil;
        
    } else {
        
        // Show ads
        self.adView.frame = CGRectMake((self.view.bounds.size.width - self.bannerSize.width) / 2,
                                       self.bannerSize.height - self.bannerSize.height,
                                       self.bannerSize.width, self.bannerSize.height);
        self.adView.hidden = NO;
    }

    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSInteger rows = 0;
    
    //  Section 0 is the same for both Bulk and Tone routines.
    if (section == 0) {
        rows = 3;
    }

    //  Bulk
    if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"Bulk"]) {

        if (section == 1) {
            rows = 6;
        }
        
        else if (section == 2) {
            rows = 3;
        }
    }
    
    // Tone
    else {
        
        if (section == 1) {
            rows = 5;
        }
        
        else if (section == 2) {
            rows = 4;
        }
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"weekCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSInteger weekNum;
    
    // 1-3
    if (indexPath.section == 0) {
        weekNum = indexPath.row + 1;
    }
    
    // 4-8 or 4-9
    if (indexPath.section == 1) {
        weekNum = indexPath.row + 4;
    }
    
    if (indexPath.section == 2) {
        
        //  Bulk 10-12
        if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"Bulk"]) {
            weekNum = indexPath.row + 10;
        }
        
        else {
            weekNum = indexPath.row + 9;
        }
    }
    
    NSString *weekString = [NSString stringWithFormat:@"Week %ld", (long)weekNum];
    
    cell.textLabel.text = weekString;
    
    // Accessory view icon
    
    if  ([self weekCompleted:weekNum]) {
        
        // Week completed so put a checkmark as the accessoryview icon
        
        
        UIImage* accessoryCheckMark = [UIImage imageNamed:@"checkMark_orange_22"];
        UIImageView* accessoryView = [[UIImageView alloc] initWithImage:accessoryCheckMark];
        cell.accessoryView = accessoryView;
        
        
        /*
        cell.accessoryView = nil;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
         */

    }
    else {
        
        // Week was NOT completed so put the arrow as the accessory view icon
        UIImage* accessory = [UIImage imageNamed:@"nav_r_arrow_grey"];
        UIImageView* accessoryView = [[UIImageView alloc] initWithImage:accessory];
        cell.accessoryView = accessoryView;
    }
    
    return cell;
}

- (void)longPressGRAction:(UILongPressGestureRecognizer*)sender {
    
    if ([sender isEqual:self.longPGR]) {
     
        if (sender.state == UIGestureRecognizerStateBegan)
        {
            
            CGPoint p = [sender locationInView:self.tableView];
            
            self.indexPath = [self.tableView indexPathForRowAtPoint:p];
            
            // Only show the alertview if longpressed on a cell, not a section header.
            if (self.indexPath) {
                
                //NSLog(@"long press on table view at Section %d Row %d", indexPath.section, indexPath.row);
                
                // get affected cell
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
                
                NSString *tempMessage = [NSString stringWithFormat:@"Set the status for all %@-%@ workouts.", ((DataNavController *)self.parentViewController).routine, cell.textLabel.text];
                
                if ([UIAlertController class]) {
                    
                    // Use UIAlertController (iOS 8 and above)
                    UIAlertController *alertController = [UIAlertController
                                                          alertControllerWithTitle:@"Workout Status"
                                                          message:tempMessage
                                                          preferredStyle:UIAlertControllerStyleActionSheet];
                    
                    UIAlertAction *notCompletedAction = [UIAlertAction
                                                         actionWithTitle:@"Not Completed"
                                                         style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction *action) {
                                                             
                                                             self.request = @"Not Completed";
                                                             [self verifyAddDeleteRequestFromTableViewCell];
                                                         }];
                    
                    UIAlertAction *completedAction = [UIAlertAction
                                                      actionWithTitle:NSLocalizedString(@"Completed", @"Completed action")
                                                      style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                          self.request = @"Completed";
                                                          [self verifyAddDeleteRequestFromTableViewCell];
                                                      }];
                    
                    UIAlertAction *cancelAction = [UIAlertAction
                                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                                   style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action)
                                                   {
                                                       //NSLog(@"Cancel action");
                                                   }];
                    
                    [alertController addAction:notCompletedAction];
                    [alertController addAction:completedAction];
                    [alertController addAction:cancelAction];
                    
                    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
                    
                    if (popover)
                    {
                        popover.sourceView = cell;
                        popover.delegate = self;
                        popover.sourceRect = cell.bounds;
                        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
                    }
                    
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                
                else {
                    
                    // Use UIActionSheet (iOS 7 and below)
                    
                    NSString *tempMessage_iOS7 = [NSString stringWithFormat:@"Workout Status\n\n%@", tempMessage];
                    
                    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:tempMessage_iOS7
                                                                            delegate:self
                                                                   cancelButtonTitle:@"Cancel"
                                                              destructiveButtonTitle:@"Not Completed"
                                                                   otherButtonTitles:@"Completed", nil];
                    
                    // Action sheet from tableview Cell
                    actionSheet.tag = 100;
                    
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        
                        // In this case the device is an iPad.
                        //CGRect frame = [self.view convertRect:cell.bounds fromView:cell];
                        [actionSheet showFromRect:cell.bounds inView:cell animated:YES];
                    }
                    else{
                        
                        // In this case the device is an iPhone/iPod Touch.
                        [actionSheet showInView:self.view];
                    }
                }

            }
        }
    }
 }

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 100) {
        
        // Action sheet from tableview Cell
        
        if (buttonIndex == 0) {
            
            // Not Completed
            //NSLog(@"Not Completed");
            
            self.request = @"Not Completed";
            [self verifyAddDeleteRequestFromTableViewCell];
        }
        
        else if (buttonIndex == 1) {
            
            // Completed
            //NSLog(@"Completed");
            
            self.request = @"Completed";
            [self verifyAddDeleteRequestFromTableViewCell];
        }
        
        else {
            
            // Cancel
            //NSLog(@"Cancel");
        }
    }
    
    else if (actionSheet.tag == 200) {
        
        // Action sheet from a barbuttonitem
        
        if (buttonIndex == 0) {
            
            // Not Completed
            //NSLog(@"Not Completed");
            
            self.request = @"Not Completed";
            [self verifyAddDeleteRequestFromBarButtonItem];
        }
        
        else if (buttonIndex == 1) {
            
            // Completed
            //NSLog(@"Completed");
            
            self.request = @"Completed";
            [self verifyAddDeleteRequestFromBarButtonItem];
        }
        
        else {
            
            // Cancel
            //NSLog(@"Cancel");
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 100) {
        
        // Alert View for a tableview Cell
        
        if (buttonIndex == 0) {
            
            // Cancel
            //NSLog(@"Cancel");
        }
        
        else if (buttonIndex == 1) {
            
            // Yes
            //NSLog(@"Yes");
            
            [self AddDeleteDatesFromOneWeek];
            [self.tableView reloadData];
        }
    }
    
    else if (alertView.tag == 200) {
        
        // Alert View for a barbuttonitem
        
        if (buttonIndex == 0) {
            
            // Cancel
            //NSLog(@"Cancel");
        }
        
        else if (buttonIndex == 1) {
            
            // Yes
            //NSLog(@"Yes");
            
            [self AddDeleteDatesFromAllWeeks];
            [self.tableView reloadData];
        }
    }
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
    
    NSString *tempMessage = [NSString stringWithFormat:@"Set the status for every week of %@ workouts.", ((DataNavController *)self.parentViewController).routine];
    
    if ([UIAlertController class]) {
        
        // Use UIAlertController (iOS 8 and above)
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Workout Status"
                                              message:tempMessage
                                              preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *notCompletedAction = [UIAlertAction
                                             actionWithTitle:@"Not Completed"
                                             style:UIAlertActionStyleDestructive
                                             handler:^(UIAlertAction *action) {
                                                 
                                                 self.request = @"Not Completed";
                                                 [self verifyAddDeleteRequestFromBarButtonItem];
                                             }];
        
        UIAlertAction *completedAction = [UIAlertAction
                                          actionWithTitle:NSLocalizedString(@"Completed", @"Completed action")
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *action) {
                                              
                                              self.request = @"Completed";
                                              [self verifyAddDeleteRequestFromBarButtonItem];
                                          }];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           //NSLog(@"Cancel action");
                                       }];
        
        [alertController addAction:notCompletedAction];
        [alertController addAction:completedAction];
        [alertController addAction:cancelAction];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        
        if (popover)
        {
            popover.barButtonItem = sender;
            popover.sourceView = self.view;
            popover.delegate = self;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    else {
        
        // Use UIAlertView (iOS 7 and below)
        NSString *tempMessage_iOS7 = [NSString stringWithFormat:@"Workout Status\n\n%@", tempMessage];
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:tempMessage_iOS7
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                  destructiveButtonTitle:@"Not Completed"
                                                       otherButtonTitles:@"Completed", nil];
        
        // Action sheet from barbuttonitem
        actionSheet.tag = 200;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            // In this case the device is an iPad.
            //CGRect frame = [self.view convertRect:cell.bounds fromView:cell];
            [actionSheet showFromBarButtonItem:sender animated:YES];
        }
        else{
            
            // In this case the device is an iPhone/iPod Touch.
            [actionSheet showInView:self.view];
        }
    }
}

- (void)AddDeleteDatesFromOneWeek {
    
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // ***DELETE***
    
    if ([self.request isEqualToString:@"Not Completed"]) {
        
        // Bulk
        if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"Bulk"]) {
            
            NSArray *nameArray = mainAppDelegate.build_WorkoutNameArray[self.position];
            NSArray *indexArray = mainAppDelegate.build_WorkoutIndexArray[self.position];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self deleteDateWithArguments:indexArray[i] :((DataNavController *)self.parentViewController).routine :nameArray[i]];
            }
        }
        else {
            
            // Tone
            NSArray *nameArray = mainAppDelegate.tone_WorkoutNameArray[self.position];
            NSArray *indexArray = mainAppDelegate.tone_WorkoutIndexArray[self.position];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self deleteDateWithArguments:indexArray[i] :((DataNavController *)self.parentViewController).routine :nameArray[i]];
            }
        }
    }
    
    else {
        
        // ***ADD***
        
        // Bulk
        if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"Bulk"]) {
            
            NSArray *nameArray = mainAppDelegate.build_WorkoutNameArray[self.position];
            NSArray *indexArray = mainAppDelegate.build_WorkoutIndexArray[self.position];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self saveWorkoutCompleteWithArguments:indexArray[i] :((DataNavController *)self.parentViewController).routine :nameArray[i]];
            }
        }
        else {
            
            // Tone
            NSArray *nameArray = mainAppDelegate.tone_WorkoutNameArray[self.position];
            NSArray *indexArray = mainAppDelegate.tone_WorkoutIndexArray[self.position];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self saveWorkoutCompleteWithArguments:indexArray[i] :((DataNavController *)self.parentViewController).routine :nameArray[i]];
            }
        }
    }
}

- (void)AddDeleteDatesFromAllWeeks {
    
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // ***DELETE***
    
    if ([self.request isEqualToString:@"Not Completed"]) {
        
        // Bulk
        if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"Bulk"]) {
            
            for (int i = 0; i < mainAppDelegate.build_WorkoutNameArray.count; i++) {
                
                NSArray *nameArray = mainAppDelegate.build_WorkoutNameArray[i];
                NSArray *indexArray = mainAppDelegate.build_WorkoutIndexArray[i];
                
                for (int j = 0; j < nameArray.count; j++) {
                    
                    [self deleteDateWithArguments:indexArray[j] :((DataNavController *)self.parentViewController).routine :nameArray[j]];
                }
            }
        }
        else {
            
            // Tone
            for (int i = 0; i < mainAppDelegate.tone_WorkoutNameArray.count; i++) {
                
                NSArray *nameArray = mainAppDelegate.tone_WorkoutNameArray[i];
                NSArray *indexArray = mainAppDelegate.tone_WorkoutIndexArray[i];
                
                for (int j = 0; j < nameArray.count; j++) {
                    
                    [self deleteDateWithArguments:indexArray[j] :((DataNavController *)self.parentViewController).routine :nameArray[j]];
                }
            }
        }
    }
    
    else {
        
        // ***ADD***
        
        // Bulk
        if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"Bulk"]) {
            
            for (int i = 0; i < mainAppDelegate.build_WorkoutNameArray.count; i++) {
                
                NSArray *nameArray = mainAppDelegate.build_WorkoutNameArray[i];
                NSArray *indexArray = mainAppDelegate.build_WorkoutIndexArray[i];
                
                for (int j = 0; j < nameArray.count; j++) {
                    
                    [self saveWorkoutCompleteWithArguments:indexArray[j] :((DataNavController *)self.parentViewController).routine :nameArray[j]];
                }
            }
        }
        else {
            
            // Tone
            for (int i = 0; i < mainAppDelegate.tone_WorkoutNameArray.count; i++) {
                
                NSArray *nameArray = mainAppDelegate.tone_WorkoutNameArray[i];
                NSArray *indexArray = mainAppDelegate.tone_WorkoutIndexArray[i];
                
                for (int j = 0; j < nameArray.count; j++) {
                    
                    [self saveWorkoutCompleteWithArguments:indexArray[j] :((DataNavController *)self.parentViewController).routine :nameArray[j]];
                }
            }
        }
    }
}

- (void)verifyAddDeleteRequestFromTableViewCell {
    
    // get affected cell
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
    
    self.position = [self findArrayPosition:self.indexPath];
    
    NSString *tempMessage = [NSString stringWithFormat:@"You are about to set the status for all %@-%@ workouts to:\n\n%@\n\nDo you want to proceed?", ((DataNavController *)self.parentViewController).routine, cell.textLabel.text, self.request];
    
    if ([UIAlertController class]) {
        
        // Use UIAlertController (iOS 8 and above)
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Warning"
                                              message:tempMessage
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yesAction = [UIAlertAction
                                             actionWithTitle:@"Yes"
                                             style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
                                                 
                                                 [self AddDeleteDatesFromOneWeek];
                                                 
                                                 [self.tableView reloadData];
                                                 
                                                 //NSLog(@"Not Completed action");
                                                 //NSLog(@"Position = %ld", (long)self.position);
                                             }];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           //NSLog(@"Cancel action");
                                       }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:yesAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    else {
        
        // Use UIAlertView (iOS 7 and below)
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                            message:tempMessage
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Yes", nil];
        alertView.tag = 100;
        
        [alertView show];
    }
}

- (void)verifyAddDeleteRequestFromBarButtonItem {
    
    NSString *tempMessage = [NSString stringWithFormat:@"You are about to set the status for every week of the %@ workout to:\n\n%@\n\nDo you want to proceed?", ((DataNavController *)self.parentViewController).routine, self.request];
    
    if ([UIAlertController class]) {
        
        // Use UIAlertController (iOS 8 and above)
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Warning"
                                              message:tempMessage
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yesAction = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action) {
                                        
                                        [self AddDeleteDatesFromAllWeeks];
                                        
                                        [self.tableView reloadData];
                                    }];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           //NSLog(@"Cancel action");
                                       }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:yesAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    else {
        
        // Use UIAlertView (iOS 7 and below)
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                            message:tempMessage
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Yes", nil];
        
        alertView.tag = 200;
        
        [alertView show];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *workoutSegueName = self.navigationItem.title;
    
    if ([self.navigationItem.title isEqualToString:@"Bulk"]) {
        
        // Month 1
        if (indexPath.section == 0) {
            
            ((DataNavController *)self.parentViewController).month = @"Month 1";
        }

        // Month 2
        else if (indexPath.section == 1) {
            
            ((DataNavController *)self.parentViewController).month = @"Month 2";
        }
        
        // Month 3
        else if (indexPath.section == 2) {
            
            ((DataNavController *)self.parentViewController).month = @"Month 3";
        }
    }
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.textLabel.text;
    
    ((DataNavController *)self.parentViewController).week = cellText;
    mainAppDelegate.weekArrayPositionValue = [self findArrayPosition:indexPath];
    workoutSegueName = [workoutSegueName stringByAppendingFormat:@" %@", cellText];
    
    [self performSegueWithIdentifier:workoutSegueName sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[_0DWTBBIAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWTBB.removeads"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        
    } else {
        
        // Show the Interstitial Ad
        //UIViewController *c = segue.destinationViewController;
        
        //c.interstitialPresentationPolicy = ADInterstitialPresentationPolicyAutomatic;
    }
}

- (BOOL)weekCompleted:(NSInteger)week {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *tempWorkoutNameArray;
    NSArray *tempWorkoutIndexArray;
    NSMutableArray *resultsArray;
    resultsArray = [[NSMutableArray alloc] init];
    
    if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"Bulk"]) {
        
        // Get Build Workout Arrays
        tempWorkoutNameArray = appDelegate.build_WorkoutNameArray[week - 1];
        tempWorkoutIndexArray = appDelegate.build_WorkoutIndexArray[week - 1];
        
    } else {
    
        // Get Tone Workout Arrays
        tempWorkoutNameArray = appDelegate.tone_WorkoutNameArray[week - 1];
        tempWorkoutIndexArray = appDelegate.tone_WorkoutIndexArray[week - 1];
    }
    
    for (int i = 0; i < tempWorkoutIndexArray.count; i++) {
        
        if ([self workoutCompletedWithArguments:tempWorkoutIndexArray[i] :((DataNavController *)self.parentViewController).routine :tempWorkoutNameArray[i] ]) {
            
            // Workout Completed
            [resultsArray insertObject:@"YES" atIndex:i];
            
        } else {
            
            // Workout NOT Completed
            [resultsArray insertObject:@"NO" atIndex:i];
        }
    }
    
    int workoutsCompleted = 0;
    BOOL completed = NO;
    
    // Complete when the week ones are finished
    if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"Bulk"]) {
        
        // Bulk
        if (week == 1) {
            
            NSString *group1 = @"NO";
            NSString *group2 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 4 || i == 5) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 8 || i == 9) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group2 = @"YES";
                    }
                    
                } else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 6 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 2) {
            
            NSString *group1 = @"NO";
            NSString *group2 = @"NO";
            NSString *group3 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 1 || i == 2) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 6 || i == 7) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group2 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 9 || i == 10) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group3 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 5 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"] && [group3 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 3) {
            
            NSString *group1 = @"NO";
            NSString *group2 = @"NO";
            NSString *group3 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 3 || i == 4) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 6 || i == 7) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group2 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 10 || i == 11) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group3 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 7 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"] && [group3 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 4) {
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User needs to do all these workouts
                if ([resultsArray[i] isEqualToString:@"YES"]) {
                    
                    workoutsCompleted++;
                }
            }
            
            if (workoutsCompleted == 8) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 5) {
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User needs to do all these workouts
                if ([resultsArray[i] isEqualToString:@"YES"]) {
                    
                    workoutsCompleted++;
                }
            }
            
            if (workoutsCompleted == 8) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 6) {
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User needs to do all these workouts
                if ([resultsArray[i] isEqualToString:@"YES"]) {
                    
                    workoutsCompleted++;
                }
            }
            
            if (workoutsCompleted == 8) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 7) {
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User needs to do all these workouts
                if ([resultsArray[i] isEqualToString:@"YES"]) {
                    
                    workoutsCompleted++;
                }
            }
            
            if (workoutsCompleted == 9) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 8) {
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User needs to do all these workouts
                if ([resultsArray[i] isEqualToString:@"YES"]) {
                    
                    workoutsCompleted++;
                }
            }
            
            if (workoutsCompleted == 8) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 9) {
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User needs to do all these workouts
                if ([resultsArray[i] isEqualToString:@"YES"]) {
                    
                    workoutsCompleted++;
                }
            }
            
            if (workoutsCompleted == 8) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 10) {
            
            NSString *group1 = @"NO";
            NSString *group2 = @"NO";
            NSString *group3 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 0 || i == 1) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 3 || i == 4) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group2 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 5 || i == 6) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group3 = @"YES";
                    }
                    
                } else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 5 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"] && [group3 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 11) {
            
            NSString *group1 = @"NO";
            NSString *group2 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 2 || i == 3) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 9 || i == 10) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group2 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 7 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 12) {
            
            NSString *group1 = @"NO";
            NSString *group2 = @"NO";
            NSString *group3 = @"NO";
            NSString *group4 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 0 || i == 1) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 3 || i == 4) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group2 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 7 || i == 8) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group3 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 10 || i == 11) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group4 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 5 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"] && [group3 isEqualToString:@"YES"] && [group4 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
    } else {
        
        // Tone
        if (week == 1) {
            
            NSString *group1 = @"NO";
            NSString *group2 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 3 || i == 4) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 8 || i == 9) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group2 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 6 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 2) {
            
            NSString *group1 = @"NO";
            NSString *group2 = @"NO";
            NSString *group3 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 1 || i == 2) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 3 || i == 4) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group2 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 8 || i == 9) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group3 = @"YES";
                    }
                    
                } else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 5 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"] && [group3 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 3) {
            
            NSString *group1 = @"NO";
            NSString *group2 = @"NO";
            NSString *group3 = @"NO";
            NSString *group4 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 0 || i == 1) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 2 || i == 3) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group2 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 7 || i == 8) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group3 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 10 || i == 11) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group4 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 4 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"] && [group3 isEqualToString:@"YES"] && [group4 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 4) {
            
            NSString *group1 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 3 || i == 4) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }

                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 7 && [group1 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 5) {
            
            NSString *group1 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 3 || i == 4) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 7 && [group1 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 6) {
            
            NSString *group1 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 3 || i == 4) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 7 && [group1 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 7) {
            
            NSString *group1 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 3 || i == 4) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 7 && [group1 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 8) {
            
            NSString *group1 = @"NO";

            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 3 || i == 4) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 7 && [group1 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 9) {
            
            NSString *group1 = @"NO";
            NSString *group2 = @"NO";
            NSString *group3 = @"NO";
            NSString *group4 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 0 || i == 1) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 3 || i == 4) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group2 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 5 || i == 6) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group3 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 10 || i == 11) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group4 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 5 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"] && [group3 isEqualToString:@"YES"] && [group4 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 10) {
            
            NSString *group1 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 5 || i == 6) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                else {
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 7 && [group1 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 11) {
            
            NSString *group1 = @"NO";
            NSString *group2 = @"NO";
            NSString *group3 = @"NO";
            NSString *group4 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 0 || i == 1) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 3 || i == 4) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group2 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 5 || i == 6) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group3 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 10 || i == 11) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group4 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 5 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"] && [group3 isEqualToString:@"YES"] && [group4 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 12) {
            
            NSString *group1 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 5 || i == 6) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                else {
                    
                    // User needs to do all these workouts
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        workoutsCompleted++;
                    }
                }
            }
            
            if (workoutsCompleted == 7 && [group1 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
    }
    
    return completed;
}

#pragma mark - Popover methods

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    //[self updateWorkoutCompleteCell];
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
    //[self updateWorkoutCompleteCell];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}

- (NSInteger)findArrayPosition:(NSIndexPath*)indexPath {
    
    //NSInteger tempSection = indexPath.section;
    //NSInteger tempRow = indexPath.row;
    
    NSInteger position = 0;
    
    for (int i = 0; i <= indexPath.section; i++) {
        
        if (i == indexPath.section) {
            
            position = position + (indexPath.row + 1);
        }
        
        else {
            
            NSInteger totalRowsInSection = [self.tableView numberOfRowsInSection:i];
        
            position = position + totalRowsInSection;
        }
    }
    
    return position - 1;
}

#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adViewDidLoadAd:(MPAdView *)view
{
    CGSize size = [view adContentViewSize];
    CGFloat centeredX = (self.view.bounds.size.width - size.width) / 2;
    CGFloat bottomAlignedY = self.bannerSize.height - size.height;
    view.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
    
    if (self.headerView.frame.size.height == 0) {
        
        // No ads shown yet.  Animate showing the ad.
        CGRect headerViewFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.bannerSize.height);
        
        [UIView animateWithDuration:0.25 animations:^{ self.headerView.frame = headerViewFrame;
            self.tableView.tableHeaderView = self.headerView;
            self.adView.hidden = YES;}
         
                         completion:^(BOOL finished) {self.adView.hidden = NO;
                         }];
        
    } else {
        
        // Ad is already showing.
        self.tableView.tableHeaderView = self.headerView;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    
    self.adView.hidden = YES;
    [self.adView rotateToOrientation:toInterfaceOrientation];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGSize size = [self.adView adContentViewSize];
    CGFloat centeredX = (self.view.bounds.size.width - size.width) / 2;
    CGFloat bottomAlignedY = self.headerView.bounds.size.height - size.height;
    self.adView.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
    
    self.adView.hidden = NO;
}

- (void)findDefaultRoutine {
    
    // Fetch defaultRoutine objects
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Routine" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] != 0) {
        
        // Object has already been created. Get value of routine from it.
        matches = objects[[objects count] - 1];
        self.navigationItem.title = [matches valueForKey:@"defaultRoutine"];
        ((DataNavController *)self.parentViewController).routine = self.navigationItem.title;
    }
    else {
        
        // Object has not been created so this is the first time the app has been opened.
        ((DataNavController *)self.parentViewController).routine = @"Bulk";
        self.navigationItem.title = ((DataNavController *)self.parentViewController).routine;
    }
}

- (void)findAutoLockSetting {
    
    // Fetch useBands objects
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"AutoLock" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    NSString *coredataAutoLockSetting;
    
    if ([objects count] != 0) {
        
        // Object has already been created. Get value of autolock from it.
        matches = objects[[objects count] - 1];
        
        coredataAutoLockSetting = [matches valueForKey:@"useAutoLock"];
    }
    
    else {
        
        // No matches.
        if (debug==1) {
            NSLog(@"No match found");
        }
        
        // Default setting is OFF
        coredataAutoLockSetting = @"OFF";
    }
    
    if ([coredataAutoLockSetting isEqualToString:@"ON"]) {
        
        // User wants to disable the autolock timer.
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
    
    else {
        // User doesn't want to disable the autolock timer.
        [UIApplication sharedApplication].idleTimerDisabled = NO;
    }
}

- (void)updateUI {
    
    if ([CoreDataHelper sharedHelper].iCloudStore) {
        
        [self performSelector:@selector(updateTableView) withObject:nil afterDelay:5.0 ];
    }
    else {

        [self findDefaultRoutine];
        [self findAutoLockSetting];
    }
}

- (void)updateTableView {
    
    [self findDefaultRoutine];
    [self findAutoLockSetting];
    [self.tableView reloadData];
}
@end
