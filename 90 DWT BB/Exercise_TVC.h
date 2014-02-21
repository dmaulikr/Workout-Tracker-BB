//
//  Exercise_TVC.h
//  90 DWT BB
//
//  Created by Jared Grant on 2/16/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "DataNavController.h"
#import "AppDelegate.h"
#import "ResultsViewController.h"
#import "MainTBC.h"
#import "UITableViewController+Database.h"
#import "ExerciseCell.h"

@interface Exercise_TVC : UITableViewController

//  Reps Labels
//  Current
@property (weak, nonatomic) IBOutlet UILabel *currentRepsLabel1;
@property (weak, nonatomic) IBOutlet UILabel *currentRepsLabel2;
@property (weak, nonatomic) IBOutlet UILabel *currentRepsLabel3;
@property (weak, nonatomic) IBOutlet UILabel *currentRepsLabel4;
@property (weak, nonatomic) IBOutlet UILabel *currentRepsLabel5;
@property (weak, nonatomic) IBOutlet UILabel *currentRepsLabel6;

//  Previous
@property (weak, nonatomic) IBOutlet UILabel *previousRepsLabel1;
@property (weak, nonatomic) IBOutlet UILabel *previousRepsLabel2;
@property (weak, nonatomic) IBOutlet UILabel *previousRepsLabel3;
@property (weak, nonatomic) IBOutlet UILabel *previousRepsLabel4;
@property (weak, nonatomic) IBOutlet UILabel *previousRepsLabel5;
@property (weak, nonatomic) IBOutlet UILabel *previousRepsLabel6;

//  Input Cells
@property (weak, nonatomic) IBOutlet UITableViewCell *currentCell1;
@property (weak, nonatomic) IBOutlet UITableViewCell *previousCell1;

//  Exercise Labels
@property (weak, nonatomic) IBOutlet UILabel *currentCellLabel1;
@property (weak, nonatomic) IBOutlet UILabel *previousCellLabel1;

//  Textfields
//  Current
@property (weak, nonatomic) IBOutlet UITextField *currentCell1Wt1;
@property (weak, nonatomic) IBOutlet UITextField *currentCell1Wt2;
@property (weak, nonatomic) IBOutlet UITextField *currentCell1Wt3;
@property (weak, nonatomic) IBOutlet UITextField *currentCell1Wt4;
@property (weak, nonatomic) IBOutlet UITextField *currentCell1Wt5;
@property (weak, nonatomic) IBOutlet UITextField *currentCell1Wt6;

//  Previous
@property (weak, nonatomic) IBOutlet UITextField *previousCell1Wt1;
@property (weak, nonatomic) IBOutlet UITextField *previousCell1Wt2;
@property (weak, nonatomic) IBOutlet UITextField *previousCell1Wt3;
@property (weak, nonatomic) IBOutlet UITextField *previousCell1Wt4;
@property (weak, nonatomic) IBOutlet UITextField *previousCell1Wt5;
@property (weak, nonatomic) IBOutlet UITextField *previousCell1Wt6;

//  Arrays
@property (strong, nonatomic) NSArray *currentCellsArray;
@property (strong, nonatomic) NSArray *previousCellsArray;
@property (strong, nonatomic) NSArray *currentRepsLabelArray;
@property (strong, nonatomic) NSArray *previousRepsLabelArray;
@property (strong, nonatomic) NSArray *currentExerciseLabelArray;
@property (strong, nonatomic) NSArray *previousExerciseLabelArray;
@property (strong, nonatomic) NSArray *currentTextFieldArray;
@property (strong, nonatomic) NSArray *previousTextFieldArray;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)submitEntry:(id)sender;

@end
