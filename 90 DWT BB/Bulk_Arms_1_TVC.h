//
//  Bulk_Arms_1_TVC.h
//  90 DWT BB
//
//  Created by Grant, Jared on 3/3/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "UIViewController+Social.h"
#import "UITableViewController+Email.h"
#import "AppDelegate.h"

@interface Bulk_Arms_1_TVC : UITableViewController <UIActionSheetDelegate, UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) NSArray *Titles;
@property (strong, nonatomic) NSArray *Reps;
@property (strong, nonatomic) NSArray *currentTextFieldArray;
@property (strong, nonatomic) NSArray *previousTextFieldArray;
@property (strong, nonatomic) NSArray *CellArray;
@property (strong, nonatomic) NSArray *exerciseLabelArray;
@property (strong, nonatomic) NSArray *repLabelArray;

@property (strong, nonatomic) NSArray *currentNotesArray;
@property (strong, nonatomic) NSArray *previousNotesArray;
@property (strong, nonatomic) NSArray *graphButtonArray;

//  CELLS
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_1;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_2;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_3;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_4;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_5;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_6;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_7;


//  Exercise Name Labels
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_2;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_3;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_4;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_5;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_6;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_7;


//  PREVIOUS WEIGHT FIELDS
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_1;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_2;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_3;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_4;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_5;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_6;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_7;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_8;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_9;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_10;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_11;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_12;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_13;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_14;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_15;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_16;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_17;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_18;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_19;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_20;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_21;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_22;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_23;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_24;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_25;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_26;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_27;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_28;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_29;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_30;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_31;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_32;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_33;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_34;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_35;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_36;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_37;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_38;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_39;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_40;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_41;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_42;


//  CURRENT WEIGHT FIELDS
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_1;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_2;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_3;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_4;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_5;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_6;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_7;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_8;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_9;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_10;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_11;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_12;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_13;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_14;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_15;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_16;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_17;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_18;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_19;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_20;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_21;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_22;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_23;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_24;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_25;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_26;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_27;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_28;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_29;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_30;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_31;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_32;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_33;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_34;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_35;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_36;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_37;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_38;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_39;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_40;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_41;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_42;


// REP LABELS
@property (weak, nonatomic) IBOutlet UILabel *rep_1;
@property (weak, nonatomic) IBOutlet UILabel *rep_2;
@property (weak, nonatomic) IBOutlet UILabel *rep_3;
@property (weak, nonatomic) IBOutlet UILabel *rep_4;
@property (weak, nonatomic) IBOutlet UILabel *rep_5;
@property (weak, nonatomic) IBOutlet UILabel *rep_6;

@property (weak, nonatomic) IBOutlet UILabel *rep_7;
@property (weak, nonatomic) IBOutlet UILabel *rep_8;
@property (weak, nonatomic) IBOutlet UILabel *rep_9;
@property (weak, nonatomic) IBOutlet UILabel *rep_10;
@property (weak, nonatomic) IBOutlet UILabel *rep_11;
@property (weak, nonatomic) IBOutlet UILabel *rep_12;

@property (weak, nonatomic) IBOutlet UILabel *rep_13;
@property (weak, nonatomic) IBOutlet UILabel *rep_14;
@property (weak, nonatomic) IBOutlet UILabel *rep_15;
@property (weak, nonatomic) IBOutlet UILabel *rep_16;
@property (weak, nonatomic) IBOutlet UILabel *rep_17;
@property (weak, nonatomic) IBOutlet UILabel *rep_18;

@property (weak, nonatomic) IBOutlet UILabel *rep_19;
@property (weak, nonatomic) IBOutlet UILabel *rep_20;
@property (weak, nonatomic) IBOutlet UILabel *rep_21;
@property (weak, nonatomic) IBOutlet UILabel *rep_22;
@property (weak, nonatomic) IBOutlet UILabel *rep_23;
@property (weak, nonatomic) IBOutlet UILabel *rep_24;

@property (weak, nonatomic) IBOutlet UILabel *rep_25;
@property (weak, nonatomic) IBOutlet UILabel *rep_26;
@property (weak, nonatomic) IBOutlet UILabel *rep_27;
@property (weak, nonatomic) IBOutlet UILabel *rep_28;
@property (weak, nonatomic) IBOutlet UILabel *rep_29;
@property (weak, nonatomic) IBOutlet UILabel *rep_30;

@property (weak, nonatomic) IBOutlet UILabel *rep_31;
@property (weak, nonatomic) IBOutlet UILabel *rep_32;
@property (weak, nonatomic) IBOutlet UILabel *rep_33;
@property (weak, nonatomic) IBOutlet UILabel *rep_34;
@property (weak, nonatomic) IBOutlet UILabel *rep_35;
@property (weak, nonatomic) IBOutlet UILabel *rep_36;

@property (weak, nonatomic) IBOutlet UILabel *rep_37;
@property (weak, nonatomic) IBOutlet UILabel *rep_38;
@property (weak, nonatomic) IBOutlet UILabel *rep_39;
@property (weak, nonatomic) IBOutlet UILabel *rep_40;
@property (weak, nonatomic) IBOutlet UILabel *rep_41;
@property (weak, nonatomic) IBOutlet UILabel *rep_42;


// PREVIOUS NOTES
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_1;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_2;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_3;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_4;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_5;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_6;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_7;


// CURRENT NOTES
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_1;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_2;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_3;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_4;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_5;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_6;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_7;


// GRAPH BUTTON
@property (weak, nonatomic) IBOutlet UIButton *graphButton_1;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_2;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_3;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_4;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_5;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_6;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_7;

- (IBAction)submitEntries:(id)sender;
- (IBAction)showGraph:(UIButton *)sender;
@end
