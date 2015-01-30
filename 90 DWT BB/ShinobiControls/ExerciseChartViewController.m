//
//  ExerciseChartViewController.m
//  90 DWT BB
//
//  Created by Grant, Jared on 1/16/15.
//  Copyright (c) 2015 Jared Grant. All rights reserved.
//

#import "ExerciseChartViewController.h"
#import <ShinobiCharts/ShinobiCharts.h>

@interface ExerciseChartViewController () <SChartDatasource>

@end

@implementation ExerciseChartViewController
{
    ShinobiChart *chart;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    //CGFloat margin = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 10.0 : 50.0;
    chart = [[ShinobiChart alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 0)];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Only show the graph title for iOS 8 and above.  iOS 7 get the title in the navigation bar.
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (sysVer >= 8.0) {
        
        chart.title = self.appDelegate.graphTitle;
        chart.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        chart.titleCentresOn = SChartTitleCentresOnChart;
    }
    
    chart.autoresizingMask = ~UIViewAutoresizingNone;

    // Add a pair of axes
    SChartCategoryAxis *xAxis = [[SChartCategoryAxis alloc] init];
    xAxis.title = [self findXAxisTitle];
    xAxis.style.titleStyle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    //xAxis.rangePaddingLow = @(0.05);
    //xAxis.rangePaddingHigh = @(0.3);
    chart.xAxis = xAxis;

    SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] init];
    yAxis.title = [self findYAxisTitle];
    yAxis.style.titleStyle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    //yAxis.rangePaddingLow = @(1.0);
    //yAxis.rangePaddingHigh = @(1.0);
    chart.yAxis = yAxis;
    
    // Add the chart to the view controller
    [self.view addSubview:chart];
    
    chart.datasource = self;
    
    // Show legend only on iPad
    //chart.legend.hidden = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
    chart.legend.hidden = NO;
    chart.legend.style.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    chart.legend.placement = SChartLegendPlacementOutsidePlotArea;
    chart.legend.position = SChartLegendPositionBottomMiddle;
    
    // Enable gestures
    yAxis.enableGesturePanning = YES;
    yAxis.enableGestureZooming = YES;
    xAxis.enableGesturePanning = YES;
    xAxis.enableGestureZooming = YES;
    
    // Show the x and y axis gridlines
    xAxis.style.majorGridLineStyle.showMajorGridLines = YES;
    yAxis.style.majorGridLineStyle.showMajorGridLines = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Shinobi Controls

-(NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
    
    NSInteger tempMatches = [self GetNumberOfMatchesInCoreData];
    
    if (tempMatches == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Graph Data Error"
                                                        message:@"All Rep/Weight fields for this exercise must have a number in order to display the graph data."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        [alert show];
    }
    return tempMatches;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
    /*
    NSString *tempString = [NSString stringWithFormat:@"%@ - %@", self.appDelegate.graphWorkout, self.appDelegate.graphTitle];
    
    NSArray *columnSeriesWorkouts = @[@"B1: Chest+Tri - Dips",
                                      @"B1: Chest+Tri - Abs",
                                      @"B1: Back+Bi - Close-Grip Chin-Up",
                                      @"B2: Chest - Incline Dumbbell Press 2"];
    int numMatches = 0;
    for (int i = 0; i < columnSeriesWorkouts.count; i++) {
        
        if ([tempString isEqualToString:columnSeriesWorkouts[i]]) {
            
            numMatches++;
        }
    }
    
    if (numMatches == 1) {
        
        // Match - ColumnSeries
        SChartColumnSeries *columnSeries = [[SChartColumnSeries alloc] init];
        
        // Enable area fill
        //columnSeries.style.areaColorGradient = [UIColor clearColor];
        
        NSNumber *tryNumber = [NSNumber numberWithInteger:index + 1];
        
        self.matches = nil;
        self.matches = [self.objects objectAtIndex:index * 6];
        NSString *tempNote = self.matches.notes;
        
        columnSeries.title = [NSString stringWithFormat:@"Try %@ - %@", tryNumber, tempNote];
        
        return columnSeries;
    }
    else {
        
        // No Match - LineSeries
        SChartLineSeries *lineSeries = [[SChartLineSeries alloc] init];
        
        // Enable area fill
        //lineSeries.style.showFill = YES;
        //lineSeries.style.fillWithGradient = YES;
        //lineSeries.style.areaColorLowGradient = [UIColor clearColor];
        
        lineSeries.style.lineWidth = @(2.0);
        lineSeries.style.pointStyle.showPoints = YES;
        NSNumber *tryNumber = [NSNumber numberWithInteger:index + 1];
        
        self.matches = nil;
        self.matches = [self.objects objectAtIndex:index * 6];
        NSString *tempNote = self.matches.notes;
        
        lineSeries.title = [NSString stringWithFormat:@"Try %@ - %@", tryNumber, tempNote];
        
        //series.style.dataPointLabelStyle.showLabels = YES;
        
        return lineSeries;
    }
     */
    
    // ColumnSeries
    SChartColumnSeries *columnSeries = [[SChartColumnSeries alloc] init];
    
    // Enable area fill
    //columnSeries.style.areaColorGradient = [UIColor clearColor];
    
    NSNumber *tryNumber = [NSNumber numberWithInteger:index + 1];
    
    self.matches = nil;
    self.matches = [self.objects objectAtIndex:index * 6];
    NSString *tempNote = self.matches.notes;
    
    columnSeries.title = [NSString stringWithFormat:@"Try %@ - %@", tryNumber, tempNote];
    return columnSeries;
}

-(NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
    
    NSNumber *tempNumber = [NSNumber numberWithInteger:self.appDelegate.graphDataPoints.count];
    return [tempNumber integerValue];
}

-(id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
    
    SChartDataPoint *dataPoint = [[SChartDataPoint alloc] init];
    
    self.matches = nil;
    
    [self matchAtIndex:dataIndex :seriesIndex];
    self.matches = [self.objects objectAtIndex:0];
    
    NSString *tempReps = self.appDelegate.graphDataPoints[dataIndex];
    NSString *tempString1 = @"";
    NSString *tempString2 = @"";
    
    int duplicate = 0;
    
    for (int i = 0; i <= dataIndex; i++) {
        
        tempString1 = self.appDelegate.graphDataPoints[i];
        
        if ([tempReps isEqualToString:tempString1]) {
            duplicate ++;
            
            if (duplicate > 1) {
                
                tempString2 = [self createXAxisString:tempReps :[NSNumber numberWithInt:duplicate - 1]];
                
            }else {
                
                tempString2 = tempString1;
            }
        }
    }
    
    tempReps = tempString2;
    double yValue = [self.matches.weight doubleValue];
    
    dataPoint.xValue = tempReps;
    dataPoint.yValue = [NSNumber numberWithDouble:yValue];
    
    return dataPoint;
}

#pragma mark - Utility Methods

-(NSInteger)GetNumberOfMatchesInCoreData {
    
    // Get Data from the database.
    self.context = [self.appDelegate managedObjectContext];
    self.entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:self.context];
    self.request = [[NSFetchRequest alloc] init];
    [self.request setEntity:self.entityDesc];
    self.pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@)",
                         self.appDelegate.graphRoutine,
                         self.appDelegate.graphWorkout,
                         self.appDelegate.graphTitle];
    [self.request setPredicate:self.pred];
    
    NSError *error;
    self.objects = [self.context executeFetchRequest:self.request error:&error];
    
    return self.objects.count / 6;
}

-(void)matchAtIndex :(NSInteger)round :(NSUInteger)workoutIndex{
    
    NSNumber *roundConverted = [NSNumber numberWithInteger:round];
    
    NSNumber *tempWorkoutIndex = [NSNumber numberWithInteger:workoutIndex + 1];
    
    // Get Data from the database.
    self.context = [self.appDelegate managedObjectContext];
    self.entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:self.context];
    self.request = [[NSFetchRequest alloc] init];
    [self.request setEntity:self.entityDesc];
    self.pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round == %@) AND (index == %@)",
                 self.appDelegate.graphRoutine,
                 self.appDelegate.graphWorkout,
                 self.appDelegate.graphTitle,
                 roundConverted,
                 tempWorkoutIndex];
    [self.request setPredicate:self.pred];
    
    NSError *error;
    self.objects = [self.context executeFetchRequest:self.request error:&error];
}

-(NSString*)createXAxisString :(NSString*) initialString :(NSNumber*) spacesToAdd {
    //
    NSString *tempString = initialString;
    NSString *spacesString = @" ";
    
    for (int i = 0; i < [spacesToAdd intValue]; i++) {
        tempString = [tempString stringByAppendingString:spacesString];
    }
    return tempString;
}

-(NSString*)findXAxisTitle {
    
    NSArray *xAxisSecArray = @[@"B1: Chest+Tri - Dips",
                               @"B1: Chest+Tri - Abs",
                               @"B1: Back+Bi - Close-Grip Chin-Up",
                               @"B1: Back+Bi - Superman to Airplane",
                               @"B1: Legs - S-L Calf Raise",
                               @"B1: Legs - S Calf Raise",
                               @"B1: Legs - Abs",
                               @"B2: Chest - Russian Twist",
                               @"B2: Back - Plank Row Arm Balance",
                               @"B2: Legs - Abs",
                               @"B2: Shoulders - Plank Crunch",
                               @"T1: Back+Bi - Mountain Climber"];
    
    NSString *tempString = [NSString stringWithFormat:@"%@ - %@", self.appDelegate.graphWorkout, self.appDelegate.graphTitle];
    
    for (int i = 0; i <xAxisSecArray.count; i++) {
        
        if ([tempString isEqualToString:xAxisSecArray[i]]) {
            
            return @"Sec";
        }
    }
    
    return @"Reps";
}

-(NSString*)findYAxisTitle {
    
    NSArray *yAxisRepsArray = @[@"B1: Chest+Tri - Dips",
                                @"B1: Chest+Tri - Abs",
                                @"B1: Back+Bi - Close-Grip Chin-Up",
                                @"B1: Back+Bi - Superman to Airplane",
                                @"B1: Legs - S-L Calf Raise",
                                @"B1: Legs - S Calf Raise",
                                @"B1: Legs - Abs",
                                @"B2: Chest - Superman Airplane",
                                @"B2: Chest - Russian Twist",
                                @"B2: Back - Plank Row Arm Balance",
                                @"B2: Legs - Abs",
                                @"B2: Shoulders - Plank Crunch",
                                @"T1: Back+Bi - Mountain Climber"];
    
    NSString *tempString = [NSString stringWithFormat:@"%@ - %@", self.appDelegate.graphWorkout, self.appDelegate.graphTitle];
    
    for (int i = 0; i < yAxisRepsArray.count; i++) {
        
        if ([tempString isEqualToString:yAxisRepsArray[i]]) {
            
            return @"Reps";
        }
    }
    
    return @"Weight";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
