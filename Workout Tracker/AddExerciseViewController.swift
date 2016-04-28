//
//  AddExerciseViewController.swift
//  Workout Tracker
//
//  Created by briancl on 4/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

class AddExerciseViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var exercise: Exercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.enabled = false

        exerciseNameTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidExerciseName()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        doneButton.enabled = false
    }
    
    func checkValidExerciseName() {
        // Disable the Done button if the text field is empty.
        let text = exerciseNameTextField.text ?? ""
        doneButton.enabled = !text.isEmpty
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddExerciseMode = presentingViewController is UINavigationController
        
        if isPresentingInAddExerciseMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }

    // MARK: - Navigation

    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender {
            let name = exerciseNameTextField.text ?? ""
            let notes = "test form notes"
            let weight = 135
            
            // Set the meal to be passed to MealListTableViewController after the unwind segue.
            exercise = Exercise(name: name, notes: notes, workoutDiary: WorkoutDiary(diary: nil), weight: weight)
        }
    }

}
