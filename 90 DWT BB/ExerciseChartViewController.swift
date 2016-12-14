//
//  ExerciseChartViewController.swift
//  90 DWT BB
//
//  Created by Grant, Jared on 7/20/16.
//  Copyright © 2016 Grant, Jared. All rights reserved.
//

import UIKit
import CoreData
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ExerciseChartViewController: UIViewController, SChartDatasource {
    
    @IBOutlet weak var chartView: UIView!
    
    var session = ""
    var workoutRoutine = ""
    var selectedWorkout = ""
    var exerciseName = ""
    var graphDataPoints = [String?]()
    var workoutIndex = 0
    
    //var chart = ShinobiChart(frame: CGRectZero)
    
    var workoutObjects = [Workout]()
    
    @IBAction func dismissButtonPressed(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // Create the chart
        let chart = ShinobiChart(frame: chartView.bounds.insetBy(dx: 0, dy: 0))
        chart.title = exerciseName
        chart.titleLabel.textColor = UIColor (red: 175/255, green: 89/255, blue: 8/255, alpha: 1)
        chart.titleCentresOn = SChartTitleCentresOn.chart
        
        chart.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        // Add a pair of axes
        let xAxis = SChartCategoryAxis()
        xAxis.title = findXAxisTitle()
        xAxis.style.titleStyle.font = UIFont(name: "HelveticaNeue-Light", size: 17)!
        //xAxis.rangePaddingLow = @(0.05);
        //xAxis.rangePaddingHigh = @(0.3);
        chart.xAxis = xAxis;
        
        let yAxis = SChartNumberAxis()
        yAxis.title = findYAxisTitle()
        yAxis.style.titleStyle.font = UIFont(name: "HelveticaNeue-Light", size: 17)!
        //yAxis.rangePaddingLow = @(1.0);
        //yAxis.rangePaddingHigh = @(1.0);
        chart.yAxis = yAxis;

        // Add chart to the view
        chartView.addSubview(chart)

        // This view controller will provide data to the chart
        chart.datasource = self
        
        // Show the legend on all devices
        chart.legend.isHidden = false
        chart.legend.style.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        chart.legend.placement = .outsidePlotArea
        chart.legend.position = .bottomMiddle
        
        // Enable gestures
        yAxis.enableGesturePanning = true;
        yAxis.enableGestureZooming = true;
        xAxis.enableGesturePanning = true;
        xAxis.enableGestureZooming = true;
        
        // Show the x and y axis gridlines
        xAxis.style.majorGridLineStyle.showMajorGridLines = true;
        yAxis.style.majorGridLineStyle.showMajorGridLines = true;
    }
    
    // MARK:- SChartDatasource Functions
    
    func numberOfSeries(in chart: ShinobiChart) -> Int {
        
        let highestIndexFound = NSInteger(GetHighestDatabaseIndex())
        
        return highestIndexFound;
    }
    
    func sChart(_ chart: ShinobiChart, seriesAt index: Int) -> SChartSeries {
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
        let columnSeries = SChartColumnSeries()
        
        // Enable area fill
        //columnSeries.style.areaColorGradient = [UIColor clearColor];
        
        let tryNumber = NSNumber(value: index + 1 as Int32)
        
        if (ColumnSeriesMatchAtIndex(index)) {
            
            let matches = self.workoutObjects.last! as Workout
            let tempNote = matches.notes
            
            if tempNote == nil {
                
                columnSeries.title = "Try \(tryNumber) - "
            }
            else {
                
                columnSeries.title = "Try \(tryNumber) - \(tempNote!)"
            }
        }
        else {
            
            columnSeries.title = "Try \(tryNumber) - "
        }
        
        return columnSeries;
    }
    
    func sChart(_ chart: ShinobiChart, numberOfDataPointsForSeriesAt seriesIndex: Int) -> Int {
    
        // Get the number of reps labels in the cell that aren't ""
        var counter = 0
        
        for object in graphDataPoints {
            
            if object != "" {
                
                counter += 1
            }
        }
        
        return counter
    }
    
    func sChart(_ chart: ShinobiChart, dataPointAt dataIndex: Int, forSeriesAt seriesIndex: Int) -> SChartData {
    
        let dataPoint = SChartDataPoint()
        
        self.workoutObjects = [Workout]()
        
        matchAtIndex(dataIndex, workoutIndex: seriesIndex)
        
        var tempReps = graphDataPoints[dataIndex]
        
        var tempString1 = ""
        var tempString2 = ""
        
        var duplicate = 0;
        
        for i in 0...dataIndex {
            
            tempString1 = graphDataPoints[i]!
            
            if (tempReps == tempString1) {
                duplicate += 1
                
                if (duplicate > 1) {
                    
                    tempString2 = createXAxisString(tempReps! as NSString, spacesToAdd: duplicate - 1 as NSNumber)
                    
                }else {
                    
                    tempString2 = tempString1;
                }
            }
        }
        
        tempReps = tempString2;
        dataPoint.xValue = tempReps;
        
        if (self.workoutObjects.count == 0) {
            
            // No Matches
            dataPoint.yValue = NSNumber(value: 0.0 as Double)
        }
        else {
            
            // Found a match
            let matches = workoutObjects.last!
            let yValue = Double(matches.weight!)
            dataPoint.yValue = NSNumber(value: yValue! as Double)
        }
        
        return dataPoint
    }
    
    // MARK:- Utility Methods
    
    func GetHighestDatabaseIndex() -> NSInteger {
    
        // Get Data from the database
        let request = NSFetchRequest<NSFetchRequestResult>( entityName: "Workout")
        let sortDate = NSSortDescriptor( key: "index", ascending: true)
        request.sortDescriptors = [sortDate]
        
        let filter = NSPredicate(format: "session == %@ AND routine == %@ AND workout == %@ AND exercise == %@",
                                 session,
                                 workoutRoutine,
                                 selectedWorkout,
                                 exerciseName)
        
        request.predicate = filter
        
        do {
            if let tempWorkoutObjects = try CoreDataHelper.shared().context.fetch(request) as? [Workout] {
                
                self.workoutObjects = tempWorkoutObjects
                //print("workoutObjects.count = \(workoutObjects.count)")
                
                var highestDatabaseIndex = 0
                
                for object in tempWorkoutObjects {
                    
                    let objectIndex = object.index
                    
                    if objectIndex?.intValue > highestDatabaseIndex {
                        
                        highestDatabaseIndex = (objectIndex?.intValue)!
                    }
                }
                
                return highestDatabaseIndex
                
            }
        } catch { print(" ERROR executing a fetch request: \( error)") }
        
        return 0
    }
    
    func ColumnSeriesMatchAtIndex(_ workoutIndex: NSInteger) -> Bool {
    
        let tempWorkoutIndex = NSNumber(value: workoutIndex + 1 as Int)
        
        // Get Data from the database.
        let request = NSFetchRequest<NSFetchRequestResult>( entityName: "Workout")
        let sortRound = NSSortDescriptor( key: "round", ascending: true)
        request.sortDescriptors = [sortRound]
        
        let filter = NSPredicate(format: "session == %@ AND routine == %@ AND workout == %@ AND exercise == %@ AND index == %@",
                                 session,
                                 workoutRoutine,
                                 selectedWorkout,
                                 exerciseName,
                                 tempWorkoutIndex)
        
        request.predicate = filter
        
        do {
            if let tempWorkoutObjects = try CoreDataHelper.shared().context.fetch(request) as? [Workout] {
                
                self.workoutObjects = tempWorkoutObjects
                //print("workoutObjects.count = \(workoutObjects.count)")
                
                if tempWorkoutObjects.count == 0 {
                    
                    return false
                }
                else {
                    
                    return true
                }
            }
        } catch { print(" ERROR executing a fetch request: \( error)") }
        
        return false
    }
    
    func matchAtIndex(_ round: NSInteger, workoutIndex: NSInteger) {
    
        var roundConverted = NSNumber(value: round as Int)
        
        let tempWorkoutIndex = NSNumber(value: workoutIndex + 1 as Int)
        
        // @"B2: Chest - Russian Twist" is the only one that starts out in the second index of an array.
        let tempString = "\(selectedWorkout) - \(exerciseName)"
        
        if tempString == "B2: Chest - Russian Twist" {
            
            roundConverted = NSNumber(value: round + 1 as Int)
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>( entityName: "Workout")
        let sortDate = NSSortDescriptor( key: "date", ascending: true)
        request.sortDescriptors = [sortDate]
        
        let filter = NSPredicate(format: "session == %@ AND routine == %@ AND workout == %@ AND exercise == %@ AND index == %@ AND round == %@",
                                 session,
                                 workoutRoutine,
                                 selectedWorkout,
                                 exerciseName,
                                 tempWorkoutIndex,
                                 roundConverted)
        
        request.predicate = filter

        do {
            if let tempWorkoutObjects = try CoreDataHelper.shared().context.fetch(request) as? [Workout] {
                
                //print("workoutObjects.count = \(workoutObjects.count)")
                self.workoutObjects = tempWorkoutObjects
            }
        } catch { print(" ERROR executing a fetch request: \( error)") }
    }
    
    func createXAxisString(_ initialString: NSString, spacesToAdd: NSNumber) -> String {
    
        var tempString = initialString
        let spacesString = " "
        
        for _ in 0..<spacesToAdd.intValue {
            
            tempString = tempString.appending(spacesString) as NSString
        }
        
        return tempString as String
    }
    
    func findXAxisTitle() -> String {
        
        let xAxisSecArray = ["B1: Chest+Tri - Dips",
                             "B1: Chest+Tri - Abs",
                             "B1: Back+Bi - Close-Grip Chin-Up",
                             "B1: Back+Bi - Superman to Airplane",
                             "B1: Legs - S-L Calf Raise",
                             "B1: Legs - S Calf Raise",
                             "B1: Legs - Abs",
                             "B2: Chest - Russian Twist",
                             "B2: Back - Plank Row Arm Balance",
                             "B2: Legs - Abs",
                             "B2: Shoulders - Plank Crunch",
                             "T1: Back+Bi - Mountain Climber"]
        
        let tempString = "\(selectedWorkout) - \(exerciseName)"
        
        for i in 0..<xAxisSecArray.count {
            
            if tempString == xAxisSecArray[i] {
                
                return "Sec"
            }
        }
        
        return "Reps"
    }
    
    func findYAxisTitle() -> String {
        
        let yAxisRepsArray = ["B1: Chest+Tri - Dips",
                              "B1: Chest+Tri - Abs",
                              "B1: Back+Bi - Close-Grip Chin-Up",
                              "B1: Back+Bi - Superman to Airplane",
                              "B1: Legs - S-L Calf Raise",
                              "B1: Legs - S Calf Raise",
                              "B1: Legs - Abs",
                              "B2: Chest - Superman Airplane",
                              "B2: Chest - Russian Twist",
                              "B2: Back - Plank Row Arm Balance",
                              "B2: Legs - Abs",
                              "B2: Shoulders - Plank Crunch",
                              "T1: Back+Bi - Mountain Climber"]
        
        let tempString = "\(selectedWorkout) - \(exerciseName)"
        
        for i in 0..<yAxisRepsArray.count {
            
            if tempString == yAxisRepsArray[i] {
                
                return "Reps"
            }
        }
        
        return "Weight"
    }
}
