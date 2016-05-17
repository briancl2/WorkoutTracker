//
//  RecordWorkoutTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/6/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import AudioToolbox

class RecordWorkoutTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var setOneLabel: UILabel!
    @IBOutlet weak var setTwoLabel: UILabel!
    @IBOutlet weak var weightStepper: UIStepper!
    @IBOutlet weak var setOneStepper: UIStepper!
    @IBOutlet weak var setTwoStepper: UIStepper!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerStartButton: UIButton!
    @IBOutlet weak var timerResetButton: UIButton!

    var newWorkout: Workout? // the new Workout to construct here and pass back to the unwind of the sender
    var workout: Workout? // passed from sender
    var exerciseName: String? // passed from sender
    
    var newDate: NSDate? {
        didSet {
            dateTextField.text = newDate!.myPrettyString
        }
    }
    
    var newWeight: Int? {
        didSet {
            weightLabel.text = "\(newWeight!) lbs"
            checkValidExercise()
            self.tableView.reloadData() // update footer BarText
        }
    }
    
    var newSetOne: Int? {
        didSet {
            setOneLabel.text = "Set 1: \(newSetOne!) reps"
        }
    }
    
    var newSetTwo: Int? {
        didSet {
            setTwoLabel.text = "Set 2: \(newSetTwo!) reps"
        }
    }

    
    var timer = NSTimer()
    let timeInterval:NSTimeInterval = 0.01
    let timerEnd:NSTimeInterval = 90
    var timeCount:NSTimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add \(exerciseName!) Workout"
        dateTextField.delegate = self
        doneButton.enabled = false
        
        newDate = NSDate()
        
        if let lastWorkout = workout {
            newWeight = lastWorkout.sets[0].weight
            newSetOne = lastWorkout.sets[0].repCount
            newSetTwo = lastWorkout.sets[1].repCount
        } else {
            newWeight = 0
            newSetOne = 8
            newSetTwo = 8
        }
        
        weightStepper.stepValue = 5
        weightStepper.maximumValue = 995
        weightStepper.value = Double(newWeight!)
        
        setOneStepper.stepValue = 1
        setOneStepper.maximumValue = 20
        setOneStepper.value = Double(newSetOne!)
        
        setTwoStepper.stepValue = 1
        setTwoStepper.maximumValue = 20
        setTwoStepper.value = Double(newSetTwo!)
        
        resetTimeCount()
        timerLabel.text = timeString(timeCount)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RecordWorkoutTableViewController.applicationWillResignActive),name: UIApplicationWillResignActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RecordWorkoutTableViewController.applicationDidBecomeActive),name: UIApplicationDidBecomeActiveNotification, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    //  MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.maximumDate = NSDate()
        datePicker.datePickerMode = UIDatePickerMode.Date
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(RecordWorkoutTableViewController.datePickerChanged(_:)), forControlEvents: .ValueChanged)
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        newDate = sender.date
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // disable editing of date text.  datepicker input only
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    // MARK: Touch Events

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dateTextField.resignFirstResponder()
        closeKeyboard()
    }
    
    // MARK: tableView
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        // BarText under Weight
        if newWeight != nil && section == 1 {
            return BarText(weight: newWeight!).barText
        }
        
        // last workout's reps
        if workout != nil && section == 2 {
            return "Reps finished on \(workout!.date.myPrettyString): \(workout!.sets[0].repCount) and \(workout!.sets[1].repCount) @ \(workout!.sets[0].weight)lbs"
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
    }

    // MARK: Helper Functions
    
    func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    func checkValidExercise() {
        if newWeight > 0 {
            doneButton.enabled = true
        } else {
            doneButton.enabled = false
        }
    }
    
    // MARK: Timer
    
    func resetTimeCount(){
        timeCount = timerEnd
    }
    
    func timerDidEnd(timer: NSTimer){
        //timer that counts down
        timeCount = timeCount - timeInterval
        if timeCount <= 0 {  //test for target time reached.
            timerLabel.text = "Time is up!!"
            timer.invalidate()
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            cancelAllNotifications()
        } else { //update the time on the clock if not reached
            timerLabel.text = timeString(timeCount)
        }
    }
    
    func timeString(time: NSTimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = time - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%02i",minutes,Int(seconds),Int(secondsFraction * 100.0))
    }
    
    // MARK: Timer Storage
    
    struct PropertyKey {
        static let timeCountKey = "RecordWorkoutTableViewController_timeCount"
        static let timeMeasurementKey = "RecordWorkoutTableViewController_timeMeasurement"
    }
    
    dynamic private func applicationWillResignActive() {
        if !timer.valid {
            clearDefaults()
        } else {
            saveDefaults()
        }
    }
    
    dynamic private func applicationDidBecomeActive() {
        if timer.valid {
            loadDefaults()
        }
    }
    
    private func saveDefaults() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(timeCount, forKey: PropertyKey.timeCountKey)
        userDefault.setObject(NSDate().timeIntervalSince1970, forKey: PropertyKey.timeMeasurementKey)
    }
    
    private func clearDefaults() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.removeObjectForKey(PropertyKey.timeCountKey)
        userDefault.removeObjectForKey(PropertyKey.timeMeasurementKey)
    }
    
    private func loadDefaults() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        let restoredTimeCount = userDefault.objectForKey(PropertyKey.timeCountKey) as! Double
        let restoredTimeMeasurement = userDefault.objectForKey(PropertyKey.timeMeasurementKey) as! Double
        
        let timeDelta = NSDate().timeIntervalSince1970 - restoredTimeMeasurement
        timeCount = restoredTimeCount - timeDelta
    }
    
    // MARK: Notifications
    
    func schedulePushNotification() {
        let notification = UILocalNotification()
        notification.alertAction = "Go back to App"
        notification.alertBody = "The 90s timer is finished!"
        notification.fireDate = NSDate(timeIntervalSinceNow: timerEnd+1)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    func cancelAllNotifications() {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    // MARK: Actions
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func weightStepperChanged(sender: UIStepper) {
        newWeight = Int(sender.value)
        closeKeyboard()
    }
    
    @IBAction func setOneStepperChanged(sender: UIStepper) {
        newSetOne = Int(sender.value)
        closeKeyboard()
    }

    @IBAction func setTwoStepperChanged(sender: UIStepper) {
        newSetTwo = Int(sender.value)
        closeKeyboard()
    }
    
    @IBAction func timerStartButtonTapped(sender: UIButton) {
        if !timer.valid { //prevent more than one timer on the thread
            timerLabel.text = timeString(timeCount)
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self,selector: #selector(RecordWorkoutTableViewController.timerDidEnd(_:)),userInfo: nil, repeats: true)
            schedulePushNotification()
        }
    }
    
    @IBAction func timerResetButtonTapped(sender: UIButton) {
        timer.invalidate()
        resetTimeCount()
        timerLabel.text = timeString(timeCount)
        cancelAllNotifications()
    }
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender {
            let newSets = [Sets(weight: newWeight!, repCount: newSetOne!), Sets(weight: newWeight!, repCount: newSetTwo!)]

            // Set the meal to be passed to MealListTableViewController after the unwind segue.
            newWorkout = Workout(date: newDate!, sets: newSets)
            timer.invalidate()
            cancelAllNotifications()
            clearDefaults()
        }
    }



}
