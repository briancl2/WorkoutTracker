//
//  Exercise.swift
//  Workout Tracker
//
//  Created by briancl on 4/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

func calculatePlates(targetWeight: Int) -> String {
    let barWeight = 45
    var plates = [(45, 0), (35, 0), (25, 0), (10, 0), (5,0), (2.5, 0)]
    var tmp = Double(targetWeight - barWeight)
    var bar = "Bar"
    
    for i in 0...plates.count-1 {
        while (tmp / plates[i].0 >= 2) {
            tmp -= (plates[i].0 * 2)
            plates[i].1 += 2
        }
    }
    
    for i in 0...plates.count-1 {
        if plates[i].1 > 0 {
            bar += " + \(plates[i].1)x\(dropTrailingZero(plates[i].0))"
        }
    }
    
    return bar
}

func dropTrailingZero(number: Double) -> String {
    return String(format: "%g", number)
}

func roundToFives(x : Double) -> Int {
    return 5 * Int(round(x / 5.0))
}

class Exercise: NSObject, NSCoding {
    var name: String
    var notes: String?
    private var workoutDiary = WorkoutDiary(diary: nil)
    var currentWeights = Weights(heavy: 0)
    
    init(name: String, notes: String?, workoutDiary: WorkoutDiary, weight: Int) {
        self.name = name
        self.notes = notes
        self.workoutDiary = workoutDiary
        self.currentWeights.heavy = weight
    }
    
    // MARK: Types
    
    // weights of the exercise
    struct Weights {
        var heavy = 0
        var warmup25: Int { return roundToFives(Double(heavy) * 0.25) }
        var warmup50: Int { return roundToFives(Double(heavy) * 0.50) }
    }
    
    struct PropertyKey {
        static let nameKey = "Exercise_name"
        static let notesKey = "Exercise_notes"
        static let workoutDiaryKey = "Exercise_workoutDiary"
        static let currentWeightsHeavyKey = "Exercise_currentWeightsHeavy"
    }
    
    func recordWorkout(date: String, weight: Int, repsFirstSet: Int, repsSecondSet: Int) {
        let newSets = [Set(weight: weight, repCount: repsFirstSet),Set(weight: weight, repCount: repsSecondSet)]
        let newWorkoutLogEntry = Workout(date: date, sets: newSets)
        workoutDiary.addWorkout(newWorkoutLogEntry)
    }
    
    func getLastWorkout() -> Workout? {
        if let workout = workoutDiary.getLastWorkout() {
            return workout
        } else {
            return nil
        }
    }
    
    func getBarWeightsString(targetWeight: Int) -> String {
        if targetWeight < 54 {
            return "Bar"
        } else {
            return calculatePlates(roundToFives(Double(targetWeight)))
        }
    }
    
    // MARK: NSCoder
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(notes, forKey: PropertyKey.notesKey)
        aCoder.encodeObject(workoutDiary, forKey: PropertyKey.workoutDiaryKey)
        aCoder.encodeInteger(currentWeights.heavy, forKey: PropertyKey.currentWeightsHeavyKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let notes = aDecoder.decodeObjectForKey(PropertyKey.notesKey) as! String?
        let workoutDiary = aDecoder.decodeObjectForKey(PropertyKey.workoutDiaryKey) as! WorkoutDiary
        let currentWeights = aDecoder.decodeIntegerForKey(PropertyKey.currentWeightsHeavyKey)

        // Must call designated initializer.
        self.init(name: name, notes: notes, workoutDiary: workoutDiary, weight: currentWeights)
    }
}
