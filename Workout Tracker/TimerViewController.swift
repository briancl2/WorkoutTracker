//
//  TimerViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/12/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import AudioToolbox

class TimerViewController: UIViewController {
    
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resetTimerButton: UIButton!
    
    private let timerEnd: NSTimeInterval = 90
    private var timerCounter: NSTimeInterval = 0
    
    var myTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        updateLabel(timerEnd)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TimerViewController.applicationWillResignActive),name: UIApplicationWillResignActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TimerViewController.applicationDidBecomeActive),name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Timer Handlers
    
    private func startTimer(length: NSTimeInterval, restart: Bool = false) {
        if myTimer?.running != true { // only proceed if myTimer? points to an object AND running is false
            myTimer = Timer(length: length)
            
            let started = myTimer.start({
                [weak self] leftTick in self!.updateLabel(leftTick)
                }, stopHandler: {
                    [weak self] finished in self!.showFinish(finished)
                })
            
            if started && !restart {
                updateLabel(timerEnd)
                schedulePushNotification()
            } else {
            }
        }
    }
    
    private func updateLabel(time: NSTimeInterval) {
        timerLabel.text = time.myPrettyString
        timerCounter = time
    }
    
    private func showFinish(finished: Bool) {
        if finished {
            timerLabel.text = "Time is up!!"
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            cancelAllNotifications()
        }
    }
    
    // MARK: Actions
    
    @IBAction func startTimerButtonTapped(sender: UIButton) {
        startTimer(timerEnd)

    }

    @IBAction func resetTimerButtonTapped(sender: UIButton) {
        myTimer?.stop(true)
        cancelAllNotifications()
        updateLabel(timerEnd)
    }
    
    // MARK: Timer Storage
    
    private struct PropertyKey {
        static let timerCounterKey = "TimerViewController_timerCounter"
        static let timeMeasurementKey = "TimerViewController_timeMeasurement"
    }
    
    dynamic private func applicationWillResignActive() {
        if myTimer?.running == true {
            saveDefaults()
        } else {
            clearDefaults()
        }
    }
    
    dynamic private func applicationDidBecomeActive() {
        if myTimer?.running == true {
            loadDefaults()
            myTimer.stop(true)
            startTimer(timerCounter, restart: true)
        }
    }
    
    private func saveDefaults() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(timerCounter, forKey: PropertyKey.timerCounterKey)
        userDefault.setObject(NSDate().timeIntervalSince1970, forKey: PropertyKey.timeMeasurementKey)
    }
    
    private func clearDefaults() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.removeObjectForKey(PropertyKey.timerCounterKey)
        userDefault.removeObjectForKey(PropertyKey.timeMeasurementKey)
    }
    
    private func loadDefaults() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        let restoredTimerCounter = userDefault.objectForKey(PropertyKey.timerCounterKey) as! Double
        let restoredTimeMeasurement = userDefault.objectForKey(PropertyKey.timeMeasurementKey) as! Double
        let timeDelta = NSDate().timeIntervalSince1970 - restoredTimeMeasurement
        
        timerCounter = restoredTimerCounter - timeDelta
    }
    
    // MARK: Notifications
    
    private func schedulePushNotification() {
        let notification = UILocalNotification()
        notification.alertAction = "Go back to App"
        notification.alertBody = "The 90s timer is finished!"
        notification.fireDate = NSDate(timeIntervalSinceNow: timerEnd+1)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)

    }
    
    private func cancelAllNotifications() {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
}
