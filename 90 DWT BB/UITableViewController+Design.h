//
//  UITableViewController+Design.h
//  90 DWT 2
//
//  Created by Grant, Jared on 11/17/12.
//  Copyright (c) 2012 Grant, Jared. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseCell.h"

@interface UITableViewController (Design)

- (void)configureAccessoryIcon:(NSArray*)tableViewCellArray :(NSArray*)needsAccessoryIcon;
- (void)configureCellBox:(NSArray*)cellBoxArray;
- (void)configureExerciseCell:(NSArray*)tableCell :(NSArray*)repNamesArray :(NSArray*)exerciseNamesArray :(NSArray*)previousTFArray :(NSArray*)currentTFArray :(NSArray*)exerciseLabelsArray :(NSArray*)repsLabelArray;
//- (UIView*)configureSectionHeader:(NSArray*)tvHeaderStrings :(int)tvWidth :(int)tvSection;
- (void)configureStoreTableView:(NSArray*)tableCell :(NSArray*)needAccessoryIcon :(NSArray*)needCellColor;
@end
