//
//  RecordWorkoutTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/6/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import AudioToolbox
import RealmSwift

final class RecordWorkoutTableViewController: UITableViewController, UITextFieldDelegate {

    // MARK: Outlets
    
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
    @IBOutlet weak var cancelButton: UIBarButtonItem!

    // MARK: Public Properties
    
    var newWorkout: Workout! // the new Workout to construct here and pass back to the unwind of the sender
    var workout: Workout! // passed from sender
    var exerciseName: String! // passed from sender
    
    // MARK: Private Properties
    
    private let timerEnd: NSTimeInterval = 90
    private var timerCounter: NSTimeInterval = 0
    private var myTimer: Timer!
    
    private var newDate: NSDate? {
        didSet {
            dateTextField.text = newDate!.myPrettyString
        }
    }
    
    private var newWeight: Int? {
        didSet {
            weightLabel.text = "\(newWeight!) lbs"
            checkValidExercise()
            self.tableView.reloadData() // update footer BarText
        }
    }
    
    private var newSetOne: Int? {
        didSet {
            setOneLabel.text = "Set 1: \(newSetOne!) reps"
        }
    }
    
    private var newSetTwo: Int? {
        didSet {
            setTwoLabel.text = "Set 2: \(newSetTwo!) reps"
        }
    }
   
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add \(exerciseName) Workout"

        
        dateTextField.delegate = self
        doneButton.enabled = false
        
        
        newDate = NSDate()
        
        if let lastWorkout = workout {
            newWeight = lastWorkout.weight
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
        setOneStepper.minimumValue = 1
        setOneStepper.maximumValue = 20
        setOneStepper.value = Double(newSetOne!)
        
        setTwoStepper.stepValue = 1
        setTwoStepper.minimumValue = 1
        setTwoStepper.maximumValue = 20
        setTwoStepper.value = Double(newSetTwo!)
        
        updateLabel(timerEnd)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RecordWorkoutTableViewController.applicationWillResignActive),name: UIApplicationWillResignActiveNotification, object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RecordWorkoutTableViewController.applicationDidBecomeActive),name: UIApplicationDidBecomeActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RecordWorkoutTableViewController.applicationDidBecomeActive),name: UIApplicationWillEnterForegroundNotification, object: nil)
        

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
        if let weight = newWeight where section == 1 {
            return Weight(weight: weight).barText
        }
        
        // last workout's reps
        if let workout = workout where section == 2 {
            return "Reps finished on \(workout.date.myPrettyString): \(workout.sets[0].repCount) and \(workout.sets[1].repCount) @ \(workout.weight)lbs"
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
    }

    // MARK: Helper Functions
    
    private func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    private func checkValidExercise() {
        if newWeight > 0 {
            doneButton.enabled = true
        } else {
            doneButton.enabled = false
        }
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
            
            cancelButton.enabled = false
            doneButton.enabled = false
            timerStartButton.enabled = false
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
        cancelButton.enabled = true
        doneButton.enabled = true
        timerStartButton.enabled = true
    }
    
    // MARK: Timer Storage
    
    private struct PropertyKey {
        static let timerCounterKey = "RecordWorkoutTableViewController_timeCount"
        static let timeMeasurementKey = "RecordWorkoutTableViewController_timeMeasurement"
    }
    
    private dynamic func applicationWillResignActive() {
        if myTimer?.running == true {
            saveDefaults()
        } else {
            clearDefaults()
        }
    }
    
    private dynamic func applicationDidBecomeActive() {
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
    
    // MARK: Actions
    
    @IBAction private func weightStepperChanged(sender: UIStepper) {
        newWeight = Int(sender.value)
        closeKeyboard()
    }
    
    @IBAction private func setOneStepperChanged(sender: UIStepper) {
        newSetOne = Int(sender.value)
        closeKeyboard()
    }

    @IBAction private func setTwoStepperChanged(sender: UIStepper) {
        newSetTwo = Int(sender.value)
        closeKeyboard()
    }
    
    @IBAction private func timerStartButtonTapped(sender: UIButton) {
        startTimer(timerEnd)
    }
    
    @IBAction private func timerResetButtonTapped(sender: UIButton) {
        myTimer?.stop(true)
        cancelAllNotifications()
        updateLabel(timerEnd)
    }
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender {
            if let date = newDate, weight = newWeight, setOne = newSetOne, setTwo = newSetTwo {
                let newSets = List<WorkSet>()
                newSets.append(WorkSet(weight: weight, repCount: setOne))
                newSets.append(WorkSet(weight: weight, repCount: setTwo))
                newWorkout = Workout(date: date, sets: newSets)
            }
            myTimer?.stop(true)
            cancelAllNotifications()
            clearDefaults()
        }
    }
}
