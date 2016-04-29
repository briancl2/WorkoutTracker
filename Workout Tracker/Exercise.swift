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
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        
        let newSets = [Set(weight: weight, repCount: repsFirstSet),Set(weight: weight, repCount: repsSecondSet)]
        let newWorkoutLogEntry = Workout(date: dateFormatter.dateFromString(date)!, sets: newSets)
        workoutDiary.addWorkout(newWorkoutLogEntry)
        
        //update weights
        self.currentWeights.heavy = weight
    }
    
    func getLastWorkout() -> Workout? {
        if let workout = workoutDiary.getLastWorkout() {
            return workout
        } else {
            return nil
        }
    }
    
    func getOldestWorkoutFromRange(dateRange: Int? = nil) -> Workout? {
        return workoutDiary.getOldestWorkoutFromRange(15)
    }
    
    func getBarWeightsString(targetWeight: Int) -> String {
        if targetWeight < 54 {
            return "Bar"
        } else {
            return calculatePlates(roundToFives(Double(targetWeight)))
        }
    }

    func getTotalVolumeIncrease(dateRange: Int) -> Int {
        let perfAnalyzer = PerformanceAnalyzer()
        return perfAnalyzer.calcTotalVolumeIncrease(workoutDiary, dateRange: dateRange)
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
