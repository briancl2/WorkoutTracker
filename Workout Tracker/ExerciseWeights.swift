//
//  ExerciseWeights.swift
//  Workout Tracker
//
//  Created by briancl on 7/9/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

struct ExerciseWeights {
    
    // MARK: Public Properties
    
    let heavy: Weight
    var warmup25: Weight {
        return Weight(weight: Int(Double(heavy.weight) * 0.25))
    }
    var warmup50: Weight {
        return Weight(weight: Int(Double(heavy.weight) * 0.50))
    }
    
    // MARK: Initializers
    
    init(weight: Int) {
        self.heavy = Weight(weight: weight)
    }
    
}