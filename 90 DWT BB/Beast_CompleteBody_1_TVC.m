//
//  Beast_CompleteBody_1_TVC.m
//  90 DWT BB
//
//  Created by Jared Grant on 2/28/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "Beast_CompleteBody_1_TVC.h"
#import "UITableViewController+Database.h"
#import "UITableViewController+Design.h"
#import "DataNavController.h"

@interface Beast_CompleteBody_1_TVC ()

@end

@implementation Beast_CompleteBody_1_TVC

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
    
    self.canDisplayBannerAds = YES;
    
    self.navigationItem.title = ((DataNavController *)self.parentViewController).workout;
    
    //  Configure the cell...
    [self configureExerciseCell:self.CellArray :self.Reps :self.Titles :self.previousTextFieldArray :self.currentTextFieldArray :self.exerciseLabelArray :self.repLabelArray];
    
    //  Get data from the database
    [self exerciseMatches:self.Titles :self.previousTextFieldArray :self.currentTextFieldArray];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadArrays {
    
    self.Titles = @[@"Pull-Up",
                    @"Push-Up",
                    @"Dumbbell Squat",
                    @"Crunch",
                    @"Dumbell Incline Press",
                    @"Dumbell Bent-Over Row ",
                    @"Dumbell Alt Reverse Lunge",
                    @"Plank Crunch",
                    @"3-Way Military Press",
                    @"Single Arm Leaning Reverse Fly",
                    @"S-L Deadlift",
                    @"Russian Twist",
                    @"Curl-Up Hammer-Down",
                    @"Leaning Tricep Extension",
                    @"Calf Raise",
                    @"Side Sphinx Raise"];
    
    self.Reps = @[@"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 2
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 3
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 4
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 5
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 6
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 7
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 8
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 9
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 10
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 11
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 12
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 13
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 14
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 15
                  @"15",
                  @"15",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 16
                  @"15",
                  @"15",
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
                       self.cell_7,
                       self.cell_8,
                       self.cell_9,
                       self.cell_10,
                       self.cell_11,
                       self.cell_12,
                       self.cell_13,
                       self.cell_14,
                       self.cell_15,
                       self.cell_16];
    
    self.exerciseLabelArray = @[self.exerciseLabel_1,
                                self.exerciseLabel_2,
                                self.exerciseLabel_3,
                                self.exerciseLabel_4,
                                self.exerciseLabel_5,
                                self.exerciseLabel_6,
                                self.exerciseLabel_7,
                                self.exerciseLabel_8,
                                self.exerciseLabel_9,
                                self.exerciseLabel_10,
                                self.exerciseLabel_11,
                                self.exerciseLabel_12,
                                self.exerciseLabel_13,
                                self.exerciseLabel_14,
                                self.exerciseLabel_15,
                                self.exerciseLabel_16];
    
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
                           self.rep_42,
                           self.rep_43,
                           self.rep_44,
                           self.rep_45,
                           self.rep_46,
                           self.rep_47,
                           self.rep_48,
                           self.rep_49,
                           self.rep_50,
                           self.rep_51,
                           self.rep_52,
                           self.rep_53,
                           self.rep_54,
                           self.rep_55,
                           self.rep_56,
                           self.rep_57,
                           self.rep_58,
                           self.rep_59,
                           self.rep_60,
                           self.rep_61,
                           self.rep_62,
                           self.rep_63,
                           self.rep_64,
                           self.rep_65,
                           self.rep_66,
                           self.rep_67,
                           self.rep_68,
                           self.rep_69,
                           self.rep_70,
                           self.rep_71,
                           self.rep_72,
                           self.rep_73,
                           self.rep_74,
                           self.rep_75,
                           self.rep_76,
                           self.rep_77,
                           self.rep_78,
                           self.rep_79,
                           self.rep_80,
                           self.rep_81,
                           self.rep_82,
                           self.rep_83,
                           self.rep_84,
                           self.rep_85,
                           self.rep_86,
                           self.rep_87,
                           self.rep_88,
                           self.rep_89,
                           self.rep_90,
                           self.rep_91,
                           self.rep_92,
                           self.rep_93,
                           self.rep_94,
                           self.rep_95,
                           self.rep_96];
    
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
                                   self.currentWeight_42,
                                   self.currentWeight_43,
                                   self.currentWeight_44,
                                   self.currentWeight_45,
                                   self.currentWeight_46,
                                   self.currentWeight_47,
                                   self.currentWeight_48,
                                   self.currentWeight_49,
                                   self.currentWeight_50,
                                   self.currentWeight_51,
                                   self.currentWeight_52,
                                   self.currentWeight_53,
                                   self.currentWeight_54,
                                   self.currentWeight_55,
                                   self.currentWeight_56,
                                   self.currentWeight_57,
                                   self.currentWeight_58,
                                   self.currentWeight_59,
                                   self.currentWeight_60,
                                   self.currentWeight_61,
                                   self.currentWeight_62,
                                   self.currentWeight_63,
                                   self.currentWeight_64,
                                   self.currentWeight_65,
                                   self.currentWeight_66,
                                   self.currentWeight_67,
                                   self.currentWeight_68,
                                   self.currentWeight_69,
                                   self.currentWeight_70,
                                   self.currentWeight_71,
                                   self.currentWeight_72,
                                   self.currentWeight_73,
                                   self.currentWeight_74,
                                   self.currentWeight_75,
                                   self.currentWeight_76,
                                   self.currentWeight_77,
                                   self.currentWeight_78,
                                   self.currentWeight_79,
                                   self.currentWeight_80,
                                   self.currentWeight_81,
                                   self.currentWeight_82,
                                   self.currentWeight_83,
                                   self.currentWeight_84,
                                   self.currentWeight_85,
                                   self.currentWeight_86,
                                   self.currentWeight_87,
                                   self.currentWeight_88,
                                   self.currentWeight_89,
                                   self.currentWeight_90,
                                   self.currentWeight_91,
                                   self.currentWeight_92,
                                   self.currentWeight_93,
                                   self.currentWeight_94,
                                   self.currentWeight_95,
                                   self.currentWeight_96];
    
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
                                    self.previousWeight_42,
                                    self.previousWeight_43,
                                    self.previousWeight_44,
                                    self.previousWeight_45,
                                    self.previousWeight_46,
                                    self.previousWeight_47,
                                    self.previousWeight_48,
                                    self.previousWeight_49,
                                    self.previousWeight_50,
                                    self.previousWeight_51,
                                    self.previousWeight_52,
                                    self.previousWeight_53,
                                    self.previousWeight_54,
                                    self.previousWeight_55,
                                    self.previousWeight_56,
                                    self.previousWeight_57,
                                    self.previousWeight_58,
                                    self.previousWeight_59,
                                    self.previousWeight_60,
                                    self.previousWeight_61,
                                    self.previousWeight_62,
                                    self.previousWeight_63,
                                    self.previousWeight_64,
                                    self.previousWeight_65,
                                    self.previousWeight_66,
                                    self.previousWeight_67,
                                    self.previousWeight_68,
                                    self.previousWeight_69,
                                    self.previousWeight_70,
                                    self.previousWeight_71,
                                    self.previousWeight_72,
                                    self.previousWeight_73,
                                    self.previousWeight_74,
                                    self.previousWeight_75,
                                    self.previousWeight_76,
                                    self.previousWeight_77,
                                    self.previousWeight_78,
                                    self.previousWeight_79,
                                    self.previousWeight_80,
                                    self.previousWeight_81,
                                    self.previousWeight_82,
                                    self.previousWeight_83,
                                    self.previousWeight_84,
                                    self.previousWeight_85,
                                    self.previousWeight_86,
                                    self.previousWeight_87,
                                    self.previousWeight_88,
                                    self.previousWeight_89,
                                    self.previousWeight_90,
                                    self.previousWeight_91,
                                    self.previousWeight_92,
                                    self.previousWeight_93,
                                    self.previousWeight_94,
                                    self.previousWeight_95,
                                    self.previousWeight_96];
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
    return 4;
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
    
    [action showFromTabBar:self.tabBarController.tabBar];
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
    [self saveToDatabase:self.Titles :self.Reps :self.currentTextFieldArray];
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
