//
//  Timer.swift
//  Workout Tracker
//
//  Created by briancl on 5/16/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

final class Timer {
    
    // MARK: Public Properties
    
    var running: Bool {
        return timer.isValid
    }
    
    // MARK: Private properties
    
    fileprivate let timeInterval: TimeInterval = 0.01
    fileprivate var timerEnd: TimeInterval = 90
    fileprivate var timer = Foundation.Timer()
    
    fileprivate var timeLeft: TimeInterval = 0 {
        didSet {
            if timeLeft < 0 {
                timeLeft = 0
            }
        }
    }
    
    fileprivate var timerTickHandler: ((TimeInterval) -> ())? // function to update the timer each tick, e.g., draw a label
    fileprivate var timerStopHandler: ((Bool) -> ())? // function to call when timer is ended (Bool argument determines if timer finished or if it was interrupted
    
    // MARK: Initializers
    
    init(length: TimeInterval) {
        self.timeLeft = length
    }
    
}

extension Timer {

    // MARK: Public Methods
    
    func start(_ updateTick: @escaping ((TimeInterval) -> Void), stopHandler: @escaping ((Bool) -> Void)) -> Bool {
        if running {
            return false
        }
        timerTickHandler = updateTick
        timerStopHandler = stopHandler
        timer = Foundation.Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(Timer.countTick), userInfo: nil, repeats: true)
        
        return running
    }
    
    func stop(_ interrupted: Bool) { // interrupted means stop() was called before the timer ended
        timer.invalidate()
        
        if let stopHandler = timerStopHandler {
            stopHandler(!interrupted)
        }
        timerStopHandler = nil
        timerTickHandler = nil
    }
    
}

private extension Timer {
    
    // MARK: Private Methods
    
    dynamic func countTick() {
        timeLeft = timeLeft - timeInterval
        if let tickHandler = timerTickHandler {
            tickHandler(timeLeft)
        }
        
        if timeLeft <= 0 { // time is up
            stop(false)
        }
    }
    
}
