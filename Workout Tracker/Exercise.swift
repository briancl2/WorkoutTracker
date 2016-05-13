//
//  Exercise.swift
//  Workout Tracker
//
//  Created by briancl on 4/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

class Exercise: NSObject, NSCoding {
    var name: String
    var notes: String?
    private var workoutDiary = WorkoutDiary(diary: [])
    var currentWeights = Weights(heavy: 0)
    var goal = 0

    init(name: String, notes: String?, workoutDiary: WorkoutDiary, weight: Int, goal: Int) {
        self.name = name
        self.notes = notes
        self.workoutDiary = workoutDiary
        self.currentWeights.heavy = weight
        self.goal = goal

    }
    
    // MARK: Types
    
    // weights of the exercise
    struct Weights {
        var heavy = 0
        var warmup25: Int {
            return Int(Double(heavy) * 0.25).roundedToFive
        }
        var warmup50: Int {
            return Int(Double(heavy) * 0.50).roundedToFive
        }
    }
    
    struct PropertyKey {
        static let nameKey = "Exercise_name"
        static let notesKey = "Exercise_notes"
        static let workoutDiaryKey = "Exercise_workoutDiary"
        static let currentWeightsHeavyKey = "Exercise_currentWeightsHeavy"
        static let goal = "Exercise_goal"
    }
    
    func recordWorkout(date: String, weight: Int, repsFirstSet: Int, repsSecondSet: Int) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        
        let newSets = [Sets(weight: weight, repCount: repsFirstSet),Sets(weight: weight, repCount: repsSecondSet)]
        let newWorkoutLogEntry = Workout(date: dateFormatter.dateFromString(date)!, sets: newSets)
        workoutDiary.addWorkout(newWorkoutLogEntry)
        
        //update weights
        self.currentWeights.heavy = weight
    }
    
    func recordWorkout(newWorkout: Workout) {
        workoutDiary.addWorkout(newWorkout)
        //update weights
        self.currentWeights.heavy = newWorkout.sets[0].weight
    }
    
    func getLastWorkout() -> Workout? {
        if let workout = workoutDiary.getLastWorkout() {
            return workout
        } else {
            return nil
        }
    }
    
    func getLastWorkouts(number: Int) -> [Workout]? {
        if let workouts = workoutDiary.getLastWorkouts(number) {
            return workouts
        } else {
            return nil
        }
    }
    
    func getOldestWorkoutFromRange(dateRange: Int? = nil) -> Workout? {
        return workoutDiary.getOldestWorkoutFromRange(15)
    }
    
    func getBarWeightsString(targetWeight: Int) -> String {
        if targetWeight == 0 {
            return ""
        }
        
        if targetWeight < 54 {
            return "Bar"
        } else {
            return Bar(weight: targetWeight.roundedToFive).barText
        }
    }

    func getTotalVolumeIncrease(dateRange: Int) -> Int? {
        return TotalVolumeIncrease(diary: workoutDiary, dateRange: dateRange).percentage
    }
    
    func getCalculated1RM() -> Int {
        return Int(OneRepMax(set: getLastWorkout()!.sets[0]).value)
    }
    
    func getGoalAttainment() -> Int {
        return GoalAttainment(set: (getLastWorkout()?.sets[0])!, goal: goal).percentage
    }
    
    
    func saveExercise() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(self), forKey: "ExerciseProgram")
        defaults.synchronize()
    }
    
    // MARK: NSCoder
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(notes, forKey: PropertyKey.notesKey)
        aCoder.encodeObject(workoutDiary, forKey: PropertyKey.workoutDiaryKey)
        aCoder.encodeInteger(currentWeights.heavy, forKey: PropertyKey.currentWeightsHeavyKey)
        aCoder.encodeInteger(goal, forKey: PropertyKey.goal)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let notes = aDecoder.decodeObjectForKey(PropertyKey.notesKey) as! String?
        let workoutDiary = aDecoder.decodeObjectForKey(PropertyKey.workoutDiaryKey) as! WorkoutDiary
        let currentWeights = aDecoder.decodeIntegerForKey(PropertyKey.currentWeightsHeavyKey)
        let goal = aDecoder.decodeIntegerForKey(PropertyKey.goal)

        // Must call designated initializer.
        self.init(name: name, notes: notes, workoutDiary: workoutDiary, weight: currentWeights, goal: goal)
    }
}
