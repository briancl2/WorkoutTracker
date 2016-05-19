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
    var currentWeights: ExerciseWeights
    var goal = 0
    
    var calculated1RM: Int {
        return Int(OneRepMax(set: getLastWorkout()!.sets[0]).value)
    }
    
    var goalAttainment: Int {
        return GoalAttainment(set: (getLastWorkout()?.sets[0])!, goal: goal).percentage
    }

    init(name: String, notes: String?, workoutDiary: WorkoutDiary, weight: Int, goal: Int) {
        self.name = name
        self.notes = notes
        self.workoutDiary = workoutDiary
        self.currentWeights = ExerciseWeights(weight: weight)
        self.goal = goal

    }
    
    // MARK: Types
    
    
    struct ExerciseWeights {
        let heavy: Weight
        var warmup25: Weight {
            return Weight(value: Int(Double(heavy.value) * 0.25))
        }
        var warmup50: Weight {
            return Weight(value: Int(Double(heavy.value) * 0.50))
        }
        
        init(weight: Int) {
            self.heavy = Weight(value: weight)
        }
    }
    
    private struct PropertyKey {
        static let nameKey = "Exercise_name"
        static let notesKey = "Exercise_notes"
        static let workoutDiaryKey = "Exercise_workoutDiary"
        static let currentWeightsHeavyKey = "Exercise_currentWeightsHeavy"
        static let goal = "Exercise_goal"
    }
    
    func recordWorkout(date: String, weight: Int, repsFirstSet: Int, repsSecondSet: Int) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        
        let newSets = [WorkSet(weight: weight, repCount: repsFirstSet), WorkSet(weight: weight, repCount: repsSecondSet)]
        let newWorkoutLogEntry = Workout(date: dateFormatter.dateFromString(date)!, sets: newSets)
        workoutDiary.addWorkout(newWorkoutLogEntry)
        
        //update weights
        self.currentWeights = ExerciseWeights(weight: weight)
    }
    
    func recordWorkout(newWorkout: Workout) {
        workoutDiary.addWorkout(newWorkout)
        //update weights
        self.currentWeights = ExerciseWeights(weight: newWorkout.sets[0].weight)
    }
    
    func replaceWorkout(originalWorkout: Workout, newWorkout: Workout) {
        workoutDiary.replaceWorkout(originalWorkout, newWorkout: newWorkout)
    }
    
    func getLastWorkout() -> Workout? {
        return workoutDiary.diary.last
    }
    
    func getLastWorkouts(number: Int) -> [Workout]? {
        return workoutDiary.getLastWorkouts(number)
    }
    
    func getOldestWorkoutFromRange(dateRange: Int? = nil) -> Workout? {
        return workoutDiary.getOldestWorkoutFromRange(15)
    }
    
    func getTotalVolumeIncrease(dateRange: Int) -> Int? {
        return TotalVolumeIncrease(diary: workoutDiary, dateRange: dateRange).percentage
    }
    
    func getHistory() -> WorkoutDiary? {
        return workoutDiary
    }

    // MARK: NSCoder
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(notes, forKey: PropertyKey.notesKey)
        aCoder.encodeObject(workoutDiary, forKey: PropertyKey.workoutDiaryKey)
        aCoder.encodeInteger(currentWeights.heavy.value, forKey: PropertyKey.currentWeightsHeavyKey)
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
