//
//  TimerViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/12/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import AudioToolbox

final class TimerViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resetTimerButton: UIButton!
    
    // MARK: Public Properties
    
    var myTimer: Timer!
    
    // MARK: Private Properties
    
    fileprivate let timerEnd: TimeInterval = 90
    fileprivate var timerCounter: TimeInterval = 0
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        updateLabel(timerEnd)

        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.applicationWillResignActive),name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.applicationDidBecomeActive),name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Timer Handlers
    
    fileprivate func startTimer(_ length: TimeInterval, restart: Bool = false) {
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
    
    fileprivate func updateLabel(_ time: TimeInterval) {
        timerLabel.text = time.myPrettyString
        timerCounter = time
    }
    
    fileprivate func showFinish(_ finished: Bool) {
        if finished {
            timerLabel.text = "Time is up!!"
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            cancelAllNotifications()
        }
    }
    
    // MARK: Actions
    
    @IBAction func startTimerButtonTapped(_ sender: UIButton) {
        startTimer(timerEnd)

    }

    @IBAction func resetTimerButtonTapped(_ sender: UIButton) {
        myTimer?.stop(true)
        cancelAllNotifications()
        updateLabel(timerEnd)
    }
    
    // MARK: Timer Storage
    
    fileprivate struct PropertyKey {
        static let timerCounterKey = "TimerViewController_timerCounter"
        static let timeMeasurementKey = "TimerViewController_timeMeasurement"
    }
    
    dynamic fileprivate func applicationWillResignActive() {
        if myTimer?.running == true {
            saveDefaults()
        } else {
            clearDefaults()
        }
    }
    
    dynamic fileprivate func applicationDidBecomeActive() {
        if myTimer?.running == true {
            loadDefaults()
            myTimer.stop(true)
            startTimer(timerCounter, restart: true)
        }
    }
    
    fileprivate func saveDefaults() {
        let userDefault = UserDefaults.standard
        userDefault.set(timerCounter, forKey: PropertyKey.timerCounterKey)
        userDefault.set(Date().timeIntervalSince1970, forKey: PropertyKey.timeMeasurementKey)
    }
    
    fileprivate func clearDefaults() {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: PropertyKey.timerCounterKey)
        userDefault.removeObject(forKey: PropertyKey.timeMeasurementKey)
    }
    
    fileprivate func loadDefaults() {
        let userDefault = UserDefaults.standard
        let restoredTimerCounter = userDefault.object(forKey: PropertyKey.timerCounterKey) as! Double
        let restoredTimeMeasurement = userDefault.object(forKey: PropertyKey.timeMeasurementKey) as! Double
        let timeDelta = Date().timeIntervalSince1970 - restoredTimeMeasurement
        
        timerCounter = restoredTimerCounter - timeDelta
    }
    
    // MARK: Notifications
    
    fileprivate func schedulePushNotification() {
        let notification = UILocalNotification()
        notification.alertAction = "Go back to App"
        notification.alertBody = "The 90s timer is finished!"
        notification.fireDate = Date(timeIntervalSinceNow: timerEnd+1)
        UIApplication.shared.scheduleLocalNotification(notification)

    }
    
    fileprivate func cancelAllNotifications() {
        UIApplication.shared.cancelAllLocalNotifications()
    }
    
}
