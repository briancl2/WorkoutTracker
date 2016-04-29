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
        print(oldVolume)
        print(newVolume)
        return Int(100 * (newVolume - oldVolume) / oldVolume)
    }
    
    func calcTotalVolume(workout: Workout) -> Int {
        var totalVolume = 0
        for set in workout.sets {
            totalVolume += set.weight * set.repCount
        }
        return totalVolume
    }
    
}