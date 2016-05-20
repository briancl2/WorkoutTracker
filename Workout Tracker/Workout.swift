//
//  Workout.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

class Workout: NSObject, NSCoding {
    var date: NSDate
    var sets: [WorkSet]
    var totalVolume: Int {
        return sets.reduce(0, combine: { $0 + $1.volume })
    }
    
    var weight: Int {
        return sets.map({$0.weight}).maxElement()!
    }
    
    init(date: NSDate, sets: [WorkSet]) {
        self.date = date
        self.sets = sets
    }
    
    struct PropertyKey {
        static let dateKey = "Workout_date"
        static let setsKey = "Workout_sets"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(sets, forKey: PropertyKey.setsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        let sets = aDecoder.decodeObjectForKey(PropertyKey.setsKey) as! [WorkSet]
        
        self.init(date: date, sets: sets)
    }
}

