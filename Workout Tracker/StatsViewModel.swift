//
//  StatsViewModel.swift
//  Workout Tracker
//
//  Created by briancl on 6/1/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

enum StatsType: Int {
    
    case Progress, OneRepMax, Goal, Cycles
    
}

struct StatsViewModel {
    
    private(set) var exercise: Exercise
    private(set) var graphType: StatsType
    
    init(exercise: Exercise, graphType: StatsType) {
        self.exercise = exercise
        self.graphType = graphType
    }
    
    var workoutDates: ([String], [Double?]) {
        if let lastWorkout = exercise.workoutDiary.last, firstWorkout = exercise.workoutDiary.first {
           
            var dates = [String]()
            var stats = [Double?]()
            let ti:NSTimeInterval = 24*60*60 //one day
            let dateFrom = firstWorkout.date
            let dateTo = lastWorkout.date
            
            var nextDate =  dateFrom
            let endDate = dateTo.dateByAddingTimeInterval(ti)
            
            while nextDate.compare(endDate) == NSComparisonResult.OrderedAscending
            {
                dates.append(nextDate.myPrettyString)
                let workout = exercise.workoutDiary.filter { $0.date.myPrettyString == nextDate.myPrettyString }.first
                if let workout = workout {
                    switch graphType {
                    case .Progress:
                        stats.append(Double(workout.totalVolume))
                    case .OneRepMax:
                        stats.append(Double(workout.oneRepMax))
                    case .Goal:
                        stats.append(Double(workout.weight))
                    default:
                        stats.append(Double(workout.totalVolume))
                    }
                } else {
                    stats.append(nil)
                }
                
                nextDate = nextDate.dateByAddingTimeInterval(ti)
            }
            
            return (dates, stats)
        }
        return ([], [])
    }
    
    var statsDescription: String {
        switch graphType {
        case .Progress:
            return "Total Volume"
        case .OneRepMax:
            return "Calculated 1RM"
        case .Goal:
            return "Weight"
        default:
            return "Total Volume"
        }
    }
    
}
