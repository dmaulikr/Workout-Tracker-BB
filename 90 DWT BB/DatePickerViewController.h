//
//  DatePickerViewController.h
//  90 DWT BB
//
//  Created by Jared Grant on 3/8/15.
//  Copyright (c) 2015 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end
