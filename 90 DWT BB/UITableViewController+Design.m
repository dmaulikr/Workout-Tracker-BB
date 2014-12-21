//
//  UITableViewController+Design.m
//  90 DWT 2
//
//  Created by Grant, Jared on 11/17/12.
//  Copyright (c) 2012 Grant, Jared. All rights reserved.
//

#import "UITableViewController+Design.h"

@implementation UITableViewController (Design)

- (void)configureAccessoryIcon:(NSArray*)tableViewCellArray :(NSArray*)needsAccessoryIcon{
    
    //UIColor *lightGrey = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f];
    //UIColor *midGrey = [UIColor colorWithRed:219/255.0f green:218/255.0f blue:218/255.0f alpha:1.0f];
    //UIColor *darkGrey = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f];
    
    // TableView background color
    //self.tableView.backgroundColor = midGrey;
    
    // Accessory view icon
    UIImage* accessory = [UIImage imageNamed:@"nav_r_arrow_grey"];
    UITableViewCell *cell;
    UIImageView* accessoryView;
    
    for (int i = 0; i < tableViewCellArray.count; i++) {
        
        cell = tableViewCellArray[i];
        
        // Label backgrounds
        //UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
        //UIColor* detailTextColor = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:255/255.0f alpha:1.0f];
        //cell.detailTextLabel.textColor = [UIColor orangeColor];
        
        // Label and Subtitle Font Size
        UIFont *labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        [cell.textLabel setFont:labelFont];
        
        UIFont *detailFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        [cell.detailTextLabel setFont:detailFont];
        
        // Accessory view icon
        if ([needsAccessoryIcon[i] boolValue]) {
            accessoryView = [[UIImageView alloc] initWithImage:accessory];
            cell.accessoryView = accessoryView;
        }
        
        /*
        // Cell background color
        if ([needCellColor[i] boolValue]) {
            cell.backgroundColor = lightGrey;
        }
         */
    }
}

- (void)configureCellBox:(NSArray*)cellBoxArray {
    
    UITextField *tempTextBox;
    
    for (int i = 0; i < cellBoxArray.count; i++) {
        
        tempTextBox = cellBoxArray[i];
        
        tempTextBox.layer.borderWidth = 1.0f;
        //tempTextBox.layer.borderColor = [lightGreen CGColor];
        tempTextBox.layer.cornerRadius = 15.0f;
        tempTextBox.clipsToBounds = YES;
        
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        [tempTextBox setFont:font];
        
    }
}

- (void)configureWorkoutLabels:(NSArray*)tableViewLabelArray :(NSArray*)tableViewDetailArray {
    
    UILabel *tempLabel;
    UILabel *tempDetail;
    
    UIFont *labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    UIFont *detailFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    
    // Label
    for (int i = 0; i < tableViewLabelArray.count; i++) {
        
        tempLabel = tableViewLabelArray[i];
        [tempLabel setFont:labelFont];
    }
    
    // Detail
    for (int i = 0; i < tableViewDetailArray.count; i++) {
        
        tempDetail = tableViewDetailArray[i];
        [tempDetail setFont:detailFont];
    }
}

- (void)configureExerciseCell:(NSArray*)tableCell :(NSArray*)repNamesArray :(NSArray*)exerciseNamesArray :(NSArray*)previousTFArray :(NSArray*)currentTFArray :(NSArray*)exerciseLabelsArray :(NSArray*)repsLabelArray :(NSArray*)prevNotesArray :(NSArray*)curNotesArray : (NSArray*)graphBtnArray {
    
    UILabel *tempExerciseLabel;
    UIButton *tempGraphButton;
    UITextField *tempPreviousNotes;
    UITextField *tempCurrentNotes;
    UILabel *tempRepLabel;
    UITextField *tempPreviousTF;
    UITextField *tempCurrentTF;
    
    //UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
    UIColor *lightGreen = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:.75f];
    
    //  Configure the Exercise Label, Graph Button, Previous Notes, and Current Notes
    for (int i = 0; i < tableCell.count; i++) {
        
        // Exercise Label
        tempExerciseLabel = exerciseLabelsArray[i];
        tempExerciseLabel.text = exerciseNamesArray[i];
        tempExerciseLabel.textColor = [UIColor orangeColor];
        UIFont *exerciseLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        [tempExerciseLabel setFont:exerciseLabelFont];
        
        // Graph Button
        tempGraphButton = graphBtnArray[i];
        tempGraphButton.hidden = YES;
        
        // Previous Notes
        tempPreviousNotes = prevNotesArray[i];
        tempPreviousNotes.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tempPreviousNotes.userInteractionEnabled = NO;
        tempPreviousNotes.textColor = [UIColor lightGrayColor];
        UIFont *previousNotesFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        [tempPreviousNotes setFont:previousNotesFont];
        
        tempPreviousNotes.layer.borderWidth = 1.0f;
        tempPreviousNotes.layer.borderColor = [lightGreen CGColor];
        tempPreviousNotes.layer.cornerRadius = 5;
        
        // Current Notes
        tempCurrentNotes = curNotesArray[i];
        tempCurrentNotes.textColor = [UIColor whiteColor];
        tempCurrentNotes.backgroundColor = lightGreen;
        tempCurrentNotes.clearButtonMode = UITextFieldViewModeWhileEditing;
        tempCurrentNotes.keyboardAppearance = UIKeyboardAppearanceDark;
        UIFont *currentNotesFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        [tempCurrentNotes setFont:currentNotesFont];
        
        tempCurrentNotes.layer.borderWidth = 1.0f;
        tempCurrentNotes.layer.borderColor = [lightGreen CGColor];
        tempCurrentNotes.layer.cornerRadius = 5;
        
        tempCurrentNotes.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"New Notes" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} ];
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
        UIFont *repLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        [tempRepLabel setFont:repLabelFont];
        
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

- (void)configureStoreTableView:(NSArray*)tableCell :(NSArray*)needAccessoryIcon :(NSArray*)needCellColor {
    
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
        UIColor* detailTextColor = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:255/255.0f alpha:1.0f];
        cell.detailTextLabel.textColor = detailTextColor;
        
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
