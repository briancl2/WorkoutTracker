//
//  Exercise.swift
//  Workout Tracker
//
//  Created by briancl on 4/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift

class Exercise: Object {
    
    // MARK: Public Properties
    
    dynamic var name = ""
    dynamic var notes: String?
    var workoutDiary = List<Workout>()
    dynamic var goal = 0
    var currentWeights: ExerciseWeights {
        if let lastWorkout = workoutDiary.last {
            
            return ExerciseWeights(weight: lastWorkout.weight)
        }
        
        return ExerciseWeights(weight: 0)
    }
    
    var calculated1RM: Int {
        if let lastWorkout = workoutDiary.last {
            let set = lastWorkout.sets.first!
            let weight = Double(set.weight)
            let repCount = set.repCount
            let coefficient = [1.0,1.0,0.943,0.906,0.881,0.856,0.831,0.807,0.786,0.765,0.744,0.723,0.703,0.688,0.675,0.662,0.650,0.638,0.627,0.616,0.606] // first element is set to 1.0 to prevent divide by zero condition, which should never happen anyway
            
            return Int(weight / coefficient[repCount])
        }
        
        return 0
    }
    
    var goalAttainment: Int {
        return Int(100 * (Double(calculated1RM) / Double(goal)))
    }
    
    var lastCycleDate: (NSDate, Int)? {
        // if diary is empty, return nil
        if workoutDiary.count == 0 {
            return nil
        }
        
        for workout in workoutDiary.reverse() {
            if workout.sets.reduce(0, combine: { $0 + $1.repCount }) >= 24 {
                return (workout.date, workoutDiary.count - workoutDiary.indexOf(workout)!)
            }
        }

        return nil
    }
        
    struct ExerciseWeights {
        let heavy: Weight
        var warmup25: Weight {
            return Weight(actual: Int(Double(heavy.actual) * 0.25))
        }
        var warmup50: Weight {
            return Weight(actual: Int(Double(heavy.actual) * 0.50))
        }
        
        init(weight: Int) {
            self.heavy = Weight(actual: weight)
        }
    }
    
    // MARK: Initializers

    convenience init(name: String, notes: String?, workoutDiary: List<Workout>, goal: Int) {
        self.init()
        self.name = name
        self.notes = notes
        self.workoutDiary = workoutDiary
        self.goal = goal
    }
    
    // MARK: Public Methods
    
    func recordWorkout(date: String, weight: Int, repsFirstSet: Int, repsSecondSet: Int) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        
        let newSets = List<WorkSet>()
        newSets.append(WorkSet(weight: weight, repCount: repsFirstSet))
        newSets.append(WorkSet(weight: weight, repCount: repsSecondSet))
        let newWorkoutLogEntry = Workout(date: dateFormatter.dateFromString(date)!, sets: newSets)
        workoutDiary.append(newWorkoutLogEntry)
    }
    
    func recordWorkout(newWorkout: Workout) {
        workoutDiary.append(newWorkout)
    }
    
    func replaceWorkout(originalWorkout: Workout, newWorkout: Workout) {
        workoutDiary[workoutDiary.indexOf(originalWorkout)!] = newWorkout
    }
    
    func getLastWorkout() -> Workout? {
        return workoutDiary.last
    }
    
    func getLastWorkouts(number: Int) -> [Workout]? {
        return Array(workoutDiary.suffix(number))
    }
    
    func getTotalVolumeIncrease(dateRange: Int) -> Int? {
        if let oldWorkout = getOldestWorkoutFromRange(dateRange) {
            let oldVolume = oldWorkout.totalVolume
            let newVolume = workoutDiary.last!.totalVolume
            return Int(100 * (newVolume - oldVolume) / oldVolume)
        }
        return nil
    }
    
    func getWeightIncrease(dateRange: Int) -> Int? {
        if let oldWorkout = getOldestWorkoutFromRange(dateRange) {
            let oldWeight = oldWorkout.weight
            let newWeight = workoutDiary.last!.weight
            return Int(100 * (newWeight - oldWeight) / oldWeight)
        }
        return nil
    }
    
    func getHistory() -> [Workout] {
        return Array(workoutDiary)
    }
    
    func getOldestWorkoutFromRange(dateRange: Int? = nil) -> Workout? {
        // if diary is empty, return nil
        if workoutDiary.count == 0 {
            return nil
        }
        
        // if an argument was passed
        if let dateRange = dateRange {
            let daysAgo = NSDate().daysAgo(dateRange)
            let workoutsInRange = workoutDiary.filter({$0.date > daysAgo})
            
            // if there are workouts in the dateRange, return the first one (oldest)
            if workoutsInRange != [] {
                return workoutsInRange.first
            } else {
                return nil // otherwise no workouts were found in range, so return nil
            }
        } else {
            return workoutDiary.first // if no argument, just return the first element
        }
    }
    
}
