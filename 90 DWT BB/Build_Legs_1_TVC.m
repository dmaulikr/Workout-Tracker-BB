//
//  Build_Legs_1_TVC.m
//  90 DWT BB
//
//  Created by Grant, Jared on 2/19/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "Build_Legs_1_TVC.h"
#import "UITableViewController+Database.h"

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
    
    self.CellArray = [[NSMutableArray alloc] init];
    
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
    //return self.Titles.count;
    return self.Titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExerciseCell *cell = (ExerciseCell *)[tableView dequeueReusableCellWithIdentifier:@"ExerciseCell"];
    
    // Configure the cell...
    
    cell.exerciseLabel.text = self.Titles[indexPath.row];
    //[cell.exerciseLabel setFont:[UIFont boldSystemFontOfSize:17]];
    
    self.CellRepsLabelArray = @[cell.repLabel1,
                                cell.repLabel2,
                                cell.repLabel3,
                                cell.repLabel4,
                                cell.repLabel5,
                                cell.repLabel6];
    
    self.CellWeightFieldArray = @[cell.weightField1,
                                  cell.weightField2,
                                  cell.weightField3,
                                  cell.weightField4,
                                  cell.weightField5,
                                  cell.weightField6];
    
    //  Configure Reps Label.
    for (int i = 0; i < self.Reps.count; i++) {
        UILabel *genericRepLabel = self.CellRepsLabelArray[i];
        genericRepLabel.text = self.Reps[i];
        
        //  Hide the label and textfield if labe = "".
        if ([genericRepLabel.text isEqualToString:@""]) {
            
            UITextField *genericWeightField = self.CellWeightFieldArray[i];
            genericRepLabel.hidden = YES;
            genericWeightField.hidden = YES;
        }
    }
    
    NSInteger section = [indexPath section];
    [self exerciseMatches:cell :&section :self.CellWeightFieldArray];
    
    //  Only save cells in the current section so that you can access them later when you need to save to database.
    if (section == 0) {
        [self.CellArray addObject:cell];
    }
    
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

- (IBAction)submitEntries:(id)sender {
    [self saveToDatabase:self.CellArray :self.CellRepsLabelArray :self.CellWeightFieldArray];
}
@end
