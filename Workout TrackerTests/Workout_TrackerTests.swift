//
//  Workout_TrackerTests.swift
//  Workout TrackerTests
//
//  Created by briancl on 4/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import XCTest
import RealmSwift
@testable import Workout_Tracker

class Workout_TrackerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testExerciseProgramViewModel() {
        let exercisesViewModel = ExerciseProgramViewModel()
        XCTAssertEqual(exercisesViewModel.getExercise(0).name,"Squat")
        XCTAssertEqual(exercisesViewModel.getExercise(0).workoutDiary.first!.date.myPrettyString,"Apr 20")
        XCTAssertEqual(exercisesViewModel.getExercise(0).workoutDiary.first!.totalVolume,2755)
        XCTAssertEqual(exercisesViewModel.getExercise(8).name,"Curl")
        XCTAssertEqual(exercisesViewModel.getExercise(8).workoutDiary.first!.date.myPrettyString,"Apr 20")
        XCTAssertEqual(exercisesViewModel.getExercise(8).workoutDiary.first!.totalVolume,950)
    }
    
    func testAddNewExercise() {
        let exercisesViewModel = ExerciseProgramViewModel()
        
        let name = "test"
        let notes: String? = nil
        let goal = 200
        
        exercisesViewModel.addExercise(Exercise(name: name, notes: notes, workoutDiary: List<Workout>(), goal: goal))
        XCTAssertEqual(exercisesViewModel.getExercise(exercisesViewModel.count - 1).currentWeights.warmup50.barText, "Bar + 2x10 + 2x5")
        
    }
}
//    func testLoopPerformance() {
//        let exercises = ExerciseProgram(name: "Allpro Auto-regulated", startDate: NSDate(), program: List<Exercise>(), userProfile: User(bodyWeight: 160, name: "Brian"))
//        let squat = Exercise(name: "Squat", notes: "Squat notes", workoutDiary: List<Workout>(), goal: 320)
//        squat.recordWorkout("11-04-20", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
//        squat.recordWorkout("11-04-22", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
//        squat.recordWorkout("11-04-25", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
//        squat.recordWorkout("11-04-27", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
//        squat.recordWorkout("11-04-29", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
//        squat.recordWorkout("11-05-02", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
//        squat.recordWorkout("11-05-05", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
//        squat.recordWorkout("11-05-07", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
//        squat.recordWorkout("11-05-09", weight: 145, repsFirstSet: 12, repsSecondSet: 11)
//        squat.recordWorkout("11-05-12", weight: 145, repsFirstSet: 13, repsSecondSet: 11)
//        squat.recordWorkout("11-05-14", weight: 155, repsFirstSet: 9, repsSecondSet: 7)
//        squat.recordWorkout("11-05-16", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
//        squat.recordWorkout("11-05-18", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
//        squat.recordWorkout("11-05-20", weight: 155, repsFirstSet: 10, repsSecondSet: 9)
//        squat.recordWorkout("12-04-20", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
//        squat.recordWorkout("12-04-22", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
//        squat.recordWorkout("12-04-25", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
//        squat.recordWorkout("12-04-27", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
//        squat.recordWorkout("12-04-29", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
//        squat.recordWorkout("12-05-02", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
//        squat.recordWorkout("12-05-05", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
//        squat.recordWorkout("12-05-07", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
//        squat.recordWorkout("12-05-09", weight: 145, repsFirstSet: 12, repsSecondSet: 11)
//        squat.recordWorkout("12-05-12", weight: 145, repsFirstSet: 13, repsSecondSet: 11)
//        squat.recordWorkout("12-05-14", weight: 155, repsFirstSet: 9, repsSecondSet: 7)
//        squat.recordWorkout("12-05-16", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
//        squat.recordWorkout("12-05-18", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
//        squat.recordWorkout("12-05-20", weight: 155, repsFirstSet: 10, repsSecondSet: 9)
//        squat.recordWorkout("13-04-20", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
//        squat.recordWorkout("13-04-22", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
//        squat.recordWorkout("13-04-25", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
//        squat.recordWorkout("13-04-27", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
//        squat.recordWorkout("13-04-29", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
//        squat.recordWorkout("13-05-02", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
//        squat.recordWorkout("13-05-05", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
//        squat.recordWorkout("13-05-07", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
//        squat.recordWorkout("13-05-09", weight: 145, repsFirstSet: 12, repsSecondSet: 11)
//        squat.recordWorkout("13-05-12", weight: 145, repsFirstSet: 13, repsSecondSet: 11)
//        squat.recordWorkout("13-05-14", weight: 155, repsFirstSet: 9, repsSecondSet: 7)
//        squat.recordWorkout("13-05-16", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
//        squat.recordWorkout("13-05-18", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
//        squat.recordWorkout("13-05-20", weight: 155, repsFirstSet: 10, repsSecondSet: 9)
//        squat.recordWorkout("16-04-20", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
//        squat.recordWorkout("16-04-22", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
//        squat.recordWorkout("16-04-25", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
//        squat.recordWorkout("16-04-27", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
//        squat.recordWorkout("16-04-29", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
//        squat.recordWorkout("16-05-02", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
//        squat.recordWorkout("16-05-05", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
//        squat.recordWorkout("16-05-07", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
//        squat.recordWorkout("16-05-09", weight: 145, repsFirstSet: 12, repsSecondSet: 11)
//        squat.recordWorkout("16-05-12", weight: 145, repsFirstSet: 13, repsSecondSet: 11)
//        squat.recordWorkout("16-05-14", weight: 155, repsFirstSet: 9, repsSecondSet: 7)
//        squat.recordWorkout("16-05-16", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
//        squat.recordWorkout("16-05-18", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
//        squat.recordWorkout("16-05-20", weight: 155, repsFirstSet: 10, repsSecondSet: 9)
//        exercises.addExercise(squat)
//
//        measureBlock() {
//            let (_, _) = exercises.program[0].lastCycleDate!
//        }
//        
//    }
//}
//


class ExampleTests: XCTestCase {
    
    //declaring the ViewController under test as an implicitly unwrapped optional
    var systemUnderTest: UITableViewController!
    
    override func setUp() {
        
        super.setUp()
        
        //get the storyboard the ViewController under test is inside
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        //get the ViewController we want to test from the storyboard (note the identifier is the id explicitly set in the identity inspector)
        systemUnderTest = storyboard.instantiateViewControllerWithIdentifier("ExerciseProgramTableViewController") as! UITableViewController
        
        //load view hierarchy
        _ = systemUnderTest.view

        
    }
    
    func testSUT_TableViewIsNotNilAfterViewDidLoad() {
        
        XCTAssertNotNil(systemUnderTest.tableView)
    }
    
    func testSUT_ShouldSetTableViewDataSource() {
        
        XCTAssertNotNil(systemUnderTest.tableView.dataSource)
    }
    
    func testSUT_ShouldSetTableViewDelegate() {
        
        XCTAssertNotNil(systemUnderTest.tableView.dataSource)
    }
    
    func testSUT_ConformsToTableViewDataSourceProtocol() {
        
        XCTAssert(systemUnderTest.conformsToProtocol(UITableViewDataSource))
        
        XCTAssert(systemUnderTest.respondsToSelector(#selector(systemUnderTest.numberOfSectionsInTableView(_:))))
        
        XCTAssert(systemUnderTest.respondsToSelector(#selector(systemUnderTest.tableView(_:numberOfRowsInSection:))))
        
        XCTAssert(systemUnderTest.respondsToSelector(#selector(systemUnderTest.tableView(_:cellForRowAtIndexPath:))))
    }

    
}