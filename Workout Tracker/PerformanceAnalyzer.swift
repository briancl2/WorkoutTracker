//
//  PerformanceAnalyzer.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

class PerformanceAnalyzer {
    var dayRange = 15
    
    func calcTotalVolumeIncrease(diary: WorkoutDiary, dateRange: Int) -> Int{
        let oldVolume = calcTotalVolume(diary.getOldestWorkoutFromRange(dateRange)!)
        let newVolume = calcTotalVolume(diary.getLastWorkout()!)
        return Int(100 * (newVolume - oldVolume) / oldVolume)
    }
    
    func calcTotalVolume(workout: Workout) -> Int {
        return workout.sets.reduce(0, combine: { $0 + $1.volume })
    }
    
//    func calcGoalAttainment() -> Int {
//        // get goal in 1RM
//        // get current volume with current reps.
//        // convert current volume with reps to 1RM
//        // return percentage
//    }
//    
//    func calc1RM(workout: Workout) -> Int {
//        // convert workout to volume
//    }
    
}