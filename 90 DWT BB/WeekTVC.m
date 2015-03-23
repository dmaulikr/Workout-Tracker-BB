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
    
    self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"weight_lifting_selected"];
    
    [self findDefaultWorkout];
    
    // Show or Hide Ads
    if ([[_0DWTBBIAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWTBB.removeads"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        self.canDisplayBannerAds = NO;
        
    } else {
        
        // Show the Banner Ad
        self.canDisplayBannerAds = YES;
    }
    
    /*
    // Configure tableview.
    NSArray *tableCell = @[self.cell1,
                            self.cell2,
                            self.cell3,
                            self.cell4,
                            self.cell5,
                            self.cell6,
                            self.cell7,
                            self.cell8,
                            self.cell9,
                            self.cell10,
                            self.cell11,
                            self.cell12];
    
    NSArray *accessoryIcon = @[@YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES];
    
    NSArray *cellColor = @[@NO,
                           @NO,
                           @NO,
                           @NO,
                           @NO,
                           @NO,
                           @NO,
                           @NO,
                           @NO,
                           @NO,
                           @NO,
                           @NO];

    [self configureTableView:tableCell :accessoryIcon :cellColor];
     */
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self findDefaultWorkout];
    
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
        cell.accessoryView = nil;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    }
    else {
        
        // Week was NOT completed so put the arrow as the accessory view icon
        UIImage* accessory = [UIImage imageNamed:@"nav_r_arrow_grey"];
        UIImageView* accessoryView = [[UIImageView alloc] initWithImage:accessory];
        cell.accessoryView = accessoryView;
    }
    
    return cell;
}

- (void)findDefaultWorkout
{
    // Get path to documents directory
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *defaultWorkoutFile = nil;
    defaultWorkoutFile = [docDir stringByAppendingPathComponent:@"Default Workout.out"];
    
    if  ([[NSFileManager defaultManager] fileExistsAtPath:defaultWorkoutFile]) {
        
        // File has already been created. Get value of routine from it.
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:defaultWorkoutFile];
        self.navigationItem.title = [[NSString alloc] initWithData:[fileHandle availableData] encoding:NSUTF8StringEncoding];
        [fileHandle closeFile];
        
        ((DataNavController *)self.parentViewController).routine = self.navigationItem.title;
    }
    
    else {
        
        // File has not been created so this is the first time the app has been opened or user has not changed workout.
        ((DataNavController *)self.parentViewController).routine = @"Bulk";
        self.navigationItem.title = ((DataNavController *)self.parentViewController).routine;
    }
    
    //NSLog(@"Routine = %@", ((DataNavController *)self.parentViewController).routine);
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    workoutSegueName = [workoutSegueName stringByAppendingFormat:@" %@", cellText];
    
    [self performSegueWithIdentifier:workoutSegueName sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[_0DWTBBIAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWTBB.removeads"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        
    } else {
        
        // Show the Interstitial Ad
        UIViewController *c = segue.destinationViewController;
        
        c.interstitialPresentationPolicy = ADInterstitialPresentationPolicyAutomatic;
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
        
        if (week == 11) {
            
            NSString *group1 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 2 || i == 3) {
                    
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
            
            if (workoutsCompleted == 8 && [group1 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 12) {
            
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
            
            if (workoutsCompleted == 6 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"] && [group3 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
    } else {
        
        // Tone
        if (week == 1) {
            
            NSString *group1 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 7 || i == 8) {
                    
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
        
        if (week == 2) {
            
            NSString *group1 = @"NO";
            NSString *group2 = @"NO";
            
            for (int i = 0; i < resultsArray.count; i++) {
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                if (i == 1 || i == 2) {
                    
                    if ([resultsArray[i] isEqualToString:@"YES"]) {
                        
                        group1 = @"YES";
                    }
                }
                
                // User has a choice to do 1 of 2 workouts.  Only needs to do 1.
                else if (i == 7 || i == 8) {
                    
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
        
        if (week == 3) {
            
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
            
            if (workoutsCompleted == 8) {
                
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
            
            if (workoutsCompleted == 6 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"] && [group3 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 10) {
            
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
        
        if (week == 11) {
            
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
            
            if (workoutsCompleted == 6 && [group1 isEqualToString:@"YES"] && [group2 isEqualToString:@"YES"] && [group3 isEqualToString:@"YES"]) {
                
                completed = YES;
                
            } else {
                
                completed = NO;
            }
        }
        
        if (week == 12) {
            
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
    }
    
    return completed;
}
@end
