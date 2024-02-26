//
//  Analytics.swift
//  BudgetPalApple4
//
//  Created by Saanvi Ibrahimpatnam on 11/17/23.
//

import UIKit
import DGCharts

class Analytics: UIViewController {

    // IBOutlet for the BarChartView
    @IBOutlet weak var barChartView: BarChartView!

    // Sample data for expenses (replace this with your actual data)
        let expenseCategories = ["Food", "Clothing", "Entertainment", "Transportation", "Savings", "Education", "Bills", "Emergencies"]
        let expenseValues = [200.0, 300.0, 150.0, 400.0, 200.0, 100.0,150.0, 50.0]

        override func viewDidLoad() {
            super.viewDidLoad()

            // Set up the bar chart
            customizeBarChart()

            // Update the chart data
            updateChartData()
        }

        func customizeBarChart() {
            // Customize the appearance of the bar chart (optional)
            barChartView.chartDescription.text = "Expense Categories"
            barChartView.xAxis.labelPosition = .bottom
            // Add more customization as needed
        }

        func updateChartData() {
            // Create an array of BarChartDataEntry objects based on expense values
            var dataEntries: [BarChartDataEntry] = []

            for i in 0..<expenseValues.count {
                let entry = BarChartDataEntry(x: Double(i), y: expenseValues[i])
                dataEntries.append(entry)
            }

            // Create a BarChartDataSet with the data entries
            let dataSet = BarChartDataSet(entries: dataEntries, label: " ")
            
            // Add labels for each expense category to the legend
                dataSet.valueFont = UIFont.systemFont(ofSize: 12) // Set label text font
            
            // Set labels for x-axis (expense categories)
            barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: expenseCategories)
            barChartView.xAxis.labelRotationAngle = -90 // Rotate labels vertically

            // Customize the appearance of the data set (colors, etc.)
            dataSet.colors = ChartColorTemplates.vordiplom()

            // Create a BarChartData object with the data set
            let data = BarChartData(dataSet: dataSet)

            // Set data to the bar chart view
            barChartView.data = data
        }
    }
     
