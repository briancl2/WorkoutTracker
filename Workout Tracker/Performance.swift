//
//  Performance.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation


struct TotalVolumeIncrease {
    var diary: WorkoutDiary
    var dateRange: Int
    var percentage: Int? {
        if let oldWorkout = diary.getOldestWorkoutFromRange(dateRange) {
            let oldVolume = oldWorkout.totalVolume
            let newVolume = diary.getLastWorkout()!.totalVolume
            return Int(100 * (newVolume - oldVolume) / oldVolume)
        }
        return nil
    }
}

struct GoalAttainment {
    var set: WorkSet
    var goal: Int
    var percentage: Int {
        let goalWeight = Double(goal)
        let current1RM = OneRepMax(set: set).value
        
        return Int(100 * (current1RM / goalWeight))
    }
}

struct OneRepMax {
    var set: WorkSet
    var value: Double {
        let weight = Double(set.weight)
        let repCount = set.repCount
        let coefficient = [1.0,1.0,0.943,0.906,0.881,0.856,0.831,0.807,0.786,0.765,0.744,0.723,0.703,0.688,0.675,0.662,0.650,0.638,0.627,0.616,0.606] // first element is set to 1.0 to prevent divide by zero condition, which should never happen anyway
        
        return weight / coefficient[repCount]
    }
}