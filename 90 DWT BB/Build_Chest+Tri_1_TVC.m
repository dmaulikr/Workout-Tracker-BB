//
//  Build_Chest+Tri_1_TVC.m
//  90 DWT BB
//
//  Created by Grant, Jared on 2/27/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "Build_Chest+Tri_1_TVC.h"
#import "UITableViewController+Database.h"
#import "UITableViewController+Design.h"
#import "DataNavController.h"

@interface Build_Chest_Tri_1_TVC ()

@end

@implementation Build_Chest_Tri_1_TVC

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
    
    self.canDisplayBannerAds = YES;
    
    self.navigationItem.title = ((DataNavController *)self.parentViewController).workout;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadArrays {
    
    NSArray *Titles1 = @[@"Dumbbell Chest Press"];
    
    NSArray *Titles2 = @[@"Incline Dumbbell Fly",
                         @"Incline Dumbbell Press"];
    
    NSArray *Titles3 = @[@"Close Grip Dumbbell Press",
                         @"Partial Dumbbell Fly",
                         @"Decline Push-Up"];
    
    NSArray *Titles4 = @[@"Laying Tricep Extension"];
    
    NSArray *Titles5 = @[@"Single Arm Tricep Kickback",
                         @"Diamond Push-Up"];
    
    NSArray *Titles6 = @[@"Dips",
                         @"Abs"];
    
    NSArray *repNameArray1 = @[@"15",
                               @"12",
                               @"8",
                               @"8",
                               @"",
                               @""];
    
    NSArray *repNameArray2 = @[@"15",
                               @"12",
                               @"8",
                               @"",
                               @"",
                               @""];
    
    NSArray *repNameArray3 = @[@"60",
                               @"",
                               @"",
                               @"",
                               @"",
                               @""];
    
    NSArray *repArraySection1 = @[repNameArray1];
    
    NSArray *repArraySection2 = @[repNameArray2,
                                  repNameArray1];
    
    NSArray *repArraySection3 = @[repNameArray2,
                                  repNameArray2,
                                  repNameArray2];
    
    NSArray *repArraySection4 = @[repNameArray1];
    
    NSArray *repArraySection5 = @[repNameArray1,
                                  repNameArray2];
    
    NSArray *repArraySection6 = @[repNameArray3,
                                  repNameArray3];
    
    self.Titles = @[Titles1,
                    Titles2,
                    Titles3,
                    Titles4,
                    Titles5,
                    Titles6];
    
    self.Reps = @[repArraySection1,
                  repArraySection2,
                  repArraySection3,
                  repArraySection4,
                  repArraySection5,
                  repArraySection6];
    
    self.CellArray = @[self.cell_1,
                       self.cell_2,
                       self.cell_3,
                       self.cell_4,
                       self.cell_5,
                       self.cell_6,
                       self.cell_7,
                       self.cell_8,
                       self.cell_9,
                       self.cell_10,
                       self.cell_11];
    
    //  Configure the cell...
    [self configureExerciseCell:cell :indexPath :self.Reps[indexPath.section] :self.Titles[indexPath.section]];
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
    return self.Titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSArray *tempSectionTitleArray = self.Titles[section];
    
    return tempSectionTitleArray.count;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExerciseCell *cell;
    
    NSString *cellIdentifier = @"ExerciseCell";
    //cellIdentifier = [cellIdentifier stringByAppendingFormat:@"%d", indexPath.section + 1];
    //cellIdentifier = [cellIdentifier stringByAppendingFormat:@"%d", [self findCurrentRow:indexPath]];
    
   cellIdentifier = [NSString stringWithFormat:@"%@_%d_%d", cellIdentifier, indexPath.section, indexPath.row];
    NSLog(@"%@", cellIdentifier);
    
    cell = (ExerciseCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.weightField1.delegate = self;
    cell.weightField2.delegate = self;
    cell.weightField3.delegate = self;
    cell.weightField4.delegate = self;
    cell.weightField5.delegate = self;
    cell.weightField6.delegate = self;
    
    //  Configure the cell...
    [self configureExerciseCell:cell :indexPath :self.Reps[indexPath.section] :self.Titles[indexPath.section]];
    
    //  Get data from the database
    //NSInteger section = [indexPath section];
    [self exerciseMatches:cell :indexPath];
    
    
    //  Only save cells in the current section so that you can access them later when you need to save to database.
    if (indexPath.section == 0 && self.CellArray.count < self.Titles.count) {
        [self.CellArray addObject:cell];
    }
 

    [self.CellArray addObject:cell];
    
    return cell;
}
*/

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *headerTitle = @"";
    headerTitle = [headerTitle stringByAppendingFormat:@"Set %d of %d", section + 1, self.Titles.count];
    
    return headerTitle;
}

- (IBAction)submitEntries:(id)sender {
    
    //  Save to the database
    [self saveToDatabase:self.CellArray];
    
    [self shareActionSheet];
}

- (void)shareActionSheet {
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Data saved successfully.  Share your progress!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email .csv File", @"Facebook", @"Twitter", nil];
    
    [action showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        //  Get the csvstring and then send the email
        [self sendEmail:[self stringForEmail:self.Titles :self.Reps :[self findTotalRows] ] ];
    }
    
    if (buttonIndex == 1) {
        [self facebook];
    }
    
    if (buttonIndex == 2) {
        [self twitter];
    }
}

- (int)findTotalRows {
    
    NSUInteger allRows = 0;
    for(NSInteger i = 0; i < [self.tableView numberOfSections]; i++)
    {
        allRows += [self.tableView numberOfRowsInSection:i];
    }
    
    return allRows;
}

- (int)findCurrentRow:(NSIndexPath*)indexpath {
    
    NSUInteger currentRow = 0;
    for(NSInteger i = 0; i < indexpath.section + 1; i++)
    {
        
        currentRow += [self.tableView numberOfRowsInSection:i];
    }
    
    currentRow = currentRow - [self.tableView numberOfRowsInSection:indexpath.section];
    
    currentRow = currentRow + indexpath.row + 1;
    
    return currentRow;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    //
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //
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
