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
    var name: String
    
    init(bodyWeight: Int, name: String) {
        self.bodyWeight = bodyWeight
        self.name = name
    }
    
    struct PropertyKey {
        static let bodyWeightKey = "User_bodyWeight"
        static let name = "User_name"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(bodyWeight, forKey: PropertyKey.bodyWeightKey)
        aCoder.encodeObject(name, forKey: PropertyKey.name)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let bodyWeight = aDecoder.decodeIntegerForKey(PropertyKey.bodyWeightKey)
        let name = aDecoder.decodeObjectForKey(PropertyKey.name) as! String
        
        self.init(bodyWeight: bodyWeight, name: name)
    }
}
