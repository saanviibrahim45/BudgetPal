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

    var expenseCategories: [String] = []
            var expenseValues: [Double] = []

            override func viewDidLoad() {
                super.viewDidLoad()
                customizeBarChart()
                updateChartData()
            }

            func customizeBarChart() {
                barChartView.chartDescription.text = "Expense Categories"
                barChartView.xAxis.labelPosition = .bottom
            }

            func updateChartData() {
                var dataEntries: [BarChartDataEntry] = []

                for i in 0..<expenseValues.count {
                    let entry = BarChartDataEntry(x: Double(i), y: expenseValues[i])
                    dataEntries.append(entry)
                }

                let dataSet = BarChartDataSet(entries: dataEntries, label: "Expense Categories")
                dataSet.valueFont = UIFont.systemFont(ofSize: 12)
                
                barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: expenseCategories)
                barChartView.xAxis.labelRotationAngle = -90

                dataSet.colors = ChartColorTemplates.vordiplom()

                let data = BarChartData(dataSet: dataSet)
                barChartView.data = data
            }
        }

