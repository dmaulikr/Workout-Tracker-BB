//
//  Bulk_Back_1_TVC.m
//  90 DWT BB
//
//  Created by Grant, Jared on 3/3/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "Bulk_Back_1_TVC.h"
#import "UITableViewController+Database.h"
#import "UITableViewController+Design.h"
#import "DataNavController.h"
#import "90DWTBBIAPHelper.h"

@interface Bulk_Back_1_TVC ()

@end

@implementation Bulk_Back_1_TVC

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
    
    [self addAccessoryToolBar];
    
    // Show or Hide Ads
    if ([[_0DWTBBIAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWTBB.removeads"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        self.canDisplayBannerAds = NO;
        
    } else {
        
        // Show the Banner Ad
        self.canDisplayBannerAds = YES;
    }
    
    self.navigationItem.title = ((DataNavController *)self.parentViewController).workout;
    
    //  Configure the cell...
    [self configureExerciseCell:self.CellArray :self.Reps :self.Titles :self.previousTextFieldArray :self.currentTextFieldArray :self.exerciseLabelArray :self.repLabelArray :self.previousNotesArray :self.currentNotesArray :self.graphButtonArray];
    
    //  Get data from the database
    [self exerciseMatches:self.Titles :self.previousTextFieldArray :self.currentTextFieldArray :self.previousNotesArray :self.currentNotesArray];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadArrays {
    
    self.Titles = @[@"Dumbbell Pull-Over",
                    @"Pull-Up",
                    @"Curl Bar Underhand Row",
                    @"One Arm Dumbbell Row",
                    @"Deadlift",
                    @"Reverse Fly",
                    @"Plank Row Arm Balance"];
    
    self.Reps = @[@"15",
                  @"12",
                  @"8",
                  @"8",
                  @"",
                  @"",
                  //  Cell 2
                  @"10",
                  @"10",
                  @"10",
                  @"",
                  @"",
                  @"",
                  //  Cell 3
                  @"15",
                  @"12",
                  @"8",
                  @"8",
                  @"12",
                  @"15",
                  //  Cell 4
                  @"5",
                  @"5",
                  @"5",
                  @"5",
                  @"5",
                  @"",
                  //  Cell 5
                  @"15",
                  @"12",
                  @"8",
                  @"8",
                  @"",
                  @"",
                  //  Cell 6
                  @"15",
                  @"12",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 7
                  @"30",
                  @"30",
                  @"",
                  @"",
                  @"",
                  @""];
    
    self.CellArray = @[self.cell_1,
                       self.cell_2,
                       self.cell_3,
                       self.cell_4,
                       self.cell_5,
                       self.cell_6,
                       self.cell_7];
    
    self.exerciseLabelArray = @[self.exerciseLabel_1,
                                self.exerciseLabel_2,
                                self.exerciseLabel_3,
                                self.exerciseLabel_4,
                                self.exerciseLabel_5,
                                self.exerciseLabel_6,
                                self.exerciseLabel_7];
    
    self.repLabelArray = @[self.rep_1,
                           self.rep_2,
                           self.rep_3,
                           self.rep_4,
                           self.rep_5,
                           self.rep_6,
                           self.rep_7,
                           self.rep_8,
                           self.rep_9,
                           self.rep_10,
                           self.rep_11,
                           self.rep_12,
                           self.rep_13,
                           self.rep_14,
                           self.rep_15,
                           self.rep_16,
                           self.rep_17,
                           self.rep_18,
                           self.rep_19,
                           self.rep_20,
                           self.rep_21,
                           self.rep_22,
                           self.rep_23,
                           self.rep_24,
                           self.rep_25,
                           self.rep_26,
                           self.rep_27,
                           self.rep_28,
                           self.rep_29,
                           self.rep_30,
                           self.rep_31,
                           self.rep_32,
                           self.rep_33,
                           self.rep_34,
                           self.rep_35,
                           self.rep_36,
                           self.rep_37,
                           self.rep_38,
                           self.rep_39,
                           self.rep_40,
                           self.rep_41,
                           self.rep_42];
    
    self.currentTextFieldArray = @[self.currentWeight_1,
                                   self.currentWeight_2,
                                   self.currentWeight_3,
                                   self.currentWeight_4,
                                   self.currentWeight_5,
                                   self.currentWeight_6,
                                   self.currentWeight_7,
                                   self.currentWeight_8,
                                   self.currentWeight_9,
                                   self.currentWeight_10,
                                   self.currentWeight_11,
                                   self.currentWeight_12,
                                   self.currentWeight_13,
                                   self.currentWeight_14,
                                   self.currentWeight_15,
                                   self.currentWeight_16,
                                   self.currentWeight_17,
                                   self.currentWeight_18,
                                   self.currentWeight_19,
                                   self.currentWeight_20,
                                   self.currentWeight_21,
                                   self.currentWeight_22,
                                   self.currentWeight_23,
                                   self.currentWeight_24,
                                   self.currentWeight_25,
                                   self.currentWeight_26,
                                   self.currentWeight_27,
                                   self.currentWeight_28,
                                   self.currentWeight_29,
                                   self.currentWeight_30,
                                   self.currentWeight_31,
                                   self.currentWeight_32,
                                   self.currentWeight_33,
                                   self.currentWeight_34,
                                   self.currentWeight_35,
                                   self.currentWeight_36,
                                   self.currentWeight_37,
                                   self.currentWeight_38,
                                   self.currentWeight_39,
                                   self.currentWeight_40,
                                   self.currentWeight_41,
                                   self.currentWeight_42];
    
    self.previousTextFieldArray = @[self.previousWeight_1,
                                    self.previousWeight_2,
                                    self.previousWeight_3,
                                    self.previousWeight_4,
                                    self.previousWeight_5,
                                    self.previousWeight_6,
                                    self.previousWeight_7,
                                    self.previousWeight_8,
                                    self.previousWeight_9,
                                    self.previousWeight_10,
                                    self.previousWeight_11,
                                    self.previousWeight_12,
                                    self.previousWeight_13,
                                    self.previousWeight_14,
                                    self.previousWeight_15,
                                    self.previousWeight_16,
                                    self.previousWeight_17,
                                    self.previousWeight_18,
                                    self.previousWeight_19,
                                    self.previousWeight_20,
                                    self.previousWeight_21,
                                    self.previousWeight_22,
                                    self.previousWeight_23,
                                    self.previousWeight_24,
                                    self.previousWeight_25,
                                    self.previousWeight_26,
                                    self.previousWeight_27,
                                    self.previousWeight_28,
                                    self.previousWeight_29,
                                    self.previousWeight_30,
                                    self.previousWeight_31,
                                    self.previousWeight_32,
                                    self.previousWeight_33,
                                    self.previousWeight_34,
                                    self.previousWeight_35,
                                    self.previousWeight_36,
                                    self.previousWeight_37,
                                    self.previousWeight_38,
                                    self.previousWeight_39,
                                    self.previousWeight_40,
                                    self.previousWeight_41,
                                    self.previousWeight_42];
    
    self.currentNotesArray = @[self.currentNotes_1,
                               self.currentNotes_2,
                               self.currentNotes_3,
                               self.currentNotes_4,
                               self.currentNotes_5,
                               self.currentNotes_6,
                               self.currentNotes_7];
    
    self.previousNotesArray = @[self.previousNotes_1,
                                self.previousNotes_2,
                                self.previousNotes_3,
                                self.previousNotes_4,
                                self.previousNotes_5,
                                self.previousNotes_6,
                                self.previousNotes_7];
    
    self.graphButtonArray = @[self.graphButton_1,
                              self.graphButton_2,
                              self.graphButton_3,
                              self.graphButton_4,
                              self.graphButton_5,
                              self.graphButton_6,
                              self.graphButton_7];
}

- (void)addAccessoryToolBar
{
    // Create the toolbar to go above the keyboard.
    UIToolbar *accessoryToolBar = [[UIToolbar alloc] init];
    accessoryToolBar.barTintColor = [UIColor darkGrayColor];
    
    // Create buttons for the toolbar.
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)];
    
    UIBarButtonItem *flexableSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveWithNumberPad)];
    
    // Add buttons to the toolbar.
    accessoryToolBar.items = [NSArray arrayWithObjects:cancel, flexableSpace, save, nil];
    
    [accessoryToolBar sizeToFit];
    
    //  Change color of the toolbar and buttons.
    accessoryToolBar.barTintColor = [UIColor darkGrayColor];
    cancel.tintColor = [UIColor whiteColor];
    save.tintColor = [UIColor whiteColor];
    
    // Set the toolbar to show for all the textfields.
    for (int i = 0; i < self.currentTextFieldArray.count; i++) {
        
        UITextField *tempTextField = self.currentTextFieldArray[i];
        tempTextField.inputAccessoryView = accessoryToolBar;
    }
}

- (void)cancelNumberPad {
    
    //  Dismiss the keyboard.
    [self.view endEditing:YES];
}


- (void)saveWithNumberPad {
    
    // Dismiss the keyboard.
    [self.view endEditing:YES];
    
    [self saveData];
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
    return 5;
}

/*
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 // Return the number of rows in the section.
 
 NSArray *tempSectionTitleArray = self.Titles[section];
 
 return tempSectionTitleArray.count;
 }
 */

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
    
    NSNumber *headerSection = [NSNumber numberWithInteger:section +1];
    NSNumber *numberOfSections = [NSNumber numberWithInteger:self.tableView.numberOfSections];
    NSString *headerTitle = @"";
    headerTitle = [headerTitle stringByAppendingFormat:@"Set %@ of %@", headerSection, numberOfSections];
    
    return headerTitle;
}

- (IBAction)submitEntries:(id)sender {
    
    //  Save to the database
    [self saveData];
    
    [self shareActionSheet];
}

- (void)shareActionSheet {
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Data saved successfully.  Share your progress!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email .csv File", @"Facebook", @"Twitter", nil];
    
    [action showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        //  Get the csvstring and then send the email
        [self sendEmail:[self stringForEmail:self.Titles] ];
    }
    
    if (buttonIndex == 1) {
        [self facebook];
    }
    
    if (buttonIndex == 2) {
        [self twitter];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //  Save to the database
    [self saveData];
}

- (void)saveData {
    
    //  Save to the database
    [self saveToDatabase:self.Titles :self.Reps :self.currentTextFieldArray :self.currentNotesArray];
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
