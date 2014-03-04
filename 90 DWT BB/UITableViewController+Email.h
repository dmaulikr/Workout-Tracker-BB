//
//  UITableViewController+Email.h
//  90 DWT BB
//
//  Created by Grant, Jared on 3/4/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UITableViewController (Email)

- (NSString*)stringForEmail:(NSArray*)cell;
- (void)sendEmail:(NSString*)csvString;
@end
