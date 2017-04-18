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

final class Exercise: Object, Mappable {
    
    // MARK: Public Properties
    
    fileprivate(set) dynamic var id: String = UUID().uuidString
    fileprivate(set) dynamic var name = ""
    fileprivate(set) dynamic var notes: String?
    fileprivate(set) var workoutDiary = List<Workout>()
    fileprivate(set) dynamic var bodyWeightMultiplier = 0.0
    dynamic var sortOrder = 0
    fileprivate(set) dynamic var username = "Brian"
    
    // primaryKey for uniqueness in Realmk
    override class func primaryKey() -> String? {
        return "id"
    }
    
    var goal: Int {
        let realm = try! Realm()
        if let user = realm.objects(User.self).first {
            return Int(Double(user.bodyWeight) * bodyWeightMultiplier)
        }
        return 1
    }
    
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
    
    var lastCycleDate: (Date, Int)? {
        // return the most recent workout of all cycled workouts found
        if let lastCycledWorkout = workoutDiary.filter({$0.totalReps >= 24}).last {
            return (lastCycledWorkout.date, workoutDiary.count - workoutDiary.index(of: lastCycledWorkout)!)
        }
        return nil
    }
    
    var averageCycleLength: Int? {
        guard let lastWorkout = workoutDiary.last, let firstWorkout = workoutDiary.first, numberOfCompletedCycles > 0
            else {
                return nil
        }
        
        let numberOfDays = lastWorkout.date.daysFrom(firstWorkout.date)
        return numberOfDays / numberOfCompletedCycles
    }
    
    var numberOfCompletedCycles: Int {       
        if workoutDiary.count <= 1 {
            return 0
        }
        
        var counter = 0
        
        for workout in workoutDiary {
            if workout.totalReps >= 24 {
                if workout != workoutDiary.last { // count up all the previous cycles by watching for weight increases
                    if workout.weight < workoutDiary[workoutDiary.index(of: workout)! + 1].weight {
                        counter += 1
                    }
                } else { // if last workout, we just cycled so increment (can only happen once because only one last)
                    counter += 1
                }
            }
        }
        
        return counter
    }
    
    var workoutsPerCycle: Int? {
        if numberOfCompletedCycles > 0 {
            let numberOfWorkouts = workoutDiary.count
            return numberOfWorkouts / numberOfCompletedCycles
        }
        return nil
    }
    
    var pctWeightIncreasePerMonth: Int? {
        if let firstWorkout = workoutDiary.first {
            let today = Date()
            let totalDays = -(firstWorkout.date.daysFrom(today) - 1)
            if totalDays > 30 {
                let totalMonths = Double(totalDays) / 30.0
                if let totalWeightIncrease = getPctWeightIncrease(totalDays) {
                    return Int(Double(totalWeightIncrease) / totalMonths)
                }
            }
        }
        return nil
    }
    
    var lbsWeightIncreasePerMonth: Int? {
        if let firstWorkout = workoutDiary.first {
            let today = Date()
            let totalDays = -(firstWorkout.date.daysFrom(today) - 1)
            if totalDays > 30 {
                let totalMonths = Double(totalDays) / 30.0
                if let totalWeightIncrease = getLbsWeightIncrease(totalDays) {
                    return Int(Double(totalWeightIncrease) / totalMonths)
                }
            }
        }
        return nil
    }
    
    // MARK: Initializers

    convenience init(exerciseType: ExerciseType, notes: String?) {
        self.init()
        self.name = exerciseType.name
        self.notes = notes
        self.bodyWeightMultiplier = exerciseType.bodyWeightMultiplier
    }
    
    convenience init(name: String, notes: String?, bodyWeightMultiplier: Double, workoutDiary: List<Workout>, username: String, sortOrder: Int) {
        self.init()
        self.name = name
        self.notes = notes
        self.bodyWeightMultiplier = bodyWeightMultiplier
        self.workoutDiary = workoutDiary
        self.username = username
        self.sortOrder = sortOrder
    }
    
    // required for ObjectMapper
    required convenience init?(map: Map) {
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
        bodyWeightMultiplier <- map["bodyWeightMultiplier"]
        sortOrder <- map["sortOrder"]
        username <- map["username"]
    }
    
}

extension Exercise {

    // MARK: Public Methods
    
    func recordWorkout(_ date: String, weight: Int, repsFirstSet: Int, repsSecondSet: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        
        let newSets = List<WorkSet>()
        newSets.append(WorkSet(weight: weight, repCount: repsFirstSet))
        newSets.append(WorkSet(weight: weight, repCount: repsSecondSet))
        let newWorkoutLogEntry = Workout(date: dateFormatter.date(from: date)!, sets: newSets)
        workoutDiary.append(newWorkoutLogEntry)
    }
    
    func getLastWorkouts(_ number: Int) -> [Workout]? {
        return Array(workoutDiary.suffix(number))
    }
    
    func getPctTotalVolumeIncrease(_ dateRange: Int) -> Int? {
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
    
    func getPctWeightIncrease(_ dateRange: Int) -> Int? {
        if let oldWorkout = getOldestWorkoutFromRange(dateRange) {
            let oldWeight = oldWorkout.weight
            let newWeight = workoutDiary.last!.weight
            return Int(100 * (newWeight - oldWeight) / oldWeight)
        }
        return nil
    }
    
}

private extension Exercise {
    
    func getLbsWeightIncrease(_ dateRange: Int) -> Int? {
        if let oldWorkout = getOldestWorkoutFromRange(dateRange) {
            let oldWeight = oldWorkout.weight
            let newWeight = workoutDiary.last!.weight
            return newWeight - oldWeight
        }
        return nil
    }

    func getOldestWorkoutFromRange(_ dateRange: Int) -> Workout? {
        let daysAgo = Date().daysAgo(dateRange)
        
        // if there are workouts in the dateRange, return the first one (oldest)
        if let oldestWorkoutInRange = workoutDiary.filter({$0.date > daysAgo}).first {
            return oldestWorkoutInRange
        }
        return nil // otherwise no workouts were found in range, so return nil
    }
    
}

