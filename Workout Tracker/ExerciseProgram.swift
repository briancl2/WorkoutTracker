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

    
    // MARK: Initializers

    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
}
