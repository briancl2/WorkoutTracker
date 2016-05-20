//
//  User.swift
//  Workout Tracker
//
//  Created by briancl on 5/1/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    var bodyWeight: Int
    var name: String
    
    init(bodyWeight: Int, name: String) {
        self.bodyWeight = bodyWeight
        self.name = name
    }
    
    convenience override init() {
        self.init(bodyWeight: 1, name: "")
    }
    
    struct PropertyKey {
        static let bodyWeightKey = "User_bodyWeight"
        static let nameKey = "User_name"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(bodyWeight, forKey: PropertyKey.bodyWeightKey)
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let bodyWeight = aDecoder.decodeIntegerForKey(PropertyKey.bodyWeightKey)
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        self.init(bodyWeight: bodyWeight, name: name)
    }
}
