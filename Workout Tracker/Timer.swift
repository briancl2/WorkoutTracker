//
//  Timer.swift
//  Workout Tracker
//
//  Created by briancl on 5/16/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

class Timer {
    
    // MARK: Private properties
    
    private let timeInterval: NSTimeInterval = 0.01
    private var timerEnd: NSTimeInterval = 90
    private var timer = NSTimer()
    
    private var timeLeft: NSTimeInterval = 0 {
        didSet {
            if timeLeft < 0 {
                timeLeft = 0
            }
        }
    }
    
    private var timerTickHandler: (NSTimeInterval -> ())? // function to update the timer each tick, e.g., draw a label
    private var timerStopHandler: (Bool -> ())? // function to call when timer is ended (Bool argument determines if timer finished or if it was interrupted
    
    // MARK: Public Properties
    
    var running: Bool {
        return timer.valid
    }
    
    // MARK: Initializers
    
    init(length: NSTimeInterval) {
        self.timeLeft = length
    }

    // MARK: Public Methods
    
    func start(updateTick: (NSTimeInterval -> Void), stopHandler: (Bool -> Void)) -> Bool {
        if running {
            return false
        }
        timerTickHandler = updateTick
        timerStopHandler = stopHandler
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: #selector(Timer.countTick), userInfo: nil, repeats: true)
        
        return running
    }
    
    func stop(interrupted: Bool) { // interrupted means stop() was called before the timer ended
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
    
    dynamic private func countTick() {
        timeLeft = timeLeft - timeInterval
        if let tickHandler = timerTickHandler {
            tickHandler(timeLeft)
        }
        
        if timeLeft <= 0 { // time is up
            stop(false)
        }
    }
}