//
//  ExerciseType.swift
//  Workout Tracker
//
//  Created by briancl on 7/9/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

enum ExerciseType: EnumCollection {
    
    case backSquat, frontSquat, benchPress, bentOverRow, pendlayRow, overheadPress, pushPress, straightLeggedDeadlift, romanianDeadlift, deadlift, sumoDeadlift, chinUp, pullUp, calfRaise, torsoRotation, curl, dip
    
    fileprivate static let associatedValues = [
        backSquat: (bodyWeightMultiplier: 2.0, name: "Back Squat"),
        frontSquat: (bodyWeightMultiplier: 2.0, name: "Front Squat"),
        benchPress: (bodyWeightMultiplier: 1.5, name: "Bench Press"),
        bentOverRow: (bodyWeightMultiplier: 1.5, name: "Bent Over Row"),
        pendlayRow: (bodyWeightMultiplier: 1.5, name: "Pendlay Row"),
        overheadPress: (bodyWeightMultiplier: 1.0, name: "Overhead Press"),
        pushPress: (bodyWeightMultiplier: 1.5, name: "Push Press"),
        straightLeggedDeadlift: (bodyWeightMultiplier: 2.0, name: "Straight Legged Deadlift"),
        romanianDeadlift: (bodyWeightMultiplier: 2.0, name: "Romanian Deadlift"),
        sumoDeadlift: (bodyWeightMultiplier: 2.0, name: "Sumo Deadlift"),
        deadlift: (bodyWeightMultiplier: 2.0, name: "Deadlift"),
        chinUp: (bodyWeightMultiplier: 1.5, name: "Chin Up"),
        pullUp: (bodyWeightMultiplier: 1.5, name: "Pull Up"),
        calfRaise: (bodyWeightMultiplier: 2.0, name: "Calf Raise"),
        torsoRotation: (bodyWeightMultiplier: 2.0, name: "Torso Rotation"),
        curl: (bodyWeightMultiplier: 1.0, name: "Curl"),
        dip: (bodyWeightMultiplier: 1.5, name: "Dip")
    ]
    
    var bodyWeightMultiplier: Double {
        return ExerciseType.associatedValues[self]!.bodyWeightMultiplier
    }
    
    var name: String {
        return ExerciseType.associatedValues[self]!.name
    }
    
}
