//
//  Exercise.swift
//  Workout Tracker
//
//  Created by briancl on 4/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift

struct ExerciseWeights {
    
    // MARK: Public Properties
    
    let heavy: Weight
    var warmup25: Weight {
        return Weight(weight: Int(Double(heavy.weight) * 0.25))
    }
    var warmup50: Weight {
        return Weight(weight: Int(Double(heavy.weight) * 0.50))
    }
    
    // MARK: Initializers
    
    init(weight: Int) {
        self.heavy = Weight(weight: weight)
    }
}

final class Exercise: Object {
    
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
            let coefficient = [1.0,0.943,0.906,0.881,0.856,0.831,0.807,0.786,0.765,0.744,0.723,0.703,0.688,0.675,0.662,0.650,0.638,0.627,0.616,0.606]
            return Int(weight / coefficient[repCount - 1]) // subtract one to convert repCount into 0...n index range
        }
        return 0
    }
    
    var goalAttainment: Int {
        return Int(100 * (Double(calculated1RM) / Double(goal)))
    }
    
    var lastCycleDate: (NSDate, Int)? {
        // return the most recent workout of all cycled workouts found
        if let lastCycledWorkout = workoutDiary.filter({$0.totalReps >= 24}).last {
            return (lastCycledWorkout.date, workoutDiary.count - workoutDiary.indexOf(lastCycledWorkout)!)
        }
        return nil
    }
        

    
    // MARK: Initializers

    convenience init(name: String, notes: String?, workoutDiary: List<Workout>, goal: Int) {
        self.init()
        self.name = name
        self.notes = notes
        self.workoutDiary = workoutDiary
        self.goal = goal
    }
}

extension Exercise {

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
    

    
    func replaceWorkout(originalWorkout: Workout, newWorkout: Workout) {
        workoutDiary[workoutDiary.indexOf(originalWorkout)!] = newWorkout
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
    
    func getOldestWorkoutFromRange(dateRange: Int) -> Workout? {
        let daysAgo = NSDate().daysAgo(dateRange)
        
        // if there are workouts in the dateRange, return the first one (oldest)
        if let oldestWorkoutInRange = workoutDiary.filter({$0.date > daysAgo}).first {
            return oldestWorkoutInRange
        }
        return nil // otherwise no workouts were found in range, so return nil
    }
}

