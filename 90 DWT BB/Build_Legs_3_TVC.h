//
//  Build_Legs_3_TVC.h
//  90 DWT BB
//
//  Created by Grant, Jared on 2/26/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "ExerciseCell.h"

@interface Build_Legs_3_TVC : UITableViewController

@property (strong, nonatomic) NSArray *Titles;
@property (strong, nonatomic) NSArray *Reps;

@property (strong, nonatomic) NSMutableArray *CellArray;

- (IBAction)submitEntries:(id)sender;
@end
