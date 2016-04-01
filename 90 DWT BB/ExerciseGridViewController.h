//
//  ExerciseGridViewController.h
//  90 DWT BB
//
//  Created by Grant, Jared on 3/30/16.
//  Copyright © 2016 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DataNavController.h"
#import "Workout.h"
#import <ShinobiGrids/ShinobiGrids.h>
#import "CoreDataHelper.h"
#import "UIViewController+CoreData.h"

@interface ExerciseGridViewController : UIViewController <SDataGridDataSource>

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSEntityDescription *entityDesc;
@property (strong, nonatomic) NSFetchRequest *request;
@property (strong, nonatomic) NSPredicate *pred;
@property (strong, nonatomic) Workout *matches;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSArray *objects;
@end
