//
//  Tone_9_TVC.m
//  90 DWT BB
//
//  Created by Grant, Jared on 2/13/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "Tone_9_TVC.h"
#import "90DWTBBIAPHelper.h"
#import <iAd/iAd.h>

@interface Tone_9_TVC ()

@end

@implementation Tone_9_TVC

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
    
    [self LoadArray];
    
    [self configureCellBox:self.cellBoxArray];
    
    [self configureAccessoryIconWorkoutList:self.tableCellArray];
    
    [self configureWorkoutLabels:self.tableLabelArray :self.tableDetailArray];

    // Show or Hide Ads
    if ([[_0DWTBBIAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWTBB.removeads"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        self.canDisplayBannerAds = NO;
        
    } else {
        
        // Show the Banner Ad
        self.canDisplayBannerAds = YES;
    }
    
    // Add rightBarButtonItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed:)];
    
    // Add a long press gesture recognizer
    UILongPressGestureRecognizer *longPGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGRAction:)];
    longPGR.minimumPressDuration = 1.0f;
    longPGR.allowableMovement = 10.0f;
    [self.tableView addGestureRecognizer:longPGR];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [self configureAccessoryIconWorkoutList:self.tableCellArray];
}

- (void)LoadArray {
    
    self.cellBoxArray = @[self.cell1Box,
                          self.cell2Box,
                          self.cell3Box,
                          self.cell4Box,
                          self.cell5Box,
                          self.cell6Box,
                          self.cell7Box,
                          self.cell8Box,
                          self.cell9Box,
                          self.cell10Box,
                          self.cell11Box,
                          self.cell12Box];
    
    self.tableCellArray = @[self.cell1,
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
    
    self.tableLabelArray = @[self.cell1Label,
                             self.cell2Label,
                             self.cell3Label,
                             self.cell4Label,
                             self.cell5Label,
                             self.cell6Label,
                             self.cell7Label,
                             self.cell8Label,
                             self.cell9Label,
                             self.cell10Label,
                             self.cell11Label,
                             self.cell12Label];
    
    self.tableDetailArray = @[self.cell1Detail,
                              self.cell2Detail,
                              self.cell4Detail,
                              self.cell5Detail,
                              self.cell10Detail,
                              self.cell11Detail];
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedRoutine = ((DataNavController *)self.parentViewController).routine;
    NSString *week = ((DataNavController *)self.parentViewController).week;
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSArray *workoutArray;
    
    workoutArray = @[@"B1: Chest+Tri",
                     @"T1: Chest+Tri",
                     @"B2: Legs",
                     @"B1: Back+Bi",
                     @"T1: Back+Bi",
                     @"B3: Cardio",
                     @"B3: Ab Workout",
                     @"B1: Shoulders",
                     @"Rest",
                     @"B3: Cardio",
                     @"B3: Complete Body",
                     @"B3: Ab Workout"];
    
    ((DataNavController *)self.parentViewController).workout = workoutArray[selectedCell.tag - 1];
    
    // Normal routine
    if ([selectedRoutine isEqualToString:@"Tone"]) {
        
        // Week 9
        if ([week isEqualToString:@"Week 9"]) {
            
            if (selectedCell.tag == 1) {
                
                // B1: Chest+Tri
                ((DataNavController *)self.parentViewController).index = @5;
            }
            
            else if (selectedCell.tag == 2) {
                
                // T1: Chest+Tri
                ((DataNavController *)self.parentViewController).index = @4;
            }
            
            else if (selectedCell.tag == 3) {
                
                // B2: Legs
                ((DataNavController *)self.parentViewController).index = @6;
            }
            
            else if (selectedCell.tag == 4) {
                
                // B1: Back+Bi
                ((DataNavController *)self.parentViewController).index = @5;
            }
            
            else if (selectedCell.tag == 5) {
                
                // T1: Back+Bi
                ((DataNavController *)self.parentViewController).index = @4;
            }
            
            else if (selectedCell.tag == 6) {
                
                // B3: Cardio
                ((DataNavController *)self.parentViewController).index = @9;
            }
            
            else if (selectedCell.tag == 7) {
                
                // B3: Ab Workout
                ((DataNavController *)self.parentViewController).index = @9;
            }
            
            else if (selectedCell.tag == 8) {
                
                // B1: Shoulders
                ((DataNavController *)self.parentViewController).index = @4;
            }
            
            else if (selectedCell.tag == 9) {
                
                // Rest
                ((DataNavController *)self.parentViewController).index = @9;
            }
            
            else if (selectedCell.tag == 10) {
                
                // B3: Cardio
                ((DataNavController *)self.parentViewController).index = @10;
            }
            
            else if (selectedCell.tag == 11) {
                
                // B3: Complete Body
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (selectedCell.tag == 12) {
                
                // B3: Ab Workout
                ((DataNavController *)self.parentViewController).index = @10;
            }
        }
    }
    
    //NSLog(@"%@ index = %@", ((DataNavController *)self.parentViewController).workout, ((DataNavController *)self.parentViewController).index);
}

 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
     // Return the number of rows in the section.
     
     NSInteger rows = 0;
     
     if (section == 0) {
         
         rows = 2;
     }
     
     else if (section == 1) {
         
         rows = 1;
     }
     
     else if (section == 2) {
         
         rows = 2;
     }
     
     else if (section == 3) {
         
         rows = 2;
     }
     
     else if (section == 4) {
         
         rows = 2;
     }
     
     else if (section == 5) {
         
         rows = 3;
     }
     
    return rows;
 }

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 static NSString *CellIdentifier = @"Cell";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        
        NSString *routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@", ((DataNavController *)self.parentViewController).week];
        return routineWeek;
    }
    
    else {
        
        return @"";
    }
}
@end
