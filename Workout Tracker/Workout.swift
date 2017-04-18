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
    
    fileprivate(set) dynamic var date = Date()
    fileprivate(set) var sets = List<WorkSet>()
    var weight: Int {
        return sets.map({$0.weight}).max()!
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
    
    convenience init(date: Date, sets: List<WorkSet>) {
        self.init()
        self.date = date
        self.sets = sets
    }
    
    // required for ObjectMapper
    required convenience init?(map: Map) {
        self.init()
    }
    
}

// Support for ObjectMapper
extension Workout {
    
    func mapping(map: Map) {
        date <- (map["date"], DateTransform())
        sets <- (map["sets"], ListTransform<WorkSet>())
    }
    
}
