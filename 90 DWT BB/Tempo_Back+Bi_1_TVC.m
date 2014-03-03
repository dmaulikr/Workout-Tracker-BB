//
//  Tempo_Back+Bi_1_TVC.m
//  90 DWT BB
//
//  Created by Jared Grant on 3/1/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "Tempo_Back+Bi_1_TVC.h"
#import "UITableViewController+Database.h"
#import "UITableViewController+Design.h"
#import "DataNavController.h"

@interface Tempo_Back_Bi_1_TVC ()

@end

@implementation Tempo_Back_Bi_1_TVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadArrays];
    
    self.canDisplayBannerAds = YES;
    
    self.navigationItem.title = ((DataNavController *)self.parentViewController).workout;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadArrays {
    
    NSArray *Titles1 = @[@"Dumbbell Pull-Over",
                         @"Plank Hop"];
    
    NSArray *Titles2 = @[@"Pull-Up",
                         @"Hanging Side-To-Side Crunch"];
    
    NSArray *Titles3 = @[@"Curl Bar Row",
                         @"Curl Bar Twist"];
    
    NSArray *Titles4 = @[@"Dumbbell Preacher Curl",
                         @"Hanging Crunch"];
    
    NSArray *Titles5 = @[@"Curl Bar Multi Curl",
                         @"Mountain Climber"];
    
    NSArray *repNameArray1 = @[@"15",
                               @"12",
                               @"8",
                               @"",
                               @"",
                               @""];
    
    NSArray *repNameArray2 = @[@"10",
                               @"",
                               @"",
                               @"",
                               @"",
                               @""];
    
    NSArray *repNameArray3 = @[@"30",
                               @"",
                               @"",
                               @"",
                               @"",
                               @""];
    
    NSArray *repArraySection1 = @[repNameArray1,
                                  repNameArray2];
    
    NSArray *repArraySection2 = @[repNameArray1,
                                  repNameArray2];
    
    NSArray *repArraySection3 = @[repNameArray1,
                                  repNameArray2];
    
    NSArray *repArraySection4 = @[repNameArray1,
                                  repNameArray2];
    
    NSArray *repArraySection5 = @[repNameArray1,
                                  repNameArray3];
    
    self.Titles = @[Titles1,
                    Titles2,
                    Titles3,
                    Titles4,
                    Titles5];
    
    self.Reps = @[repArraySection1,
                  repArraySection2,
                  repArraySection3,
                  repArraySection4,
                  repArraySection5];
    
    self.CellArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.Titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSArray *tempSectionTitleArray = self.Titles[section];
    
    return tempSectionTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExerciseCell *cell;
    
    NSString *cellIdentifier = @"ExerciseCell";
    cellIdentifier = [cellIdentifier stringByAppendingFormat:@"%d", indexPath.section + 1];
    cell = (ExerciseCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //  Configure the cell...
    [self configureExerciseCell:cell :indexPath :self.Reps[indexPath.section] :self.Titles[indexPath.section]];
    
    //  Get data from the database
    //NSInteger section = [indexPath section];
    [self exerciseMatches:cell :indexPath];
    
    /*
     //  Only save cells in the current section so that you can access them later when you need to save to database.
     if (indexPath.section == 0 && self.CellArray.count < self.Titles.count) {
     [self.CellArray addObject:cell];
     }
     */
    
    [self.CellArray addObject:cell];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *headerTitle = @"";
    headerTitle = [headerTitle stringByAppendingFormat:@"Set %d of %d", section + 1, self.Titles.count];
    
    return headerTitle;
}

- (IBAction)submitEntries:(id)sender {
    
    //  Save to the database
    [self saveToDatabase:self.CellArray];
    
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */
@end
