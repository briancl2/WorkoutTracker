//
//  ExerciseDetailTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/6/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

protocol ExerciseDetailTableViewControllerDelegate {
    func save()
}

class ExerciseDetailTableViewController: UITableViewController {

    var exercise: Exercise!
    
    var exerciseDetails = [[String]]()
    var exerciseSections = [String]()

    override func viewWillAppear(animated: Bool) {
        displayExerciseDetail()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayExerciseDetail()
    }
    

    
    func displayExerciseDetail() {
        let currentWeights = exercise.currentWeights
        let warmup25Text = "Warmup (25%): \(String(currentWeights.warmup25)) \(exercise.getBarWeightsString(currentWeights.warmup25))"
        let warmup50Text = "Warmup (50%): \(String(currentWeights.warmup50)) \(exercise.getBarWeightsString(currentWeights.warmup50))"
        let heavyText = "Heavy (100%): \(String(currentWeights.heavy)) \(exercise.getBarWeightsString(currentWeights.heavy))"
        
        exerciseDetails = [[warmup25Text, warmup50Text, heavyText]]
        exerciseSections = ["Weights"]
    
    
        if let lastWorkouts = exercise.getLastWorkouts(3) {
            var workoutsToDisplay = [String]()
            for workout in lastWorkouts {
                workoutsToDisplay.append("\(workout.date.myPrettyString) Reps @\(workout.sets[0].weight): \(workout.sets[0].repCount) and \(workout.sets[1].repCount)")
                //workoutsToDisplay.append(" Reps @\(workout.sets[0].weight): \(workout.sets[0].repCount) and \(workout.sets[1].repCount)")
            }
            exerciseDetails.append(workoutsToDisplay)
            exerciseSections.append("Last Workouts")
            var stats: [String] = []
            if let totalVolumeIncrease = exercise.getTotalVolumeIncrease(15) {
                stats.append("15-day total volume increase: \(totalVolumeIncrease)%")
            }
            stats.append("Calculated 1RM: \(exercise.getCalculated1RM())lbs")
            stats.append("Goal Attainment: \(exercise.getGoalAttainment())% of \(exercise.goal) lbs")
            exerciseDetails.append(stats)
            exerciseSections.append("Stats")
        }
        
        if let notes = exercise.notes {
            exerciseDetails.append(["\(notes)"])
            exerciseSections.append("Notes")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return exerciseSections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exerciseDetails[section].count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ExerciseDetailCell", forIndexPath: indexPath) as! ExerciseDetailTableViewCell
        
        let exerciseDetailText = exerciseDetails[indexPath.section][indexPath.row]
        cell.textLabel?.text = exerciseDetailText

        // Configure the cell...

        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return exerciseSections[section]
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerFrame = tableView.frame
        
        var headerView:UIView = UIView(frame: CGRectMake(0, 0, headerFrame.size.width, headerFrame.size.height))
        //headerView.backgroundColor = UIColor(red: 108/255, green: 185/255, blue: 0/255, alpha: 0.9)
        
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        //title.font = UIFont.boldSystemFontOfSize(20.0)
        title.text = exerciseSections[section]
        //title.textColor = UIColor.whiteColor()
        headerView.addSubview(title)
        
        var headBttn: UIButton = UIButton(type: UIButtonType.System)
        headBttn.translatesAutoresizingMaskIntoConstraints = false
        headBttn.enabled = true
        headBttn.titleLabel?.text = "\(section)"
        headBttn.tag = section
        headBttn.addTarget(self, action: #selector(UIPushBehavior.addItem(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        headBttn.layer.cornerRadius = 5
        headBttn.layer.borderWidth = 1
        headBttn.layer.borderColor = UIColor.blackColor().CGColor
        headerView.addSubview(headBttn)
        
        var viewsDict = Dictionary <String, UIView>()
        viewsDict["title"] = title
        viewsDict["headBttn"] = headBttn
        
        headerView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-10-[title]-[headBttn]-15-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        
        headerView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|-[title]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        headerView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|-[headBttn]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        
        return headerView
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "RecordWorkout" {
            let recordWorkoutTableViewController = segue.destinationViewController as! RecordWorkoutTableViewController
            
            if let lastWorkout = exercise.getLastWorkout() {
                recordWorkoutTableViewController.workout = lastWorkout
            }

        }
    }
    
    @IBAction func unwindToExerciseDetail(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? RecordWorkoutTableViewController, newWorkout = sourceViewController.newWorkout {
            exercise.recordWorkout(newWorkout)
            save()
        }
    }
    
    var delegate: ExerciseDetailTableViewControllerDelegate?
    
    func save() {
        delegate?.save()
    }
    
}


