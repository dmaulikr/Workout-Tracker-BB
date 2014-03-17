//
//  UITableViewController+Email.h
//  90 DWT BB
//
//  Created by Grant, Jared on 3/4/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DataNavController.h"
#import <MessageUI/MessageUI.h>
#import "Workout.h"

@interface UITableViewController (Email) <MFMailComposeViewControllerDelegate>

- (NSString*)stringForEmail:(NSArray*)allTitleArray;
- (void)sendEmail:(NSString*)csvString;
@end
