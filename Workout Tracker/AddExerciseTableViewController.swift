//
//  AddExerciseTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/8/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import RealmSwift

final class AddExerciseTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var notesTextVIew: UITextView!

    // MARK: Public Properties
    
    var exercise: Exercise!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.enabled = false
        nameTextField.delegate = self
        goalTextField.delegate = self

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
    
    // MARK: Helper Functions
    
    private func checkValidExerciseName() {
        // Disable the Done button if the text field is empty.
        let text = nameTextField.text ?? ""
        let goal = Int(goalTextField.text ?? "0")
        doneButton.enabled = !text.isEmpty && goal > 0
    }

    // MARK: Actions
   
    // MARK: - Navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender {
            let name = nameTextField.text ?? ""
            let notes = notesTextVIew.text ?? ""
            let goal = Int(goalTextField.text ?? "200")!
            
            // Set the meal to be passed to MealListTableViewController after the unwind segue.
            exercise = Exercise(name: name, notes: notes, workoutDiary: List<Workout>(), goal: goal)
        }
    }

}
