//
//  ExerciseProgram.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift

final class ExerciseProgram: Object {
    
    // MARK: Public Properties
    
    dynamic var name: String = ""
    dynamic var startDate = NSDate()
    dynamic var userProfile: User?
    var program = List<Exercise>()
    var count: Int {
        return program.count
    }
    
    // MARK: Initializers

    convenience init(name: String, startDate: NSDate, program: List<Exercise>, userProfile: User) {
        self.init()
        self.name = name
        self.startDate = startDate
        self.program = program
        self.userProfile = userProfile
    }
}

extension ExerciseProgram {

    // MARK: Public Methods
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    func addExercise(newExercise: Exercise) {
        program.append(newExercise)
    }
    
    func getExercise(index: Int) -> Exercise {
        return program[index]
    }
    
    func updateExercise(index: Int, updatedExercise: Exercise) {
        program[index] = updatedExercise
    }
    
    func removeExercise(index: Int) {
        program.removeAtIndex(index)
    }
    
    func exportToCSV() {
        print("exercise name,date,weight,set 1,set 2,total volume")
        
        for exercise in program {
            for workout in exercise.workoutDiary {
                print("\(exercise.name),\(workout.date.myPrettyString),\(workout.weight),\(workout.sets[0].repCount),\(workout.sets[1].repCount),\(workout.totalVolume)")
            }
        }
    }
}