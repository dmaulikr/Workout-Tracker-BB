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

- (void)configureExerciseCell:(NSArray*)tableCell :(NSIndexPath *)indexPath :(NSArray*)repNamesArray :(NSArray*)exerciseNamesArray {
    
    int tempSection = indexPath.section;
    int tempRow = indexPath.row;
    
    NSArray *tempCellRepsLabelArray = @[cell.repLabel1,
                                        cell.repLabel2,
                                        cell.repLabel3,
                                        cell.repLabel4,
                                        cell.repLabel5,
                                        cell.repLabel6];
    
    NSArray *tempCellWeightFieldArray = @[cell.weightField1,
                                          cell.weightField2,
                                          cell.weightField3,
                                          cell.weightField4,
                                          cell.weightField5,
                                          cell.weightField6];
    
    NSArray *tempCellPreviousWFArray = @[cell.previousWF1,
                                         cell.previousWF2,
                                         cell.previousWF3,
                                         cell.previousWF4,
                                         cell.previousWF5,
                                         cell.previousWF6];
    
    
    
    // Configure the cell...
    
    cell.exerciseLabel.text = exerciseNamesArray[tempRow];
    cell.exerciseLabel.textColor = [UIColor orangeColor];
    
    NSArray *tempRepNamesArray = repNamesArray[tempRow];
    
    //  Configure Reps Label.
    for (int i = 0; i < tempRepNamesArray.count; i++) {
        
        UILabel *genericRepLabel = tempCellRepsLabelArray[i];
        genericRepLabel.text = tempRepNamesArray[i];
        
        //  Hide the label and textfield if label = "".
        if ([genericRepLabel.text isEqualToString:@""]) {
            
            UITextField *genericWeightField = tempCellWeightFieldArray[i];
            UITextField *genericPreviousWF = tempCellPreviousWFArray[i];
            genericRepLabel.hidden = YES;
            genericWeightField.hidden = YES;
            genericPreviousWF.hidden = YES;
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
    UIColor *lightGreen = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:.75f];
    
    for (int i = 0; i < tempCellWeightFieldArray.count; i++) {
        
        UITextField *tempTextField = tempCellWeightFieldArray[i];
        UITextField *tempPreviousTF = tempCellPreviousWFArray[i];
        UILabel *tempLabelField = tempCellRepsLabelArray[i];
        
        //  Labels
        tempLabelField.textColor = [UIColor darkGrayColor];
        
        //  Current textfields
        tempTextField.textColor = [UIColor whiteColor];
        tempTextField.layer.borderWidth = 1.0f;
        tempTextField.layer.borderColor = [lightGreen CGColor];
        tempTextField.layer.cornerRadius = 5;
        tempTextField.clipsToBounds = YES;
        tempTextField.backgroundColor = lightGreen;
        tempTextField.clearsOnBeginEditing = YES;
        tempTextField.textAlignment = NSTextAlignmentCenter;
        tempTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        
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
    
    /*
    if (tempSection == 1 || tempSection == 3 || tempSection == 5 || tempSection == 7) {
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
   */
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
