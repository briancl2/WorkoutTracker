//
//  Weight.swift
//  Workout Tracker
//
//  Created by briancl on 5/13/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation



struct Weight {
    let value: Int
    var barText: String {
        return BarText(weight: value).barText
    }
    
    init(value: Int) {
        self.value = value.roundedToFive
    }
    
}