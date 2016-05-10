//
//  User.swift
//  Workout Tracker
//
//  Created by briancl on 5/1/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

class User {
    var bodyWeight = 0
    
    init(bodyWeight: Int) {
        self.bodyWeight = bodyWeight
    }
    
    struct PropertyKey {
        static let bodyWeightKey = "User_bodyWeight"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(bodyWeight, forKey: PropertyKey.bodyWeightKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let bodyWeight = aDecoder.decodeIntegerForKey(PropertyKey.bodyWeightKey)
        
        self.init(bodyWeight: bodyWeight)
    }
}
