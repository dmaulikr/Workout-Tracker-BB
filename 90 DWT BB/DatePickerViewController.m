//
//  DatePickerViewController.m
//  90 DWT BB
//
//  Created by Jared Grant on 3/8/15.
//  Copyright (c) 2015 Jared Grant. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if ((sysVer >= 8.0) || (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
        
        // Grab the selected date on the date picker.
        // Datepicker was presented in a popover.
        // Save data when user touches outside the popover.
        NSDate *chosen = [self.datePicker date];
        //NSLog(@"Modal Date = %@", chosen);

        [self saveWorkoutComplete:chosen];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)hideIOS8PopOver {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    [self hideIOS8PopOver];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    // Grab the selected date on the date picker
    NSDate *chosen = [self.datePicker date];
    //NSLog(@"Modal Date = %@", chosen);
    
    [self saveWorkoutComplete:chosen];
    
    [self hideIOS8PopOver];
}
@end
