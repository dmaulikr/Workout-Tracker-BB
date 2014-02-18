//
//  Tone_1_TVC.m
//  90 DWT BB
//
//  Created by Grant, Jared on 2/13/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "Tone_1_TVC.h"

@interface Tone_1_TVC ()

@end

@implementation Tone_1_TVC

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedRoutine = ((DataNavController *)self.parentViewController).routine;
    NSString *week = ((DataNavController *)self.parentViewController).week;
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSArray *workoutArray;
    
    workoutArray = @[@"B1: Chest+Tri",
                     @"B1: Legs",
                     @"B1: Back+Bi",
                     @"B3: Cardio",
                     @"B3: Ab Workout",
                     @"B1: Shoulders",
                     @"Rest",
                     @"B1: Chest+Tri",
                     @"T1: Chest+Tri"];
   
    ((DataNavController *)self.parentViewController).workout = workoutArray[selectedCell.tag];
    
    // Normal routine
    if ([selectedRoutine isEqualToString:@"Tone"]) {
        
        // Week 1
        if ([week isEqualToString:@"Week 1"]) {
            
            if (indexPath.row == 0) {
                
                // Complete Fitness 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (indexPath.row == 1) {
                
                // Dexterity 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (indexPath.row == 2) {
                
                // Yoga 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (indexPath.row == 3) {
                
                // The Goal 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (indexPath.row == 4) {
                
                // Cardio Resistance 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (indexPath.row == 5) {
                
                // Gladiator 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (indexPath.row == 6) {
                
                // Core D 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
        }
        
        // Week 2
        else if ([week isEqualToString:@"Week 2"]) {
            
            if (indexPath.row == 0) {
                
                // Complete Fitness 2
                ((DataNavController *)self.parentViewController).index = @2;
            }
            
            else if (indexPath.row == 1) {
                
                // Dexterity 2
                ((DataNavController *)self.parentViewController).index = @2;
            }
            
            else if (indexPath.row == 2) {
                
                // Yoga 2
                ((DataNavController *)self.parentViewController).index = @2;
            }
            
            else if (indexPath.row == 3) {
                
                // The Goal 2
                ((DataNavController *)self.parentViewController).index = @2;
            }
            
            else if (indexPath.row == 4) {
                
                // Cardio Resistance 2
                ((DataNavController *)self.parentViewController).index = @2;
            }
            
            else if (indexPath.row == 5) {
                
                // Gladiator 2
                ((DataNavController *)self.parentViewController).index = @2;
            }
            
            else if (indexPath.row == 6) {
                
                // Core D 2
                ((DataNavController *)self.parentViewController).index = @2;
            }
        }
        
        // Week 3
        else if ([week isEqualToString:@"Week 3"]) {
            
            if (indexPath.row == 0) {
                
                // Complete Fitness 3
                ((DataNavController *)self.parentViewController).index = @3;
            }
            
            else if (indexPath.row == 1) {
                
                // Dexterity 3
                ((DataNavController *)self.parentViewController).index = @3;
            }
            
            else if (indexPath.row == 2) {
                
                // Yoga 3
                ((DataNavController *)self.parentViewController).index = @3;
            }
            
            else if (indexPath.row == 3) {
                
                // The Goal 3
                ((DataNavController *)self.parentViewController).index = @3;
            }
            
            else if (indexPath.row == 4) {
                
                // Cardio Resistance 3
                ((DataNavController *)self.parentViewController).index = @3;
            }
            
            else if (indexPath.row == 5) {
                
                // Gladiator 3
                ((DataNavController *)self.parentViewController).index = @3;
            }
            
            else if (indexPath.row == 6) {
                
                // Core D 3
                ((DataNavController *)self.parentViewController).index = @3;
            }
        }
    }
    
    //NSLog(@"%@ index = %@", ((DataNavController *)self.parentViewController).workout, ((DataNavController *)self.parentViewController).index);
}

/*
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 #warning Incomplete method implementation.
 // Return the number of rows in the section.
 return 0;
 }
 
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
