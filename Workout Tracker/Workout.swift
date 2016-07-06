//
//  Workout.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

final class Workout: Object, Mappable {
    
    // MARK: Public Properties
    
    dynamic var date = NSDate()
    var sets = List<WorkSet>()
    var weight: Int {
        return sets.map({$0.weight}).maxElement()!
    }
    
    var totalVolume: Int {
        return sets.reduce(0) { $0 + $1.volume }
    }
    
    var totalReps: Int {
        return sets.reduce(0) { $0 + $1.repCount }
    }
    
    var oneRepMax: Int {
        let set = sets.first!
        let weight = Double(set.weight)
        let repCount = set.repCount
        
        return Int(100 * weight / (48.8 + 53.8 * pow(M_E, -0.075 * Double(repCount))))
    }
    
    // MARK: Initializers
    
    convenience init(date: NSDate, sets: List<WorkSet>) {
        self.init()
        self.date = date
        self.sets = sets
    }
    
    // required for ObjectMapper
    required convenience init?(_ map: Map) {
        self.init()
    }
    
}

// Support for ObjectMapper
extension Workout {
    
    func mapping(map: Map) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d"
        date <- (map["date"], DateFormatterTransform(dateFormatter: dateFormatter))
        sets <- (map["sets"], ListTransform<WorkSet>())
    }
    
}