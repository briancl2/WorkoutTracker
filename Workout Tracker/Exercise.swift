//
//  Exercise.swift
//  Workout Tracker
//
//  Created by briancl on 4/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper


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

final class Exercise: Object, Mappable {
    
    // MARK: Public Properties
    
    dynamic var id: String = NSUUID().UUIDString
    dynamic var name = ""
    dynamic var notes: String?
    var workoutDiary = List<Workout>()
    dynamic var goal = 0
    dynamic var sortOrder = 0
    
    // primaryKey for uniqueness in Realm
    override class func primaryKey() -> String? {
        return "id"
    }
    
    //dynamic var program: ExerciseProgram?
    var currentWeights: ExerciseWeights {
        if let lastWorkout = workoutDiary.last {
            return ExerciseWeights(weight: lastWorkout.weight)
        }
        return ExerciseWeights(weight: 0)
    }
    
    var calculated1RM: Int {
        if let lastWorkout = workoutDiary.last {
            return lastWorkout.oneRepMax
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
    
    var averageCycleLength: Int? {
        if let lastWorkout = workoutDiary.last {
            let numberOfDays = lastWorkout.date.daysFrom(workoutDiary.first!.date)
            let completedCycles = numberOfCompletedCycles
            if completedCycles > 0 {
                return numberOfDays / completedCycles
            }
        }
        return nil
    }
    
    var numberOfCompletedCycles: Int {       
        if workoutDiary.count <= 1 {
            return 0
        }
        
        var counter = 0
        
        for workout in workoutDiary {
            if workout.totalReps >= 24 {
                if workout != workoutDiary.last { // count up all the previous cycles by watching for weight increases
                    if workout.weight < workoutDiary[workoutDiary.indexOf(workout)! + 1].weight {
                        counter += 1
                    }
                } else { // if last workout, we just cycled so increment (can only happen once because only one last)
                    counter += 1
                }
            }
        }
        
        return counter
    }
    
    // MARK: Initializers

    convenience init(name: String, notes: String?, goal: Int) {
        self.init()
        self.name = name
        self.notes = notes
        //self.workoutDiary = workoutDiary
        self.goal = goal
    }
    
    // required for ObjectMapper
    required convenience init?(_ map: Map) {
        self.init()
    }
    
}

// Support for ObjectMapper
extension Exercise {
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        notes <- map["notes"]
        workoutDiary <- (map["workoutDiary"], ListTransform<Workout>())
        goal <- map["goal"]
        sortOrder <- map["sortOrder"]
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
    
    func getLastWorkouts(number: Int) -> [Workout]? {
        return Array(workoutDiary.suffix(number))
    }
    
    func getTotalVolumeIncrease(dateRange: Int) -> Int? {
        if let oldWorkout = getOldestWorkoutFromRange(dateRange) {
            let oldVolume = oldWorkout.totalVolume
            let newVolume = workoutDiary.last!.totalVolume
            if oldVolume == 0 {
                return nil
            }
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
    
    private func getOldestWorkoutFromRange(dateRange: Int) -> Workout? {
        let daysAgo = NSDate().daysAgo(dateRange)
        
        // if there are workouts in the dateRange, return the first one (oldest)
        if let oldestWorkoutInRange = workoutDiary.filter({$0.date > daysAgo}).first {
            return oldestWorkoutInRange
        }
        return nil // otherwise no workouts were found in range, so return nil
    }
    
}

