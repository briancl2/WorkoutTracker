//
//  StatsViewController.swift
//  Workout Tracker
//
//  Created by briancl on 6/1/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import Charts

final class StatsViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var lineChartView: LineChartView!
    
    var statsViewModel: StatsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = statsViewModel.exercise.name // back button has exercise name in it
        self.lineChartView.delegate = self
        self.lineChartView.chartDescription?.text = statsViewModel.statsDescription
        self.lineChartView.chartDescription?.textColor = UIColor.white
//        self.lineChartView.gridBackgroundColor = UIColor.yellowColor().colorWithAlphaComponent(0.5)
        self.lineChartView.noDataText = "No Data Available"
        setChartData(data: statsViewModel.workoutDates)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChartData(data: ([String], [Double?])) {
        // 1 - creating an array of data entries
        let xVals = data.0
        let yVals = data.1
        
        var values = [ChartDataEntry]()
        for i in 0 ..< xVals.count {
            if let value = yVals[i] {
                // values.append(ChartDataEntry(x: value, y: Double(i)))
                values.append(ChartDataEntry(x: Double(i), y: value))
            }
        }
        
        // 2 - create a data set with our array
        let dataSet: LineChartDataSet = LineChartDataSet(values: values, label: nil)
        dataSet.axisDependency = .left // Line will correlate with left axis values
        dataSet.setColor(UIColor(red:0.502, green:0.580, blue:0.784, alpha:1.000))
        dataSet.lineWidth = 2.0
        dataSet.fillAlpha = 1 //65 / 255.0
        dataSet.fillColor = UIColor(red:0.502, green:0.580, blue:0.784, alpha:1.000)
        dataSet.highlightColor = UIColor.white
        dataSet.drawValuesEnabled = false
        dataSet.circleRadius = 3
        dataSet.circleHoleRadius = 0
        dataSet.setCircleColor(UIColor.darkGray)
        dataSet.drawCirclesEnabled = true
        dataSet.drawFilledEnabled = true
        
        
        //3 - create an array to store our LineChartDataSets
        var dataSets = [IChartDataSet]()
        dataSets.append(dataSet)
        
        //4 - pass our months in for our x-axis label value along with our dataSets
        let data = LineChartData(dataSets: dataSets)
        data.setValueTextColor(UIColor.white)

        let legend = lineChartView.legend
        legend.enabled = false
        
        let xAxis = lineChartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.labelPosition = .bottom
        
        let rightAxis = lineChartView.rightAxis
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawLabelsEnabled = false
        rightAxis.drawGridLinesEnabled = false
        
        let leftAxis = lineChartView.leftAxis
        leftAxis.drawAxisLineEnabled = false
        leftAxis.gridColor = UIColor.black.withAlphaComponent(0.1)
        leftAxis.gridLineWidth = 2

        
        //5 - finally set our data
        self.lineChartView.data = data
    }



}
