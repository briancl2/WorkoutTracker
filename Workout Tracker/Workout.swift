//
//  Workout.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift

class Workout: Object {
    
    // MARK: Public Properties
    
    dynamic var date = NSDate()
    var sets = List<WorkSet>()
    var totalVolume: Int {
        return sets.reduce(0, combine: { $0 + $1.volume })
    }
    
    var weight: Int {
        return sets.map({$0.weight}).maxElement()!
    }
    
    // MARK: Initializers
    
    convenience init(date: NSDate, sets: List<WorkSet>) {
        self.init()
        self.date = date
        self.sets = sets
    }
}

