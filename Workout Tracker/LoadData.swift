//
//  LoadData.swift
//  Workout Tracker
//
//  Created by briancl on 6/8/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift

func LoadDataDefaults() {
    
    let realm = try! Realm()
    guard realm.isEmpty else {return}
    
    let squat = Exercise(exerciseType: .BackSquat, notes: "Squat Notes")
    squat.recordWorkout("16-04-20", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
    squat.recordWorkout("16-04-22", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
    squat.recordWorkout("16-04-25", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
    squat.recordWorkout("16-04-27", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
    squat.recordWorkout("16-04-29", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
    squat.recordWorkout("16-05-02", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
    squat.recordWorkout("16-05-05", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
    squat.recordWorkout("16-05-07", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
    squat.recordWorkout("16-05-09", weight: 145, repsFirstSet: 12, repsSecondSet: 11)
    squat.recordWorkout("16-05-12", weight: 145, repsFirstSet: 13, repsSecondSet: 11)
    squat.recordWorkout("16-05-14", weight: 155, repsFirstSet: 9, repsSecondSet: 7)
    squat.recordWorkout("16-05-16", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
    squat.recordWorkout("16-05-18", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
    squat.recordWorkout("16-05-20", weight: 155, repsFirstSet: 10, repsSecondSet: 9)
    squat.recordWorkout("16-05-23", weight: 155, repsFirstSet: 10, repsSecondSet: 10)
    squat.recordWorkout("16-05-25", weight: 155, repsFirstSet: 10, repsSecondSet: 10)
    squat.recordWorkout("16-05-27", weight: 155, repsFirstSet: 11, repsSecondSet: 10)
    squat.recordWorkout("16-05-31", weight: 155, repsFirstSet: 12, repsSecondSet: 10)
    squat.recordWorkout("16-06-02", weight: 155, repsFirstSet: 12, repsSecondSet: 11)
    squat.recordWorkout("16-06-06", weight: 155, repsFirstSet: 13, repsSecondSet: 11)
    squat.recordWorkout("16-06-10", weight: 170, repsFirstSet: 9, repsSecondSet: 7)
    squat.recordWorkout("16-06-22", weight: 170, repsFirstSet: 9, repsSecondSet: 7)
    squat.recordWorkout("16-06-24", weight: 170, repsFirstSet: 9, repsSecondSet: 8)
    squat.recordWorkout("16-06-29", weight: 170, repsFirstSet: 10, repsSecondSet: 9)
    squat.recordWorkout("16-07-05", weight: 170, repsFirstSet: 11, repsSecondSet: 9)
    squat.recordWorkout("16-07-07", weight: 170, repsFirstSet: 11, repsSecondSet: 10)
    squat.recordWorkout("16-07-09", weight: 170, repsFirstSet: 11, repsSecondSet: 9)
    squat.recordWorkout("16-07-11", weight: 170, repsFirstSet: 12, repsSecondSet: 10)
    squat.recordWorkout("16-07-13", weight: 170, repsFirstSet: 13, repsSecondSet: 11)
    
    let bench = Exercise(exerciseType: .BenchPress, notes: "Bench Press Notes")
    bench.recordWorkout("16-04-20", weight: 125, repsFirstSet: 13, repsSecondSet: 11)
    bench.recordWorkout("16-04-22", weight: 135, repsFirstSet: 9, repsSecondSet: 7)
    bench.recordWorkout("16-04-25", weight: 135, repsFirstSet: 9, repsSecondSet: 8)
    bench.recordWorkout("16-04-27", weight: 135, repsFirstSet: 10, repsSecondSet: 8)
    bench.recordWorkout("16-04-29", weight: 135, repsFirstSet: 10, repsSecondSet: 8)
    bench.recordWorkout("16-05-02", weight: 135, repsFirstSet: 10, repsSecondSet: 9)
    bench.recordWorkout("16-05-05", weight: 135, repsFirstSet: 11, repsSecondSet: 9)
    bench.recordWorkout("16-05-07", weight: 135, repsFirstSet: 11, repsSecondSet: 9)
    bench.recordWorkout("16-05-09", weight: 135, repsFirstSet: 11, repsSecondSet: 10)
    bench.recordWorkout("16-05-12", weight: 135, repsFirstSet: 12, repsSecondSet: 10)
    bench.recordWorkout("16-05-14", weight: 135, repsFirstSet: 12, repsSecondSet: 10)
    bench.recordWorkout("16-05-16", weight: 135, repsFirstSet: 12, repsSecondSet: 11)
    bench.recordWorkout("16-05-18", weight: 135, repsFirstSet: 13, repsSecondSet: 10)
    bench.recordWorkout("16-05-20", weight: 135, repsFirstSet: 13, repsSecondSet: 11)
    bench.recordWorkout("16-05-23", weight: 145, repsFirstSet: 9, repsSecondSet: 8)
    bench.recordWorkout("16-05-25", weight: 145, repsFirstSet: 9, repsSecondSet: 8)
    bench.recordWorkout("16-05-27", weight: 145, repsFirstSet: 10, repsSecondSet: 8)
    bench.recordWorkout("16-05-31", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
    bench.recordWorkout("16-06-02", weight: 145, repsFirstSet: 11, repsSecondSet: 8)
    bench.recordWorkout("16-06-06", weight: 145, repsFirstSet: 11, repsSecondSet: 8)
    bench.recordWorkout("16-06-08", weight: 145, repsFirstSet: 11, repsSecondSet: 9)
    bench.recordWorkout("16-06-10", weight: 145, repsFirstSet: 12, repsSecondSet: 9)
    bench.recordWorkout("16-06-22", weight: 145, repsFirstSet: 12, repsSecondSet: 7)
    bench.recordWorkout("16-06-24", weight: 145, repsFirstSet: 11, repsSecondSet: 8)
    bench.recordWorkout("16-06-29", weight: 145, repsFirstSet: 12, repsSecondSet: 9)
    bench.recordWorkout("16-07-05", weight: 145, repsFirstSet: 12, repsSecondSet: 8)
    bench.recordWorkout("16-07-07", weight: 145, repsFirstSet: 12, repsSecondSet: 9)
    bench.recordWorkout("16-07-09", weight: 145, repsFirstSet: 12, repsSecondSet: 9)
    bench.recordWorkout("16-07-11", weight: 145, repsFirstSet: 12, repsSecondSet: 8)
    bench.recordWorkout("16-07-13", weight: 145, repsFirstSet: 12, repsSecondSet: 7)
    
    let row = Exercise(exerciseType: .BentOverRow, notes: "Bent Over Row notes")
    row.recordWorkout("16-04-20", weight: 115, repsFirstSet: 11, repsSecondSet: 10)
    row.recordWorkout("16-04-22", weight: 115, repsFirstSet: 11, repsSecondSet: 11)
    row.recordWorkout("16-04-25", weight: 115, repsFirstSet: 11, repsSecondSet: 11)
    row.recordWorkout("16-04-27", weight: 115, repsFirstSet: 12, repsSecondSet: 10)
    row.recordWorkout("16-04-29", weight: 115, repsFirstSet: 13, repsSecondSet: 10)
    row.recordWorkout("16-05-02", weight: 115, repsFirstSet: 13, repsSecondSet: 11)
    row.recordWorkout("16-05-05", weight: 125, repsFirstSet: 9, repsSecondSet: 8)
    row.recordWorkout("16-05-07", weight: 125, repsFirstSet: 9, repsSecondSet: 9)
    row.recordWorkout("16-05-09", weight: 125, repsFirstSet: 10, repsSecondSet: 9)
    row.recordWorkout("16-05-12", weight: 125, repsFirstSet: 10, repsSecondSet: 10)
    row.recordWorkout("16-05-14", weight: 125, repsFirstSet: 11, repsSecondSet: 10)
    row.recordWorkout("16-05-16", weight: 125, repsFirstSet: 12, repsSecondSet: 10)
    row.recordWorkout("16-05-18", weight: 125, repsFirstSet: 13, repsSecondSet: 11)
    row.recordWorkout("16-05-20", weight: 135, repsFirstSet: 9, repsSecondSet: 8)
    row.recordWorkout("16-05-23", weight: 135, repsFirstSet: 9, repsSecondSet: 9)
    row.recordWorkout("16-05-25", weight: 135, repsFirstSet: 9, repsSecondSet: 9)
    row.recordWorkout("16-05-27", weight: 135, repsFirstSet: 10, repsSecondSet: 9)
    row.recordWorkout("16-05-31", weight: 135, repsFirstSet: 10, repsSecondSet: 9)
    row.recordWorkout("16-06-02", weight: 135, repsFirstSet: 11, repsSecondSet: 10)
    row.recordWorkout("16-06-06", weight: 135, repsFirstSet: 11, repsSecondSet: 10)
    row.recordWorkout("16-06-08", weight: 135, repsFirstSet: 11, repsSecondSet: 10)
    row.recordWorkout("16-06-10", weight: 135, repsFirstSet: 12, repsSecondSet: 9)
    row.recordWorkout("16-06-22", weight: 135, repsFirstSet: 12, repsSecondSet: 9)
    row.recordWorkout("16-06-24", weight: 135, repsFirstSet: 12, repsSecondSet: 10)
    row.recordWorkout("16-06-26", weight: 135, repsFirstSet: 12, repsSecondSet: 11)
    row.recordWorkout("16-06-29", weight: 135, repsFirstSet: 12, repsSecondSet: 11)
    row.recordWorkout("16-07-05", weight: 135, repsFirstSet: 13, repsSecondSet: 11)
    row.recordWorkout("16-07-07", weight: 145, repsFirstSet: 9, repsSecondSet: 8)
    row.recordWorkout("16-07-09", weight: 145, repsFirstSet: 9, repsSecondSet: 9)
    row.recordWorkout("16-07-11", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
    row.recordWorkout("16-07-13", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
    
    let ohp = Exercise(exerciseType: .OverheadPress, notes: "OHP notes")
    ohp.recordWorkout("16-04-20", weight: 95, repsFirstSet: 8, repsSecondSet: 8)
    ohp.recordWorkout("16-04-22", weight: 95, repsFirstSet: 10, repsSecondSet: 7)
    ohp.recordWorkout("16-04-25", weight: 95, repsFirstSet: 10, repsSecondSet: 7)
    ohp.recordWorkout("16-04-27", weight: 95, repsFirstSet: 10, repsSecondSet: 7)
    ohp.recordWorkout("16-04-29", weight: 95, repsFirstSet: 10, repsSecondSet: 7)
    ohp.recordWorkout("16-05-02", weight: 95, repsFirstSet: 10, repsSecondSet: 8)
    ohp.recordWorkout("16-05-05", weight: 95, repsFirstSet: 10, repsSecondSet: 8)
    ohp.recordWorkout("16-05-07", weight: 95, repsFirstSet: 10, repsSecondSet: 8)
    ohp.recordWorkout("16-05-09", weight: 95, repsFirstSet: 10, repsSecondSet: 8)
    ohp.recordWorkout("16-05-12", weight: 95, repsFirstSet: 10, repsSecondSet: 9)
    ohp.recordWorkout("16-05-14", weight: 95, repsFirstSet: 10, repsSecondSet: 10)
    ohp.recordWorkout("16-05-16", weight: 95, repsFirstSet: 10, repsSecondSet: 10)
    ohp.recordWorkout("16-05-18", weight: 95, repsFirstSet: 11, repsSecondSet: 8)
    ohp.recordWorkout("16-05-20", weight: 95, repsFirstSet: 11, repsSecondSet: 9)
    ohp.recordWorkout("16-05-23", weight: 95, repsFirstSet: 11, repsSecondSet: 9)
    ohp.recordWorkout("16-05-25", weight: 95, repsFirstSet: 11, repsSecondSet: 9)
    ohp.recordWorkout("16-05-27", weight: 95, repsFirstSet: 11, repsSecondSet: 7)
    ohp.recordWorkout("16-05-31", weight: 95, repsFirstSet: 11, repsSecondSet: 9)
    ohp.recordWorkout("16-06-02", weight: 95, repsFirstSet: 11, repsSecondSet: 8)
    ohp.recordWorkout("16-06-06", weight: 95, repsFirstSet: 11, repsSecondSet: 10)
    ohp.recordWorkout("16-06-08", weight: 95, repsFirstSet: 12, repsSecondSet: 9)
    ohp.recordWorkout("16-06-10", weight: 95, repsFirstSet: 12, repsSecondSet: 8)
    ohp.recordWorkout("16-06-22", weight: 95, repsFirstSet: 12, repsSecondSet: 8)
    ohp.recordWorkout("16-06-24", weight: 95, repsFirstSet: 12, repsSecondSet: 9)
    ohp.recordWorkout("16-06-26", weight: 95, repsFirstSet: 12, repsSecondSet: 9)
    ohp.recordWorkout("16-06-29", weight: 95, repsFirstSet: 12, repsSecondSet: 8)
    ohp.recordWorkout("16-07-05", weight: 95, repsFirstSet: 12, repsSecondSet: 7)
    ohp.recordWorkout("16-07-07", weight: 95, repsFirstSet: 12, repsSecondSet: 7)
    ohp.recordWorkout("16-07-09", weight: 95, repsFirstSet: 12, repsSecondSet: 8)
    ohp.recordWorkout("16-07-11", weight: 95, repsFirstSet: 12, repsSecondSet: 8)
    ohp.recordWorkout("16-07-13", weight: 95, repsFirstSet: 12, repsSecondSet: 9)
    
    let sldl = Exercise(exerciseType: .StraightLeggedDeadlift, notes: "SLDL notes")
    sldl.recordWorkout("16-04-20", weight: 95, repsFirstSet: 13, repsSecondSet: 11)
    sldl.recordWorkout("16-04-22", weight: 95, repsFirstSet: 13, repsSecondSet: 12)
    sldl.recordWorkout("16-04-25", weight: 105, repsFirstSet: 9, repsSecondSet: 8)
    sldl.recordWorkout("16-04-27", weight: 105, repsFirstSet: 10, repsSecondSet: 10)
    sldl.recordWorkout("16-04-29", weight: 105, repsFirstSet: 11, repsSecondSet: 10)
    sldl.recordWorkout("16-05-02", weight: 105, repsFirstSet: 12, repsSecondSet: 11)
    sldl.recordWorkout("16-05-05", weight: 105, repsFirstSet: 12, repsSecondSet: 11)
    sldl.recordWorkout("16-05-07", weight: 105, repsFirstSet: 13, repsSecondSet: 11)
    sldl.recordWorkout("16-05-09", weight: 115, repsFirstSet: 9, repsSecondSet: 8)
    sldl.recordWorkout("16-05-12", weight: 115, repsFirstSet: 10, repsSecondSet: 9)
    sldl.recordWorkout("16-05-14", weight: 115, repsFirstSet: 11, repsSecondSet: 10)
    sldl.recordWorkout("16-05-16", weight: 115, repsFirstSet: 12, repsSecondSet: 10)
    sldl.recordWorkout("16-05-18", weight: 115, repsFirstSet: 13, repsSecondSet: 11)
    sldl.recordWorkout("16-05-20", weight: 115, repsFirstSet: 13, repsSecondSet: 11)
    sldl.recordWorkout("16-05-23", weight: 125, repsFirstSet: 9, repsSecondSet: 8)
    sldl.recordWorkout("16-05-25", weight: 125, repsFirstSet: 10, repsSecondSet: 9)
    sldl.recordWorkout("16-05-27", weight: 125, repsFirstSet: 11, repsSecondSet: 10)
    sldl.recordWorkout("16-05-31", weight: 125, repsFirstSet: 12, repsSecondSet: 11)
    sldl.recordWorkout("16-06-02", weight: 125, repsFirstSet: 13, repsSecondSet: 11)
    sldl.recordWorkout("16-06-06", weight: 135, repsFirstSet: 9, repsSecondSet: 9)
    sldl.recordWorkout("16-06-08", weight: 135, repsFirstSet: 10, repsSecondSet: 9)
    sldl.recordWorkout("16-06-10", weight: 135, repsFirstSet: 10, repsSecondSet: 10)
    sldl.recordWorkout("16-06-22", weight: 135, repsFirstSet: 10, repsSecondSet: 10)
    sldl.recordWorkout("16-06-24", weight: 135, repsFirstSet: 11, repsSecondSet: 10)
    sldl.recordWorkout("16-06-26", weight: 135, repsFirstSet: 12, repsSecondSet: 12)
    sldl.recordWorkout("16-06-29", weight: 145, repsFirstSet: 9, repsSecondSet: 8)
    sldl.recordWorkout("16-07-05", weight: 145, repsFirstSet: 10, repsSecondSet: 8)
    sldl.recordWorkout("16-07-07", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
    sldl.recordWorkout("16-07-09", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
    sldl.recordWorkout("16-07-11", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
    sldl.recordWorkout("16-07-13", weight: 145, repsFirstSet: 12, repsSecondSet: 10)
    
    let chin = Exercise(exerciseType: .ChinUp, notes: "Chin notes")
    chin.recordWorkout("16-04-20", weight: 110, repsFirstSet: 10, repsSecondSet: 9)
    chin.recordWorkout("16-04-22", weight: 110, repsFirstSet: 10, repsSecondSet: 9)
    chin.recordWorkout("16-04-25", weight: 110, repsFirstSet: 10, repsSecondSet: 10)
    chin.recordWorkout("16-04-27", weight: 110, repsFirstSet: 11, repsSecondSet: 10)
    chin.recordWorkout("16-04-29", weight: 110, repsFirstSet: 11, repsSecondSet: 10)
    chin.recordWorkout("16-05-05", weight: 110, repsFirstSet: 11, repsSecondSet: 11)
    chin.recordWorkout("16-05-07", weight: 110, repsFirstSet: 11, repsSecondSet: 11)
    chin.recordWorkout("16-05-09", weight: 110, repsFirstSet: 12, repsSecondSet: 11)
    chin.recordWorkout("16-05-12", weight: 110, repsFirstSet: 13, repsSecondSet: 11)
    chin.recordWorkout("16-05-14", weight: 110, repsFirstSet: 13, repsSecondSet: 11)
    chin.recordWorkout("16-05-16", weight: 120, repsFirstSet: 11, repsSecondSet: 9)
    chin.recordWorkout("16-05-18", weight: 120, repsFirstSet: 11, repsSecondSet: 9)
    chin.recordWorkout("16-05-20", weight: 120, repsFirstSet: 11, repsSecondSet: 10)
    chin.recordWorkout("16-05-23", weight: 120, repsFirstSet: 12, repsSecondSet: 11)
    chin.recordWorkout("16-05-25", weight: 120, repsFirstSet: 12, repsSecondSet: 11)
    chin.recordWorkout("16-05-27", weight: 120, repsFirstSet: 13, repsSecondSet: 11)
    chin.recordWorkout("16-05-31", weight: 135, repsFirstSet: 9, repsSecondSet: 8)
    chin.recordWorkout("16-06-02", weight: 135, repsFirstSet: 10, repsSecondSet: 8)
    chin.recordWorkout("16-06-06", weight: 135, repsFirstSet: 11, repsSecondSet: 9)
    chin.recordWorkout("16-06-08", weight: 135, repsFirstSet: 11, repsSecondSet: 9)
    chin.recordWorkout("16-06-10", weight: 135, repsFirstSet: 11, repsSecondSet: 9)
    chin.recordWorkout("16-06-22", weight: 135, repsFirstSet: 11, repsSecondSet: 10)
    chin.recordWorkout("16-06-24", weight: 135, repsFirstSet: 12, repsSecondSet: 9)
    chin.recordWorkout("16-06-29", weight: 135, repsFirstSet: 12, repsSecondSet: 10)
    chin.recordWorkout("16-07-05", weight: 135, repsFirstSet: 12, repsSecondSet: 10)
    chin.recordWorkout("16-07-07", weight: 135, repsFirstSet: 13, repsSecondSet: 10)
    chin.recordWorkout("16-07-09", weight: 135, repsFirstSet: 13, repsSecondSet: 9)
    chin.recordWorkout("16-07-11", weight: 135, repsFirstSet: 13, repsSecondSet: 10)
    chin.recordWorkout("16-07-13", weight: 135, repsFirstSet: 13, repsSecondSet: 11)
    
    let calf = Exercise(exerciseType: .CalfRaise, notes: "calf notes")
    calf.recordWorkout("16-04-20", weight: 150, repsFirstSet: 13, repsSecondSet: 11)
    calf.recordWorkout("16-04-22", weight: 175, repsFirstSet: 10, repsSecondSet: 8)
    calf.recordWorkout("16-04-25", weight: 175, repsFirstSet: 10, repsSecondSet: 10)
    calf.recordWorkout("16-04-27", weight: 175, repsFirstSet: 11, repsSecondSet: 10)
    calf.recordWorkout("16-04-29", weight: 175, repsFirstSet: 11, repsSecondSet: 11)
    calf.recordWorkout("16-05-05", weight: 175, repsFirstSet: 12, repsSecondSet: 11)
    calf.recordWorkout("16-05-09", weight: 175, repsFirstSet: 12, repsSecondSet: 11)
    calf.recordWorkout("16-05-12", weight: 175, repsFirstSet: 13, repsSecondSet: 11)
    calf.recordWorkout("16-05-16", weight: 195, repsFirstSet: 9, repsSecondSet: 8)
    calf.recordWorkout("16-05-18", weight: 195, repsFirstSet: 10, repsSecondSet: 9)
    calf.recordWorkout("16-05-20", weight: 195, repsFirstSet: 12, repsSecondSet: 11)
    calf.recordWorkout("16-05-23", weight: 195, repsFirstSet: 12, repsSecondSet: 11)
    calf.recordWorkout("16-05-25", weight: 195, repsFirstSet: 13, repsSecondSet: 11)
    calf.recordWorkout("16-05-27", weight: 215, repsFirstSet: 10, repsSecondSet: 9)
    calf.recordWorkout("16-05-31", weight: 215, repsFirstSet: 11, repsSecondSet: 10)
    calf.recordWorkout("16-06-06", weight: 215, repsFirstSet: 12, repsSecondSet: 10)
    calf.recordWorkout("16-06-08", weight: 215, repsFirstSet: 12, repsSecondSet: 10)
    calf.recordWorkout("16-06-22", weight: 215, repsFirstSet: 12, repsSecondSet: 10)
    calf.recordWorkout("16-06-24", weight: 215, repsFirstSet: 13, repsSecondSet: 10)
    calf.recordWorkout("16-06-29", weight: 215, repsFirstSet: 13, repsSecondSet: 11)
    calf.recordWorkout("16-07-05", weight: 235, repsFirstSet: 9, repsSecondSet: 8)
    calf.recordWorkout("16-07-07", weight: 235, repsFirstSet: 10, repsSecondSet: 9)
    
    let torso = Exercise(exerciseType: .TorsoRotation, notes: "torso notes")
    torso.recordWorkout("16-04-20", weight: 130, repsFirstSet: 13, repsSecondSet: 11)
    torso.recordWorkout("16-04-22", weight: 140, repsFirstSet: 9, repsSecondSet: 9)
    torso.recordWorkout("16-04-25", weight: 140, repsFirstSet: 11, repsSecondSet: 9)
    torso.recordWorkout("16-04-27", weight: 140, repsFirstSet: 10, repsSecondSet: 10)
    torso.recordWorkout("16-04-29", weight: 140, repsFirstSet: 11, repsSecondSet: 10)
    torso.recordWorkout("16-05-05", weight: 140, repsFirstSet: 11, repsSecondSet: 10)
    torso.recordWorkout("16-05-07", weight: 140, repsFirstSet: 11, repsSecondSet: 11)
    torso.recordWorkout("16-05-09", weight: 140, repsFirstSet: 11, repsSecondSet: 11)
    torso.recordWorkout("16-05-12", weight: 140, repsFirstSet: 12, repsSecondSet: 11)
    torso.recordWorkout("16-05-14", weight: 140, repsFirstSet: 12, repsSecondSet: 11)
    torso.recordWorkout("16-05-16", weight: 140, repsFirstSet: 13, repsSecondSet: 11)
    torso.recordWorkout("16-05-20", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
    torso.recordWorkout("16-05-23", weight: 155, repsFirstSet: 10, repsSecondSet: 9)
    torso.recordWorkout("16-05-25", weight: 155, repsFirstSet: 11, repsSecondSet: 9)
    torso.recordWorkout("16-05-27", weight: 155, repsFirstSet: 12, repsSecondSet: 10)
    torso.recordWorkout("16-05-31", weight: 155, repsFirstSet: 12, repsSecondSet: 10)
    torso.recordWorkout("16-06-06", weight: 155, repsFirstSet: 12, repsSecondSet: 11)
    torso.recordWorkout("16-06-08", weight: 155, repsFirstSet: 13, repsSecondSet: 11)
    torso.recordWorkout("16-06-22", weight: 170, repsFirstSet: 9, repsSecondSet: 8)
    torso.recordWorkout("16-06-24", weight: 170, repsFirstSet: 9, repsSecondSet: 9)
    torso.recordWorkout("16-06-29", weight: 170, repsFirstSet: 9, repsSecondSet: 9)
    torso.recordWorkout("16-07-05", weight: 170, repsFirstSet: 10, repsSecondSet: 9)
    torso.recordWorkout("16-07-07", weight: 170, repsFirstSet: 10, repsSecondSet: 10)
    
    let curl = Exercise(exerciseType: .Curl, notes: "curl notes")
    curl.recordWorkout("16-04-20", weight: 50, repsFirstSet: 11, repsSecondSet: 8)
    curl.recordWorkout("16-04-22", weight: 50, repsFirstSet: 11, repsSecondSet: 9)
    curl.recordWorkout("16-04-25", weight: 50, repsFirstSet: 12, repsSecondSet: 10)
    curl.recordWorkout("16-04-27", weight: 50, repsFirstSet: 12, repsSecondSet: 10)
    curl.recordWorkout("16-04-29", weight: 50, repsFirstSet: 12, repsSecondSet: 11)
    curl.recordWorkout("16-05-05", weight: 50, repsFirstSet: 13, repsSecondSet: 11)
    curl.recordWorkout("16-05-07", weight: 60, repsFirstSet: 9, repsSecondSet: 8)
    curl.recordWorkout("16-05-09", weight: 60, repsFirstSet: 9, repsSecondSet: 9)
    curl.recordWorkout("16-05-12", weight: 60, repsFirstSet: 10, repsSecondSet: 9)
    curl.recordWorkout("16-05-14", weight: 60, repsFirstSet: 10, repsSecondSet: 9)
    curl.recordWorkout("16-05-16", weight: 60, repsFirstSet: 11, repsSecondSet: 9)
    curl.recordWorkout("16-05-18", weight: 60, repsFirstSet: 12, repsSecondSet: 9)
    curl.recordWorkout("16-05-20", weight: 60, repsFirstSet: 12, repsSecondSet: 10)
    curl.recordWorkout("16-05-23", weight: 60, repsFirstSet: 12, repsSecondSet: 10)
    curl.recordWorkout("16-05-25", weight: 60, repsFirstSet: 13, repsSecondSet: 11)
    curl.recordWorkout("16-05-27", weight: 70, repsFirstSet: 9, repsSecondSet: 7)
    curl.recordWorkout("16-05-31", weight: 70, repsFirstSet: 9, repsSecondSet: 8)
    curl.recordWorkout("16-06-06", weight: 70, repsFirstSet: 10, repsSecondSet: 8)
    curl.recordWorkout("16-06-08", weight: 70, repsFirstSet: 10, repsSecondSet: 7)
    curl.recordWorkout("16-06-22", weight: 70, repsFirstSet: 10, repsSecondSet: 7)
    curl.recordWorkout("16-06-24", weight: 70, repsFirstSet: 10, repsSecondSet: 7)
    curl.recordWorkout("16-06-29", weight: 70, repsFirstSet: 10, repsSecondSet: 7)
    curl.recordWorkout("16-07-05", weight: 70, repsFirstSet: 11, repsSecondSet: 7)
    curl.recordWorkout("16-07-07", weight: 70, repsFirstSet: 11, repsSecondSet: 7)
    
    let exercises = ExerciseProgram(name: "Allpro Auto-regulated")
    let user = User(bodyWeight: 160, name: "Brian", age: 34)
    
    squat.sortOrder = 0
    bench.sortOrder = 1
    row.sortOrder = 2
    ohp.sortOrder = 3
    sldl.sortOrder = 4
    chin.sortOrder = 5
    calf.sortOrder = 6
    torso.sortOrder = 7
    curl.sortOrder = 8
    
    try! realm.write {
        realm.add(exercises)
        realm.add(user)
        realm.add(squat)
        realm.add(bench)
        realm.add(row)
        realm.add(ohp)
        realm.add(sldl)
        realm.add(chin)
        realm.add(calf)
        realm.add(torso)
        realm.add(curl)
    }
}
