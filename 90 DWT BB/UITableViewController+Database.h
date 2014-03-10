//
//  UITableViewController+Database.h
//  90 DWT BB
//
//  Created by Grant, Jared on 2/19/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ExerciseCell.h"

@interface UITableViewController (Database)


-(void)exerciseMatches:(ExerciseCell*)cell :(NSIndexPath*)indexPath;
-(void)saveToDatabase:(NSArray*)cell;
//-(void)saveTextFieldToDatabase:(NSArray)
@end
