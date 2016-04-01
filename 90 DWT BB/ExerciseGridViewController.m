//
//  ExerciseGridViewController.m
//  90 DWT BB
//
//  Created by Grant, Jared on 3/30/16.
//  Copyright © 2016 Jared Grant. All rights reserved.
//

#import "ExerciseGridViewController.h"

@interface ExerciseGridViewController ()

@end

@implementation ExerciseGridViewController
{
    ShinobiDataGrid *_shinobiDataGrid;
    NSArray* _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _shinobiDataGrid = [[ShinobiDataGrid alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 0)];
    _shinobiDataGrid.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _shinobiDataGrid.dataSource = self;
    _shinobiDataGrid.minimumColWidth = @0;
    _shinobiDataGrid.minimumRowHeight = @0;
    
    //_shinobiDataGrid.singleTapEventMask = SDataGridEventNone;
    _shinobiDataGrid.defaultSectionHeaderStyle.font = [UIFont systemFontOfSize:9];
    _shinobiDataGrid.defaultSectionHeaderStyle.height = 30;
    
    _shinobiDataGrid.defaultCellStyleForSelectedRows.font = [UIFont systemFontOfSize:8];
    _shinobiDataGrid.defaultCellStyleForSelectedRows.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    [self createSomeTestData];
    
    //    // Set the padding for the cell.
    //    UIEdgeInsets padding = UIEdgeInsetsMake(5, 5, 5, 5);
    //
    //    // Create an alternating row style.
    //    SDataGridCellStyle* alternatingRowStyle = [[SDataGridCellStyle alloc] init];
    //    //alternatingRowStyle.font = font;
    //    alternatingRowStyle.contentInset = padding;
    //    //alternatingRowStyle.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    //
    //    // Create the header style.
    //    // Style the headers to have a dark background, and white text.
    //    SDataGridCellStyle* headerStyle = [[SDataGridCellStyle alloc] init];
    //    //headerStyle.font = font;
    //    headerStyle.contentInset = padding;
    
    // add a name column
    SDataGridColumn* oneCell = [[SDataGridColumn alloc] initWithTitle:@"15"];
    oneCell.tag = 1;
    oneCell.width = @56;
    oneCell.cellStyle.font = [UIFont systemFontOfSize:8];
    oneCell.cellStyle.contentInset =  UIEdgeInsetsMake(0, 15, 0, 15);
    
    //oneCell.cellStyle.textAlignment = NSTextAlignmentCenter;
    
    //nameColumn.width = UIViewAutoresizingFlexibleWidth;
    //nameColumn.width = @484;
    //nameColumn.width = @135;
    [_shinobiDataGrid addColumn:oneCell];
    
    // add an age column
    SDataGridColumn* twoCell = [[SDataGridColumn alloc] initWithTitle:@"12"];
    twoCell.width = @56;
    twoCell.cellStyle.font = [UIFont systemFontOfSize:8];
    twoCell.cellStyle.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    //ageColumn.width = @200;
    [_shinobiDataGrid addColumn:twoCell];
    
    // add an age column
    SDataGridColumn* threeCell = [[SDataGridColumn alloc] initWithTitle:@"8"];
    threeCell.width = @56;
    threeCell.cellStyle.font = [UIFont systemFontOfSize:8];
    threeCell.cellStyle.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    //ageColumn.width = @200;
    [_shinobiDataGrid addColumn:threeCell];
    
    // add a name column
    SDataGridColumn* fourCell = [[SDataGridColumn alloc] initWithTitle:@"8"];
    fourCell.width = @56;
    fourCell.cellStyle.font = [UIFont systemFontOfSize:8];
    fourCell.cellStyle.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    //nameColumn.width = UIViewAutoresizingFlexibleWidth;
    //nameColumn.width = @484;
    //nameColumn.width = @135;
    [_shinobiDataGrid addColumn:fourCell];
    
    // add an age column
    SDataGridColumn* fiveCell = [[SDataGridColumn alloc] initWithTitle:@"12"];
    fiveCell.width = @56;
    fiveCell.cellStyle.font = [UIFont systemFontOfSize:8];
    fiveCell.cellStyle.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    //ageColumn.width = @200;
    [_shinobiDataGrid addColumn:fiveCell];
    
    // add an age column
    SDataGridColumn* sixCell = [[SDataGridColumn alloc] initWithTitle:@"15"];
    sixCell.width = @56;
    sixCell.cellStyle.font = [UIFont systemFontOfSize:8];
    sixCell.cellStyle.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    //ageColumn.width = @200;
    [_shinobiDataGrid addColumn:sixCell];
    
    
    // add a Notes column
    SDataGridColumn* notesCell = [[SDataGridColumn alloc] initWithTitle:@"Notes"];
    //notesCell.width = @62;
    notesCell.cellStyle.font = [UIFont systemFontOfSize:8];
    notesCell.cellStyle.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    //ageColumn.width = @200;
    [_shinobiDataGrid addColumn:notesCell];
    
    //_shinobiDataGrid.defaultHeaderRowHeight = @25;
    
    _shinobiDataGrid.defaultCellStyleForHeaderRow.font = [UIFont systemFontOfSize:10];
    //    _shinobiDataGrid.defaultColWidth = @30;
    _shinobiDataGrid.defaultRowHeight = @30;
    _shinobiDataGrid.defaultCellStyleForHeaderRow.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    //_shinobiDataGrid.defaultCellStyleForHeaderRow.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_shinobiDataGrid];
}

- (void)createSomeTestData
{
    // create some data to populate the grid
//    _data = @[[PersonDataObject personWithName:@"Leonardo" age:@55.5],
//              [PersonDataObject personWithName:@"Michelangelo" age:@55.5],
//              [PersonDataObject personWithName:@"Donatello" age:@55.5],
//              [PersonDataObject personWithName:@"Raphael" age:@55.5]];
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

#pragma mark - SDataGridDataSource methods

- (NSUInteger)numberOfSectionsInShinobiDataGrid:(ShinobiDataGrid *)grid {
    
    NSUInteger numSections = [[self findMaxSessionValue] integerValue];
    return numSections;
}

- (NSString *)shinobiDataGrid:(ShinobiDataGrid *)grid titleForHeaderInSection:(NSInteger)section {
    
    NSString *sectionString = [NSString stringWithFormat:@"Session %ld", (long)section + 1];
    
    return sectionString;
}

-(NSUInteger)shinobiDataGrid:(ShinobiDataGrid *)grid numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSInteger highestIndexFound = [self GetHighestDatabaseIndex];
    
    return highestIndexFound;
}

- (void)shinobiDataGrid:(ShinobiDataGrid *)grid prepareCellForDisplay:(SDataGridCell *)cell
{
    // both columns use a SDataGridTextCell, so we are safe to perform this cast
    SDataGridTextCell* textCell = (SDataGridTextCell*)cell;
    
    // locate the person that is rendered on this row
    //PersonDataObject* person = _data[cell.coordinate.row.rowIndex];
    
    //    // determine which column this cell belongs to
    //    if ([cell.coordinate.column.title isEqualToString:@"Name"])
    //    {
    //        // render the name in the 'name' column
    //        textCell.textField.text = person.name;
    //    }
    //    if ([cell.coordinate.column.title isEqualToString:@"Age"])
    //    {
    //        // render the age in the 'age' column
    //        textCell.textField.text = [person.age stringValue];
    //    }
    //
    //    if (cell.coordinate.column.tag == 1) {
    //
    //        textCell.textField.text = person.name;
    //    }
    
    if (cell.coordinate.column.tag == 1) {
        
        //textCell.textField.text = [person.age stringValue];
        textCell.textField.text = [@15 stringValue];
    }
    
    else {
        
        textCell.textField.text = [@55.5 stringValue];
    }
}

#pragma mark - Utility Methods

-(NSInteger)GetHighestDatabaseIndex {
    
    // Get Data from the database.
    self.context = [[CoreDataHelper sharedHelper] context];
    
    // Fetch current session data.
    NSString *currentSessionString = [self.appDelegate getCurrentSession];
    
    self.entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:self.context];
    self.request = [[NSFetchRequest alloc] init];
    [self.request setEntity:self.entityDesc];
    self.pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@)",
                 currentSessionString,
                 self.appDelegate.graphRoutine,
                 self.appDelegate.graphWorkout,
                 self.appDelegate.graphTitle];
    [self.request setPredicate:self.pred];
    
    NSError *error;
    self.objects = [self.context executeFetchRequest:self.request error:&error];
    
    NSNumber *highestDatabaseIndex = 0;
    
    for (int i = 0; i < self.objects.count / 6; i++) {
        
        self.matches = nil;
        self.matches = [self.objects objectAtIndex:i * 6];
        NSNumber *objectIndex = self.matches.index;
        //NSLog(@"objectIndex = %@", objectIndex);
        
        if ([objectIndex integerValue] > [highestDatabaseIndex integerValue]) {
            highestDatabaseIndex = objectIndex;
        }
    }
    
    //NSLog(@"Highest Database Index = %@", highestDatabaseIndex);
    
    return [highestDatabaseIndex integerValue];
}

-(BOOL)ColumnSeriesMatchAtIndex :(NSUInteger)workoutIndex {
    
    NSNumber *tempWorkoutIndex = [NSNumber numberWithInteger:workoutIndex + 1];
    
    // Get Data from the database.
    self.context = [[CoreDataHelper sharedHelper] context];
    
    // Fetch current session data.
    NSString *currentSessionString = [self.appDelegate getCurrentSession];
    
    self.entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:self.context];
    self.request = [[NSFetchRequest alloc] init];
    [self.request setEntity:self.entityDesc];
    self.pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (index == %@)",
                 currentSessionString,
                 self.appDelegate.graphRoutine,
                 self.appDelegate.graphWorkout,
                 self.appDelegate.graphTitle,
                 tempWorkoutIndex];
    [self.request setPredicate:self.pred];
    
    NSError *error;
    self.objects = [self.context executeFetchRequest:self.request error:&error];
    
    if (self.objects.count == 0) {
        
        return FALSE;
    }
    
    else {
        
        return TRUE;
    }
}

-(void)matchAtIndex :(NSInteger)round :(NSUInteger)workoutIndex{
    
    NSNumber *roundConverted = [NSNumber numberWithInteger:round];
    
    NSNumber *tempWorkoutIndex = [NSNumber numberWithInteger:workoutIndex + 1];
    
    // @"B2: Chest - Russian Twist" is the only one that starts out in the second index of an array.
    NSString *tempString = [NSString stringWithFormat:@"%@ - %@", self.appDelegate.graphWorkout, self.appDelegate.graphTitle];
    if ([tempString isEqualToString:@"B2: Chest - Russian Twist"]) {
        
        roundConverted = [NSNumber numberWithInteger:round + 1];
    }
    
    // Get Data from the database.
    self.context = [[CoreDataHelper sharedHelper] context];
    
    // Fetch current session data.
    NSString *currentSessionString = [self.appDelegate getCurrentSession];
    
    self.entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:self.context];
    self.request = [[NSFetchRequest alloc] init];
    [self.request setEntity:self.entityDesc];
    self.pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round == %@) AND (index == %@)",
                 currentSessionString,
                 self.appDelegate.graphRoutine,
                 self.appDelegate.graphWorkout,
                 self.appDelegate.graphTitle,
                 roundConverted,
                 tempWorkoutIndex];
    [self.request setPredicate:self.pred];
    
    NSError *error;
    self.objects = [self.context executeFetchRequest:self.request error:&error];
}
@end
