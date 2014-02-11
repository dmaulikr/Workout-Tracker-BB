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
    NSString *selectedWeek = @"Week";
    
    if ([self.navigationItem.title isEqualToString:@"Bulk"]) {
        
        // Month 1
        if (indexPath.section == 0) {
            
            ((DataNavController *)self.parentViewController).month = @"Month 1";
            
            // Get current week 1-3
            for (int i = 0; i < 3; i++) {
                
                if (indexPath.row == i) {
                    
                    selectedWeek = [selectedWeek stringByAppendingFormat:@" %d", i + 1];
                }
            }
        }

        // Month 2
        else if (indexPath.section == 1) {
            
            ((DataNavController *)self.parentViewController).month = @"Month 2";
            
            // Get current week 4-9
            for (int i = 0; i < 6; i++) {
                
                if (indexPath.row == i) {
                    
                    selectedWeek = [selectedWeek stringByAppendingFormat:@" %d", i + 4];
                }
            }
        }
        
        // Month 3
        else if (indexPath.section == 2) {
            
            ((DataNavController *)self.parentViewController).month = @"Month 3";
            
            // Get current week 10-12
            for (int i = 0; i < 3; i++) {
                
                if (indexPath.row == i) {
                    
                    selectedWeek = [selectedWeek stringByAppendingFormat:@" %d", i + 10];
                }
            }
        }
    }
    
    ((DataNavController *)self.parentViewController).week = selectedWeek;
}
@end
