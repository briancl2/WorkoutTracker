//
//  Weight.swift
//  Workout Tracker
//
//  Created by briancl on 5/13/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

struct Weight {
    
    // MARK: Public Properties
    
    let actual: Int
    var rounded: Int {
        return actual.roundedToFive
    }
    
    var barText: String {
        if rounded == 0 {
            return ""
        }
        
        let barWeight = 45
        var plates = [(45, 0), (35, 0), (25, 0), (10, 0), (5,0), (2.5, 0)]
        var tmp = Double(rounded - barWeight)
        
        for i in 0...plates.count-1 {
            while (tmp / plates[i].0 >= 2) {
                tmp -= (plates[i].0 * 2)
                plates[i].1 += 2
            }
        }
        return plates.filter({$0.1 > 0}).reduce("Bar", combine: { $0 + " + \($1.1)x\($1.0.trimmedToString)" })
    }
}