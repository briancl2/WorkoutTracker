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
    
    // MARK: Initializers
    
    convenience init(date: NSDate, sets: List<WorkSet>) {
        self.init()
        self.date = date
        self.sets = sets
    }
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        date <- map["date"]
        sets <- (map["sets"], ListTransform<WorkSet>())
    }
}

