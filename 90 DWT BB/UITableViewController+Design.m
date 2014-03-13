//
//  UITableViewController+Design.m
//  90 DWT 2
//
//  Created by Grant, Jared on 11/17/12.
//  Copyright (c) 2012 Grant, Jared. All rights reserved.
//

#import "UITableViewController+Design.h"

@implementation UITableViewController (Design)

- (void)configureTableView:(NSArray*)tableCell :(NSArray*)needAccessoryIcon :(NSArray*)needCellColor {
    
    UIColor *lightGrey = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f];
    //UIColor *midGrey = [UIColor colorWithRed:219/255.0f green:218/255.0f blue:218/255.0f alpha:1.0f];
    //UIColor *darkGrey = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f];
    
    // TableView background color
    //self.tableView.backgroundColor = midGrey;
    
    // Accessory view icon
    UIImage* accessory = [UIImage imageNamed:@"nav_r_arrow_grey"];
    
    for (int i = 0; i < tableCell.count; i++) {
        
        UITableViewCell *cell = tableCell[i];
        
        // Label backgrounds
        //UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
        //UIColor* detailTextColor = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:255/255.0f alpha:1.0f];
        cell.detailTextLabel.textColor = [UIColor orangeColor];
        
        // Label and Subtitle Font Size
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        //cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        // Accessory view icon
        if ([needAccessoryIcon[i] boolValue]) {
            UIImageView* accessoryView = [[UIImageView alloc] initWithImage:accessory];
            cell.accessoryView = accessoryView;
        }
        
        // Cell background color
        if ([needCellColor[i] boolValue]) {
            cell.backgroundColor = lightGrey;
        }
    }
}

- (void)configureExerciseCell:(NSArray*)tableCell :(NSArray*)repNamesArray :(NSArray*)exerciseNamesArray :(NSArray*)previousTFArray :(NSArray*)currentTFArray :(NSArray*)exerciseLabelsArray :(NSArray*)repsLabelArray {
    
    UILabel *tempExerciseLabel;
    UILabel *tempRepLabel;
    UITextField *tempPreviousTF;
    UITextField *tempCurrentTF;
    
    //UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
    UIColor *lightGreen = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:.75f];
    
    //  Configure the Exercise Label
    for (int i = 0; i < tableCell.count; i++) {
        
        tempExerciseLabel = exerciseLabelsArray[i];
        tempExerciseLabel.text = exerciseNamesArray[i];
        tempExerciseLabel.textColor = [UIColor orangeColor];
    }
    
    for (int i = 0; i < repsLabelArray.count; i++) {
        
        tempRepLabel = repsLabelArray[i];
        tempPreviousTF = previousTFArray[i];
        tempCurrentTF = currentTFArray[i];
        
        tempRepLabel.text = repNamesArray[i];
        
        //  Hide the reps label, current textfield, and previous textfield if the reps label is an empty string
        if ([tempRepLabel.text isEqualToString:@""]) {
            
            tempRepLabel.hidden = YES;
            tempPreviousTF.hidden = YES;
            tempCurrentTF.hidden = YES;
        }
        
        //  Configure TextField Keyboard
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            // IPHONE - Set the keyboard type of the Weight text box to DECIMAL NUMBER PAD.
            tempCurrentTF = currentTFArray[i];
            tempCurrentTF.keyboardType = UIKeyboardTypeDecimalPad;
            tempCurrentTF.keyboardAppearance = UIKeyboardAppearanceDark;
        }
        
        else {
            
            // IPAD - No decimal pad on ipad so set it to numbers and punctuation.
            tempCurrentTF = currentTFArray[i];
            tempCurrentTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            tempCurrentTF.keyboardAppearance = UIKeyboardAppearanceDark;
        }
        
        //  Labels
        tempRepLabel.textColor = [UIColor darkGrayColor];
        
        //  Current textfields
        tempCurrentTF.textColor = [UIColor whiteColor];
        tempCurrentTF.layer.borderWidth = 1.0f;
        tempCurrentTF.layer.borderColor = [lightGreen CGColor];
        tempCurrentTF.layer.cornerRadius = 5;
        tempCurrentTF.clipsToBounds = YES;
        tempCurrentTF.backgroundColor = lightGreen;
        tempCurrentTF.clearsOnBeginEditing = YES;
        tempCurrentTF.textAlignment = NSTextAlignmentCenter;
        tempCurrentTF.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        
        //  Previous textfields
        tempPreviousTF.layer.borderWidth = 1.0f;
        tempPreviousTF.layer.borderColor = [lightGreen CGColor];
        tempPreviousTF.layer.cornerRadius = 5;
        tempPreviousTF.clipsToBounds = YES;
        tempPreviousTF.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tempPreviousTF.userInteractionEnabled = NO;
        tempPreviousTF.textAlignment = NSTextAlignmentCenter;
        tempPreviousTF.textColor = [UIColor lightGrayColor];
    }
    
    //NSLog(@"Section = %d", [section intValue]);
}

/*
- (UIView*)configureSectionHeader:(NSArray*)tvHeaderStrings :(int)tvWidth :(int)tvSection {
    
    UIView *hView = [[UIView alloc] initWithFrame:CGRectZero];
    hView.backgroundColor=[UIColor clearColor];
    
    int x;
    int fontSize;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        // iPad
        x = 55;
        fontSize = 22;
    }
    else {
        // iPhone
        x = 20;
        fontSize = 19;
    }
    
    UILabel *hLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, tvWidth, 22)];
    
    hLabel.backgroundColor = [UIColor clearColor];
    hLabel.shadowColor = [UIColor darkTextColor];
    hLabel.shadowOffset = CGSizeMake(0, -1);  // closest as far as I could tell
    hLabel.textColor = [UIColor whiteColor];  // or whatever you want
    hLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    
    hLabel.text = tvHeaderStrings[tvSection];
    
    [hView addSubview:hLabel];
    
    return hView;
}
 */
@end
