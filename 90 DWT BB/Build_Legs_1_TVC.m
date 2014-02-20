//
//  Build_Legs_1_TVC.m
//  90 DWT BB
//
//  Created by Grant, Jared on 2/19/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "Build_Legs_1_TVC.h"
#import "ExerciseCell.h"

@interface Build_Legs_1_TVC ()

@end

@implementation Build_Legs_1_TVC

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
    
    [self loadArrays];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadArrays {
    
    self.Titles = @[@"Wide Squat"];
    
    self.Reps = @[@"15",
                  @"12",
                  @"8",
                  @"8",
                  @"",
                  @""];
    
    //  Query the database for this info
    //self.Weight =
                    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.Titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ExerciseCell";
    ExerciseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.exerciseLabel.text = self.Titles[indexPath.row];
    
    cell.repLabel1.text = @"20";
    /*
    if ([self.Reps[0] isEqualToString:@""]) {
        cell.repLabel1.hidden = YES;
        cell.weightField1.hidden = YES;
    }
    else {
        cell.repLabel1.text = self.Reps[0];
    }
    
    if ([self.Reps[1] isEqualToString:@""]) {
        cell.repLabel2.hidden = YES;
        cell.weightField2.hidden = YES;
    }
    else {
        cell.repLabel2.text = self.Reps[1];
    }
    
    if ([self.Reps[2] isEqualToString:@""]) {
        cell.repLabel3.hidden = YES;
        cell.weightField3.hidden = YES;
    }
    else {
        cell.repLabel3.text = self.Reps[2];
    }
    
    if ([self.Reps[3] isEqualToString:@""]) {
        cell.repLabel4.hidden = YES;
        cell.weightField4.hidden = YES;
    }
    else {
        cell.repLabel4.text = self.Reps[3];
    }
    
    if ([self.Reps[4] isEqualToString:@""]) {
        cell.repLabel5.hidden = YES;
        cell.weightField5.hidden = YES;
    }
    else {
        cell.repLabel5.text = self.Reps[4];
    }
    
    if ([self.Reps[5] isEqualToString:@""]) {
        cell.repLabel6.hidden = YES;
        cell.weightField6.hidden = YES;
    }
    else {
        cell.repLabel6.text = self.Reps[5];
    }
    */
    
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return @"CURRENT";
    }
    
    else {
        
        return @"PREVIOUS";
    }
}

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

@end
