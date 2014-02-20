//
//  Exercise_TVC.m
//  90 DWT BB
//
//  Created by Jared Grant on 2/16/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "Exercise_TVC.h"

@interface Exercise_TVC ()

@end

@implementation Exercise_TVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setUpVariables {
    
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mainAppDelegate.routine = ((DataNavController *)self.parentViewController).routine;
    mainAppDelegate.week = ((DataNavController *)self.parentViewController).week;
    mainAppDelegate.workout =((DataNavController *)self.parentViewController).workout;
    mainAppDelegate.index = ((DataNavController *)self.parentViewController).index;
}

-(void)keyboardType {
    
    // Set keyboard type
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        // IPHONE - Set the keyboard type of the Weight text box to DECIMAL NUMBER PAD.
        for (int i = 0; i < self.currentTextFieldArray.count; i++) {
            UITextField *textfield = self.currentTextFieldArray[i];
            textfield.keyboardType = UIKeyboardTypeDecimalPad;
        }
    }
    
    else {
        
        // IPAD - No decimal pad on ipad so set it to numbers and punctuation.
        for (int i = 0; self.currentTextFieldArray; i++) {
            UITextField *textfield = self.currentTextFieldArray[i];
            textfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
    }
}

-(void)setUpArrays {
    self.currentTextFieldArray = @[self.currentCell1Wt1,
                                   self.currentCell1Wt2,
                                   self.currentCell1Wt3,
                                   self.currentCell1Wt4];
    
    self.previousTextFieldArray = @[self.previousCell1Wt1,
                                    self.previousCell1Wt2,
                                    self.previousCell1Wt3,
                                    self.previousCell1Wt4];
    
    self.currentRepsLabelArray = @[self.currentRepsLabel1,
                                   self.currentRepsLabel2,
                                   self.currentRepsLabel3,
                                   self.currentRepsLabel4];
    
    self.previousRepsLabelArray = @[self.previousRepsLabel1,
                                    self.previousRepsLabel2,
                                    self.previousRepsLabel3,
                                    self.previousRepsLabel4];
    
    self.currentExerciseLabelArray = @[self.currentCellLabel1];
    self.previousExerciseLabelArray = @[self.previousCellLabel1];
    
    self.currentCellsArray = @[self.currentCell1];
    self.previousCellsArray = @[self.previousCell1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpVariables];
    [self setUpArrays];
    [self keyboardType];
    
    self.canDisplayBannerAds = YES;
    
    [self queryDatabase];
    
    //[self exerciseMatches];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 2;
}

-(void)queryDatabase {
    
    // Current Fields
    for (int i = 0; i < self.currentCellsArray.count; i++) {
        
        //NSArray *textFieldsInRowArray;
        
        UITableViewCell *currentCell = self.currentCellsArray[i];
        
        for (int a = 0; a < self.currentTextFieldArray.count; a++) {
            
            NSString *currentCellString = @"currentCell";
            currentCellString = [currentCellString stringByAppendingFormat:@"%d", a + 1];
            
        }
        

    }
    
    NSString *someString = @"Time for an egg hunt";
    
    if ( [someString rangeOfString:@"egg" options:NSCaseInsensitiveSearch].location != NSNotFound ) {
        NSLog( @"Found it!" );
    }
    
}

/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
 */

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

- (IBAction)hideKeyboard:(id)sender {
    [self.currentCell1Wt1 resignFirstResponder];
    [self.currentCell1Wt2 resignFirstResponder];
    [self.currentCell1Wt3 resignFirstResponder];
    [self.currentCell1Wt4 resignFirstResponder];
}

/*
-(void)queryDatabase {
    
    // Get Data from the database.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %d)",
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         self.currentExercise.title,
                         self.renamedRound,
                         [((DataNavController *)self.parentViewController).index integerValue]];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    int workoutIndex = [((DataNavController *)self.parentViewController).index integerValue];
    //NSLog(@"Workout = %@ index = %@", ((DataNavController *)self.parentViewController).workout, ((DataNavController *)self.parentViewController).index);
    
    // 1st time exercise is done only.
    if (workoutIndex == 1) {
        // The workout has not been done before.
        // Do NOT get previous workout data.
        // Set the current placeholders to defaults/nil.
        
        if ([objects count] == 0) {
            //NSLog(@"viewDidLoad = No matches - Exercise has not been done before - set previous textfields to nil");
            
            self.currentReps.placeholder = @"0";
            self.currentWeight.placeholder = @"0.0";
            self.currentNotes.placeholder = @"Type any notes here";
            
            self.previousReps.text = @"";
            self.previousWeight.text = @"";
            self.previousNotes.text = @"";
        }
        
        // The workout has been done 1 time but the user came back to the 1st week workout screen to update or view.
        // Only use the current 1st week workout data when the user comes back to this screen.
        
        else {
            //NSLog(@"viewDidLoad = Match found - set previous textfields to stored values for this weeks workout");
            
            matches = objects[[objects count] -1];
            
            self.currentReps.placeholder = @"";
            self.currentWeight.placeholder = @"";
            self.currentNotes.placeholder = @"";
            
            self.previousReps.text = [matches valueForKey:@"reps"];
            self.previousWeight.text = [matches valueForKey:@"weight"];
            self.previousNotes.text = [matches valueForKey:@"notes"];
        }
        
    }
    
    // 2nd time exercise has been done and beyond.
    else {
        
        // This workout with this index has been done before.
        // User came back to look at his results so display this weeks results in the current results section.
        if ([objects count] == 1) {
            matches = objects[[objects count] -1];
            
            self.currentReps.placeholder = [matches valueForKey:@"reps"];
            self.currentWeight.placeholder = [matches valueForKey:@"weight"];
            self.currentNotes.placeholder = [matches valueForKey:@"notes"];
            //NSLog(@"Current Reps = %@", self.currentReps.placeholder);
            //NSLog(@"Current Weight = %@", self.currentWeight.placeholder);
            //NSLog(@"Current Notes = %@", self.currentNotes.placeholder);
        }
        
        // This workout with this index has NOT been done before.
        // Set the current placeholders to defaults/nil.
        else {
            self.currentReps.placeholder = @"0";
            self.currentWeight.placeholder = @"0.0";
            self.currentNotes.placeholder = @"Type any notes here";
        }
        
        // This is at least the 2nd time a particular workout has been started.
        // Get the previous workout data and present it to the user in the previous section.
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %d)",
                             ((DataNavController *)self.parentViewController).routine,
                             ((DataNavController *)self.parentViewController).workout,
                             self.currentExercise.title,
                             self.renamedRound,
                             [((DataNavController *)self.parentViewController).index integerValue] -1];  // Previous workout index.
        [request setPredicate:pred];
        NSManagedObject *matches = nil;
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if ([objects count] == 1) {
            matches = objects[[objects count]-1];
            
            self.previousReps.text = [matches valueForKey:@"reps"];
            self.previousWeight.text = [matches valueForKey:@"weight"];
            self.previousNotes.text = [matches valueForKey:@"notes"];
            //NSLog(@"Previous Reps = %@", self.previousReps.text);
            //NSLog(@"Previous Weight = %@", self.previousWeight.text);
            //NSLog(@"Previous Notes = %@", self.previousNotes.text);
        }
        
        else {
            self.previousReps.text = @"";
            self.previousWeight.text = @"";
            self.previousNotes.text = @"No record for the last workout";
        }
    }
}
*/

- (IBAction)submitEntry:(id)sender {
 
 /*
    NSDate *todaysDate = [NSDate date];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %d)",
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         self.currentExercise.title,
                         self.renamedRound,
                         [((DataNavController *)self.parentViewController).index integerValue]];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0) {
        //NSLog(@"submitEntry = No matches - create new record and save");
        
        NSManagedObject *newExercise;
        newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:context];
        [newExercise setValue:self.currentReps.text forKey:@"reps"];
        [newExercise setValue:self.currentWeight.text forKey:@"weight"];
        [newExercise setValue:self.currentNotes.text forKey:@"notes"];
        [newExercise setValue:todaysDate forKey:@"date"];
        [newExercise setValue:self.currentExercise.title forKey:@"exercise"];
        [newExercise setValue:self.renamedRound forKey:@"round"];
        [newExercise setValue:((DataNavController *)self.parentViewController).routine forKey:@"routine"];
        [newExercise setValue:((DataNavController *)self.parentViewController).month forKey:@"month"];
        [newExercise setValue:((DataNavController *)self.parentViewController).week forKey:@"week"];
        [newExercise setValue:((DataNavController *)self.parentViewController).workout forKey:@"workout"];
        [newExercise setValue:((DataNavController *)self.parentViewController).index forKey:@"index"];
        
    } else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        
        matches = objects[[objects count]-1];
        
        // Only update the fields that have been changed.
        if (self.currentReps.text.length != 0) {
            [matches setValue:self.currentReps.text forKey:@"reps"];
            
        }
        if (self.currentWeight.text.length != 0) {
            [matches setValue:self.currentWeight.text forKey:@"weight"];
            
        }
        if (self.currentNotes.text.length != 0) {
            [matches setValue:self.currentNotes.text forKey:@"notes"];
        }
        [matches setValue:todaysDate forKey:@"date"];
        
    }
    
    [context save:&error];
    
    [request setPredicate:pred];
    matches = nil;
    objects = nil;
    objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 1) {
        matches = objects[[objects count]-1];
        self.currentReps.placeholder = [matches valueForKey:@"reps"];
        self.currentWeight.placeholder = [matches valueForKey:@"weight"];
        self.currentNotes.placeholder = [matches valueForKey:@"notes"];
    }
    
    self.currentReps.text = @"";
    self.currentWeight.text = @"";
    self.currentNotes.text = @"";
    
    [self hideKeyboard:sender];
  */
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return @"CURRENT";
    }
    
    else {
        
        return @"PREVIOUS";
    }
}

@end
