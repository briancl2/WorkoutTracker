//
//  ExerciseProgram.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift

class ExerciseProgram: Object {
    
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
}