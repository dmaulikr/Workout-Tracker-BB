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

- (void)configureExerciseCell:(ExerciseCell*)cell :(NSIndexPath *)indexPath :(NSArray*)repNamesArray :(NSArray*)exerciseNamesArray {
    
    ExerciseCell *tempCell = cell;
    int tempSection = indexPath.section;
    int tempRow = indexPath.row;
    
    NSArray *tempCellRepsLabelArray = @[tempCell.repLabel1,
                                        tempCell.repLabel2,
                                        tempCell.repLabel3,
                                        tempCell.repLabel4,
                                        tempCell.repLabel5,
                                        tempCell.repLabel6];
    
    NSArray *tempCellWeightFieldArray = @[tempCell.weightField1,
                                          tempCell.weightField2,
                                          tempCell.weightField3,
                                          tempCell.weightField4,
                                          tempCell.weightField5,
                                          tempCell.weightField6];
    
    // Configure the cell...
    
    tempCell.exerciseLabel.text = exerciseNamesArray[tempRow];
    
    if (tempSection == 0) {
        
        tempCell.exerciseLabel.textColor = [UIColor orangeColor];
    }
    
    else {
        
        tempCell.exerciseLabel.textColor = [UIColor darkGrayColor];
    }
    
    NSArray *tempRepNamesArray = repNamesArray[tempRow];
    
    //  Configure Reps Label.
    for (int i = 0; i < tempRepNamesArray.count; i++) {
        
        UILabel *genericRepLabel = tempCellRepsLabelArray[i];
        genericRepLabel.text = tempRepNamesArray[i];
        
        //  Hide the label and textfield if label = "".
        if ([genericRepLabel.text isEqualToString:@""]) {
            
            UITextField *genericWeightField = tempCellWeightFieldArray[i];
            genericRepLabel.hidden = YES;
            genericWeightField.hidden = YES;
        }
    }
    
    //  Configure TextField Keyboard
    for (int i = 0; i < tempCellWeightFieldArray.count; i++) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            // IPHONE - Set the keyboard type of the Weight text box to DECIMAL NUMBER PAD.
            UITextField *textfield = tempCellWeightFieldArray[i];
            textfield.keyboardType = UIKeyboardTypeDecimalPad;
            textfield.keyboardAppearance = UIKeyboardAppearanceDark;
        }
        
        else {
            
            // IPAD - No decimal pad on ipad so set it to numbers and punctuation.
            UITextField *textfield = tempCellWeightFieldArray[i];
            textfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            textfield.keyboardAppearance = UIKeyboardAppearanceDark;
        }
    }
    
    UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
    UIColor *lightGreen = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:.15f];
    
    for (int i = 0; i < tempCellWeightFieldArray.count; i++) {
        
        UITextField *tempTextField = tempCellWeightFieldArray[i];
        
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
