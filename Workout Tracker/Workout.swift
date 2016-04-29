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
    var sets: [Set]
    
    init(date: NSDate, sets: [Set]) {
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
        let sets = aDecoder.decodeObjectForKey(PropertyKey.setsKey) as! [Set]
        
        self.init(date: date, sets: sets)
    }
    
}