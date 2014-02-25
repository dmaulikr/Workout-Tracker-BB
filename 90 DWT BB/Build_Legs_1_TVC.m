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
    
    self.canDisplayBannerAds = YES;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated
{
    //[self.tableView reloadData];
}
 */

- (void)loadArrays {
    
    self.Titles = @[@"Wide Squat"];
    
    NSArray * repNameArray1 = @[@"15",
                                @"12",
                                @"8",
                                @"8",
                                @"",
                                @""];
    self.Reps = @[repNameArray1];
    
    self.CellArray = [[NSMutableArray alloc] init];
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
    ExerciseCell *cell = (ExerciseCell *)[tableView dequeueReusableCellWithIdentifier:@"ExerciseCell"];
    
    // Configure the cell...
    if (indexPath.section == 0) {
        
        cell.exerciseLabel.textColor = [UIColor orangeColor];
    }
    
    else {
        
        cell.exerciseLabel.textColor = [UIColor darkGrayColor];
    }
    
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
    
    NSArray *tempRepArray = self.Reps[[indexPath row]];
    
    //  Configure Reps Label.
    for (int i = 0; i < tempRepArray.count; i++) {
        
        UILabel *genericRepLabel = self.CellRepsLabelArray[i];
        genericRepLabel.text = tempRepArray[i];
        
        //  Hide the label and textfield if label = "".
        if ([genericRepLabel.text isEqualToString:@""]) {
            
            UITextField *genericWeightField = self.CellWeightFieldArray[i];
            genericRepLabel.hidden = YES;
            genericWeightField.hidden = YES;
        }
    }
    
    //  Configure TextField Keyboard
    for (int i = 0; i < self.CellWeightFieldArray.count; i++) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
            // IPHONE - Set the keyboard type of the Weight text box to DECIMAL NUMBER PAD.
            UITextField *textfield = self.CellWeightFieldArray[i];
            textfield.keyboardType = UIKeyboardTypeDecimalPad;
            textfield.keyboardAppearance = UIKeyboardAppearanceDark;
        }
    
        else {
            
            // IPAD - No decimal pad on ipad so set it to numbers and punctuation.
            UITextField *textfield = self.CellWeightFieldArray[i];
            textfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            textfield.keyboardAppearance = UIKeyboardAppearanceDark;
        }
    }
    
    UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
    UIColor *lightGreen = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:.15f];
    
    for (int i = 0; i < self.CellWeightFieldArray.count; i++) {
        
        UITextField *tempTextField = self.CellWeightFieldArray[i];
        
        tempTextField.layer.borderWidth = 1.0f;
        tempTextField.layer.borderColor = [green CGColor];
        tempTextField.layer.cornerRadius = 5;
        tempTextField.clipsToBounds = YES;
        
        if (indexPath.section == 0) {
            
            //  Current section
            tempTextField.backgroundColor = lightGreen;
            tempTextField.clearsOnBeginEditing = YES;
        }
        
        else {
            
            //  Previous section
            tempTextField.backgroundColor = [UIColor groupTableViewBackgroundColor];
            tempTextField.userInteractionEnabled = NO;
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
