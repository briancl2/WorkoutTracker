//
//  ExerciseType.swift
//  Workout Tracker
//
//  Created by briancl on 7/9/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

enum ExerciseType: EnumCollection {
    
    case BackSquat, FrontSquat, BenchPress, BentOverRow, PendlayRow, OverheadPress, PushPress, StraightLeggedDeadlift, RomanianDeadlift, Deadlift, SumoDeadlift, ChinUp, PullUp, CalfRaise, TorsoRotation, Curl, Dip
    
    private static let associatedValues = [
        BackSquat: (bodyWeightMultiplier: 2.0, name: "Back Squat"),
        FrontSquat: (bodyWeightMultiplier: 2.0, name: "Front Squat"),
        BenchPress: (bodyWeightMultiplier: 1.5, name: "Bench Press"),
        BentOverRow: (bodyWeightMultiplier: 1.5, name: "Bent Over Row"),
        PendlayRow: (bodyWeightMultiplier: 1.5, name: "Pendlay Row"),
        OverheadPress: (bodyWeightMultiplier: 1.0, name: "Overhead Press"),
        PushPress: (bodyWeightMultiplier: 1.5, name: "Push Press"),
        StraightLeggedDeadlift: (bodyWeightMultiplier: 2.0, name: "Straight Legged Deadlift"),
        RomanianDeadlift: (bodyWeightMultiplier: 2.0, name: "Romanian Deadlift"),
        SumoDeadlift: (bodyWeightMultiplier: 2.0, name: "Sumo Deadlift"),
        Deadlift: (bodyWeightMultiplier: 2.0, name: "Deadlift"),
        ChinUp: (bodyWeightMultiplier: 1.5, name: "Chin Up"),
        PullUp: (bodyWeightMultiplier: 1.5, name: "Pull Up"),
        CalfRaise: (bodyWeightMultiplier: 2.0, name: "Calf Raise"),
        TorsoRotation: (bodyWeightMultiplier: 2.0, name: "Torso Rotation"),
        Curl: (bodyWeightMultiplier: 1.0, name: "Curl"),
        Dip: (bodyWeightMultiplier: 1.5, name: "Dip")
    ]
    
    var bodyWeightMultiplier: Double {
        return ExerciseType.associatedValues[self]!.bodyWeightMultiplier
    }
    
    var name: String {
        return ExerciseType.associatedValues[self]!.name
    }
    
}
