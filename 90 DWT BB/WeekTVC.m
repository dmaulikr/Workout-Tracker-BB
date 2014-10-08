//
//  WeekTVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/11/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WeekTVC.h"

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
    
    [self findDefaultWorkout];
    
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
    UIImage* accessory = [UIImage imageNamed:@"nav_r_arrow_grey"];
    UIImageView* accessoryView = [[UIImageView alloc] initWithImage:accessory];
    cell.accessoryView = accessoryView;
    
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
    // Show the Interstitial Ad
    UIViewController *c = segue.destinationViewController;
    
    c.interstitialPresentationPolicy = ADInterstitialPresentationPolicyAutomatic;
}
@end
