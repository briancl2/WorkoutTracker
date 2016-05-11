//
//  Sets.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

class Sets: NSObject, NSCoding {
    var weight: Int
    var repCount: Int
    var volume: Int { return weight * repCount }

    init(weight: Int, repCount: Int) {
        self.weight = weight
        self.repCount = repCount
    }
    
    struct PropertyKey {
        static let weightKey = "Sets_weight"
        static let repCountKey = "Sets_repCount"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(weight, forKey: PropertyKey.weightKey)
        aCoder.encodeInteger(repCount, forKey: PropertyKey.repCountKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let weight = aDecoder.decodeIntegerForKey(PropertyKey.weightKey)
        let repCount = aDecoder.decodeIntegerForKey(PropertyKey.repCountKey)
        
        self.init(weight: weight, repCount: repCount)
    }
    
}

