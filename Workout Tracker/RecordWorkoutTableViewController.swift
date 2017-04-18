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
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


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
    var recordWorkoutViewModel: RecordWorkoutViewModel!
    
    // MARK: Private Properties
    
    fileprivate let timerEnd: TimeInterval = 90
    fileprivate var timerCounter: TimeInterval = 0
    fileprivate var myTimer: Timer!
    
    fileprivate var newDate: Date? {
        didSet {
            dateTextField.text = newDate!.myPrettyString
        }
    }
    
    fileprivate var newWeight: Int? {
        didSet {
            weightLabel.text = "\(newWeight!) lbs"
            checkValidExercise()
            self.tableView.reloadData() // update footer BarText
        }
    }
    
    fileprivate var newSetOne: Int? {
        didSet {
            setOneLabel.text = "Set 1: \(newSetOne!) reps"
        }
    }
    
    fileprivate var newSetTwo: Int? {
        didSet {
            setTwoLabel.text = "Set 2: \(newSetTwo!) reps"
        }
    }
   
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add \(recordWorkoutViewModel.exerciseName) Workout"

        dateTextField.delegate = self
        doneButton.isEnabled = false
        
        initializeLabels()
        configureViews()
        
        updateLabel(timerEnd)
        NotificationCenter.default.addObserver(self, selector: #selector(RecordWorkoutTableViewController.applicationWillResignActive),name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RecordWorkoutTableViewController.applicationDidBecomeActive),name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //  MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(RecordWorkoutTableViewController.datePickerChanged(_:)), for: .valueChanged)
    }
    
    func datePickerChanged(_ sender: UIDatePicker) {
        newDate = sender.date
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // disable editing of date text.  datepicker input only
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    // MARK: Touch Events

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dateTextField.resignFirstResponder()
        closeKeyboard()
    }
    
    // MARK: tableView
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        // BarText under Weight
        if let weight = newWeight, section == 1 {
            return Weight(weight: weight).barText
        }
        
        // last workout's reps
        if let lastWorkout = recordWorkoutViewModel.lastWorkout, section == 2 {
            return "Reps finished on \(lastWorkout.date.myPrettyString): \(lastWorkout.sets[0].repCount) and \(lastWorkout.sets[1].repCount) @ \(lastWorkout.weight)lbs"
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    }

    // MARK: Helper Functions
    
    fileprivate func initializeLabels() {
        newDate = Date()
        newWeight = recordWorkoutViewModel.lastWorkout?.weight ?? 0
        newSetOne = recordWorkoutViewModel.lastWorkout?.sets[0].repCount ?? 8
        newSetTwo = recordWorkoutViewModel.lastWorkout?.sets[1].repCount ?? 8
    }
    
    fileprivate func configureViews() {
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
    }
    
    fileprivate func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    fileprivate func checkValidExercise() {
        if newWeight > 0 {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
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
            }
            
            cancelButton.isEnabled = false
            doneButton.isEnabled = false
            timerStartButton.isEnabled = false
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
        cancelButton.isEnabled = true
        doneButton.isEnabled = true
        timerStartButton.isEnabled = true
    }
    
    // MARK: Timer Storage
    
    fileprivate dynamic func applicationWillResignActive() {
        if myTimer?.running == true {
            recordWorkoutViewModel.saveDefaults(timerCounter)
        } else {
            recordWorkoutViewModel.clearDefaults()
        }
    }
    
    fileprivate dynamic func applicationDidBecomeActive() {
        if myTimer?.running == true {
            timerCounter = recordWorkoutViewModel.loadDefaults()
            myTimer.stop(true)
            startTimer(timerCounter, restart: true)
        }
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
    
    // MARK: Actions
    
    @IBAction fileprivate func weightStepperChanged(_ sender: UIStepper) {
        newWeight = Int(sender.value)
        closeKeyboard()
    }
    
    @IBAction fileprivate func setOneStepperChanged(_ sender: UIStepper) {
        newSetOne = Int(sender.value)
        closeKeyboard()
    }

    @IBAction fileprivate func setTwoStepperChanged(_ sender: UIStepper) {
        newSetTwo = Int(sender.value)
        closeKeyboard()
    }
    
    @IBAction fileprivate func timerStartButtonTapped(_ sender: UIButton) {
        startTimer(timerEnd)
    }
    
    @IBAction fileprivate func timerResetButtonTapped(_ sender: UIButton) {
        myTimer?.stop(true)
        cancelAllNotifications()
        updateLabel(timerEnd)
    }
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if doneButton === sender as AnyObject? {
            if let date = newDate, let weight = newWeight, let setOne = newSetOne, let setTwo = newSetTwo {
                let newSets = List<WorkSet>()
                newSets.append(WorkSet(weight: weight, repCount: setOne))
                newSets.append(WorkSet(weight: weight, repCount: setTwo))
                newWorkout = Workout(date: date, sets: newSets)
            }
            myTimer?.stop(true)
            cancelAllNotifications()
            recordWorkoutViewModel.clearDefaults()
        }
    }
}
