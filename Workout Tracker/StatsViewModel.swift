//
//  StatsViewModel.swift
//  Workout Tracker
//
//  Created by briancl on 6/1/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

enum StatsType: Int {
    
    case progress, oneRepMax, goal, cycles
    
}

struct StatsViewModel {
    
    fileprivate(set) var exercise: Exercise
    fileprivate(set) var graphType: StatsType
    
    init(exercise: Exercise, graphType: StatsType) {
        self.exercise = exercise
        self.graphType = graphType
    }
    
    var workoutDates: ([String], [Double?]) {
        if let lastWorkout = exercise.workoutDiary.last, let firstWorkout = exercise.workoutDiary.first {
           
            var dates = [String]()
            var stats = [Double?]()
            let ti: TimeInterval = 24*60*60 //one day
            let dateFrom = firstWorkout.date
            let dateTo = lastWorkout.date
            
            var nextDate =  dateFrom
            let endDate = dateTo.addingTimeInterval(ti)
            
            while nextDate.compare(endDate) == ComparisonResult.orderedAscending
            {
                dates.append(nextDate.myPrettyString)
                let workout = exercise.workoutDiary.filter { $0.date.myPrettyString == nextDate.myPrettyString }.first
                if let workout = workout {
                    switch graphType {
                    case .progress:
                        stats.append(Double(workout.totalVolume))
                    case .oneRepMax:
                        stats.append(Double(workout.oneRepMax))
                    case .goal:
                        stats.append(Double(workout.weight))
                    default:
                        stats.append(Double(workout.totalVolume))
                    }
                } else {
                    stats.append(nil)
                }
                
                nextDate = nextDate.addingTimeInterval(ti)
            }
            
            return (dates, stats)
        }
        return ([], [])
    }
    
    var statsDescription: String {
        switch graphType {
        case .progress:
            return "Total Volume"
        case .oneRepMax:
            return "Calculated 1RM"
        case .goal:
            return "Weight"
        default:
            return "Total Volume"
        }
    }
    
}
