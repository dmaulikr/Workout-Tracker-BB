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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.counter = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.counter = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    //CGFloat margin = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 10.0 : 50.0;
    chart = [[ShinobiChart alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 0)];
    
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    chart.title = mainAppDelegate.graphTitle;
    chart.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    chart.titleCentresOn = SChartTitleCentresOnChart;
    
    chart.autoresizingMask = ~UIViewAutoresizingNone;

    // Add a pair of axes
    
    SChartCategoryAxis *xAxis = [[SChartCategoryAxis alloc] init];
    xAxis.title = @"Reps";
    xAxis.rangePaddingLow = @(0.05);
    xAxis.rangePaddingHigh = @(0.3);
    chart.xAxis = xAxis;

    SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] init];
    yAxis.title = @"Weight";
    yAxis.rangePaddingLow = @(1.0);
    yAxis.rangePaddingHigh = @(1.0);
    chart.yAxis = yAxis;
    
    // Add the chart to the view controller
    [self.view addSubview:chart];
    
    chart.datasource = self;
    
    // Show legend only on iPad
    //chart.legend.hidden = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
    chart.legend.hidden = NO;
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
    
    return [self GetNumberOfMatchesInCoreData];
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
    
    SChartLineSeries *lineSeries = [[SChartLineSeries alloc] init];
    
    // Enable area fill
    //lineSeries.style.showFill = YES;
    
    lineSeries.style.pointStyle.showPoints = YES;
    NSNumber *tryNumber = [NSNumber numberWithInteger:index + 1];
    
    self.matches = [self.objects objectAtIndex:index * 6];
    lineSeries.title = [NSString stringWithFormat:@"Try %@ - %@", tryNumber, self.matches.notes];
    
    //lineSeries.style.dataPointLabelStyle.showLabels = YES;
    
    return lineSeries;
}

-(NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
    
    NSNumber *tempNumber = [NSNumber numberWithInteger:self.appDelegate.graphDataPoints.count];
    return [tempNumber integerValue];
}

-(id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
    
    SChartDataPoint *dataPoint = [[SChartDataPoint alloc] init];
    
    self.matches = [self.objects objectAtIndex:dataIndex + (seriesIndex * 6)];
    
    
    NSString *tempReps = [NSString stringWithFormat:@"%ld", (long)[self.matches.reps integerValue]];
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
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
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

-(NSString*)createXAxisString :(NSString*) initialString :(NSNumber*) spacesToAdd {
    //
    NSString *tempString = initialString;
    NSString *spacesString = @" ";
    
    for (int i = 0; i < [spacesToAdd intValue]; i++) {
        tempString = [tempString stringByAppendingString:spacesString];
    }
    return tempString;
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
