//
//  StatsViewModel.swift
//  Workout Tracker
//
//  Created by briancl on 6/1/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

struct StatsViewModel {
    
    var exercise: Exercise
    
    init(exercise: Exercise) {
        self.exercise = exercise
    }
    
    var workoutDates: [String] {
        return exercise.workoutDiary.map { $0.date.myPrettyString }
    }
    
    var totalVolumes: [Double] {
        return exercise.workoutDiary.map { Double($0.totalVolume) }
    }
    
}
