//
//  Bulk_1_TVC.m
//  90 DWT BB
//
//  Created by Grant, Jared on 2/11/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "Bulk_1_TVC.h"

@interface Bulk_1_TVC ()

@end

@implementation Bulk_1_TVC

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
                     @"B1: Shoulders",
                     @"B3: Cardio",
                     @"B3: Complete Body",
                     @"B3: Ab Workout",
                     @"Rest",
                     @"B1: Chest+Tri",
                     @"T1: Chest+Tri"];
    
    ((DataNavController *)self.parentViewController).workout = workoutArray[selectedCell.tag];
    
    // Normal routine
    if ([selectedRoutine isEqualToString:@"Bulk"]) {
        
        // Week 1
        if ([week isEqualToString:@"Week 1"]) {
            
            if (selectedCell.tag == 1) {
                
                // Complete Fitness 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (selectedCell.tag == 2) {
                
                // Dexterity 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (selectedCell.tag == 3) {
                
                // Yoga 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (selectedCell.tag == 4) {
                
                // The Goal 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (selectedCell.tag == 5) {
                
                // Cardio Resistance 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (selectedCell.tag == 6) {
                
                // Gladiator 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (selectedCell.tag == 7) {
                
                // Core D 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (selectedCell.tag == 8) {
                
                // Core D 1
                ((DataNavController *)self.parentViewController).index = @1;
            }

            else if (selectedCell.tag == 9) {
                
                // Core D 1
                ((DataNavController *)self.parentViewController).index = @1;
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
