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
    
    var timer = NSTimer() //make a timer variable, but do do anything yet
    let timeInterval:NSTimeInterval = 0.05
    let timerEnd:NSTimeInterval = 90
    var timeCount:NSTimeInterval = 0.0
    
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startTimerButtonTapped(sender: UIButton) {
        backgroundTaskIdentifier = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({
            UIApplication.sharedApplication().endBackgroundTask(self.backgroundTaskIdentifier!)
        })
        
        if !timer.valid { //prevent more than one timer on the thread
            timerLabel.text = timeString(timeCount)
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval,
                                                           target: self,
                                                           selector: #selector(TimerViewController.timerDidEnd(_:)),
                                                           userInfo: "Time is up!!",
                                                           repeats: true) //repeating timer in the second iteration
        }
        
    }
    
    @IBAction func resetTimerButtonTapped(sender: UIButton) {
        timer.invalidate()
        resetTimeCount()
        timerLabel.text = timeString(timeCount)
    }
    
    func resetTimeCount(){
        timeCount = timerEnd
    }
    
    func timeString(time:NSTimeInterval) -> String {
        let minutes = Int(time) / 60
        //let seconds = Int(time) % 60
        let seconds = time - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%02i",minutes,Int(seconds),Int(secondsFraction * 100.0))
    }
    
    func timerDidEnd(timer:NSTimer){
        //timerLabel.text = timer.userInfo as? String
        //timer that counts down
        timeCount = timeCount - timeInterval
        if timeCount <= 0 {  //test for target time reached.
            timerLabel.text = "Time is up!!"
            timer.invalidate()
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            //pushNotification()
        } else { //update the time on the clock if not reached
            timerLabel.text = timeString(timeCount)
        }
        
    }
//    
//    func pushNotification() {
//        let notification = UILocalNotification()
//        notification.alertAction = "Go back to App"
//        notification.alertBody = "This is a Notification!"
//        notification.fireDate = NSDate(timeIntervalSinceNow: 1)
//        UIApplication.sharedApplication().scheduleLocalNotification(notification)
//    }
//    

}
