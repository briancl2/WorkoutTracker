//
//  Workout_TrackerTests.swift
//  Workout TrackerTests
//
//  Created by briancl on 4/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import XCTest
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

    
    func testAddNewExerciseProgram() {
        let exercises = ExerciseProgram(name: "Allpro Auto-regulated", startDate: NSDate(), program: [], userProfile: User(bodyWeight: 160, name: "Brian"))
        XCTAssertEqual(exercises.userProfile.name, "Brian")
    }
    
    func testAddNewExercise() {
        let exercises = ExerciseProgram(name: "Allpro Auto-regulated", startDate: NSDate(), program: [], userProfile: User(bodyWeight: 160, name: "Brian"))
        let squat = Exercise(name: "Squat", notes: "Squat notes", workoutDiary: WorkoutDiary(diary: []), weight: 0, goal: 320)
        squat.recordWorkout("16-04-17", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
        exercises.addExercise(squat)
        let name = "test"
        let notes: String? = nil
        let weight = 0
        let goal = 200
        
        exercises.addExercise(Exercise(name: name, notes: notes, workoutDiary: WorkoutDiary(diary: []), weight: weight, goal: goal))
        XCTAssertEqual(exercises.program[0].currentWeights.warmup50.barText, "Bar + 2x10 + 2x2.5")
        
    }
}

class ExampleTests: XCTestCase {
    
    //declaring the ViewController under test as an implicitly unwrapped optional
    var systemUnderTest: UITableViewController!
    
    override func setUp() {
        
        super.setUp()
        
        //get the storyboard the ViewController under test is inside
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        //get the ViewController we want to test from the storyboard (note the identifier is the id explicitly set in the identity inspector)
        systemUnderTest = storyboard.instantiateViewControllerWithIdentifier("MasterTableViewController") as! UITableViewController
        
        //load view hierarchy
        _ = systemUnderTest.view
        
        let exercises = ExerciseProgram(name: "Allpro Auto-regulated", startDate: NSDate(), program: [], userProfile: User(bodyWeight: 160, name: "Brian"))
        let squat = Exercise(name: "Squat", notes: "Squat notes", workoutDiary: WorkoutDiary(diary: []), weight: 0, goal: 320)
        squat.recordWorkout("16-04-17", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
        exercises.addExercise(squat)
        let name = "test"
        let notes: String? = nil
        let weight = 0
        let goal = 200
        
        exercises.addExercise(Exercise(name: name, notes: notes, workoutDiary: WorkoutDiary(diary: []), weight: weight, goal: goal))
        XCTAssertEqual(exercises.program[0].currentWeights.warmup50.barText, "Bar + 2x10 + 2x2.5")
        
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