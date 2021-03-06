//
//  StatsViewController.swift
//  Workout Tracker
//
//  Created by briancl on 6/1/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import Charts

class StatsViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var lineChartView: LineChartView!
    
    var statsViewModel: StatsViewModel!
    
    let months = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]

    
    let dollars1 = [1453.0,2352,5431,1442,5451,6486,1173,5678,9234,1345,9411,2212]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lineChartView.delegate = self
        self.lineChartView.descriptionText = "Total Volume"
        self.lineChartView.descriptionTextColor = UIColor.whiteColor()
//        self.lineChartView.gridBackgroundColor = UIColor.yellowColor().colorWithAlphaComponent(0.5)
        self.lineChartView.noDataText = "No Data Available"
        setChartData((statsViewModel.workoutDates, statsViewModel.totalVolumes))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChartData(data: ([String], [Double])) {
        // 1 - creating an array of data entries
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0 ..< data.0.count {
            yVals1.append(ChartDataEntry(value: data.1[i], xIndex: i))
        }
        
        // 2 - create a data set with our array
        let set1: LineChartDataSet = LineChartDataSet(yVals: yVals1, label: nil)
        set1.axisDependency = .Left // Line will correlate with left axis values
        //set1.setColor(UIColor.redColor().colorWithAlphaComponent(1.0)) // our line's opacity is 50%
        set1.setColor(UIColor(red:0.502, green:0.580, blue:0.784, alpha:1.000))
        set1.lineWidth = 2.0
        set1.fillAlpha = 1 //65 / 255.0
        set1.fillColor = UIColor(red:0.502, green:0.580, blue:0.784, alpha:1.000)
        set1.highlightColor = UIColor.whiteColor()
//        set1.drawCubicEnabled = true
//        set1.cubicIntensity = 0.05
        set1.drawValuesEnabled = false
        set1.drawCirclesEnabled = false
        set1.drawFilledEnabled = true
        
        
        //3 - create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        
        //4 - pass our months in for our x-axis label value along with our dataSets
        let data: LineChartData = LineChartData(xVals: data.0, dataSets: dataSets)
        data.setValueTextColor(UIColor.whiteColor())

        let legend = lineChartView.legend
        legend.enabled = false
        
        let xAxis = lineChartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.labelPosition = .Bottom
        //xAxis.gridColor = UIColor.blackColor().colorWithAlphaComponent(0.1)
        
        let rightAxis = lineChartView.rightAxis
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawLabelsEnabled = false
        rightAxis.drawGridLinesEnabled = false
        
        let leftAxis = lineChartView.leftAxis
        leftAxis.drawAxisLineEnabled = false
        leftAxis.gridColor = UIColor.blackColor().colorWithAlphaComponent(0.1)
        leftAxis.gridLineWidth = 2

        
        //5 - finally set our data
        self.lineChartView.data = data
    }



}
