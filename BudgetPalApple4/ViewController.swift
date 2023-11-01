//
//  ViewController.swift
//  BudgetPalApple4
//
//  Created by Saanvi Ibrahimpatnam on 10/22/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var weeklyBudgetAmount: UITextField!
    @IBOutlet var currentBudgetLabel: UILabel!
    @IBOutlet var currentBudgetAmount: UILabel!
    @IBOutlet var weeklyBudgetLabel: UILabel!
    @IBOutlet var transactionTable: UITableView!

    var transactions: [Transaction] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register the cell for the table view
        transactionTable.register(UITableViewCell.self, forCellReuseIdentifier: "transactionCell")
        transactionTable.delegate = self
        transactionTable.dataSource = self
        
        // Add a target-action to the weeklyBudgetAmount text field
        weeklyBudgetAmount.addTarget(self, action: #selector(weeklyBudgetChanged), for: .editingChanged)
    }

    @IBAction func setWeeklyBudget(_ sender: UIButton) {
        if let weeklyBudgetText = weeklyBudgetAmount.text, let weeklyBudget = Double(weeklyBudgetText) {
            currentBudgetAmount.text = String(format: "%.2f", weeklyBudget)
        }
    }

    @IBAction func addMoney(_ sender: UIButton) {
        showTransactionPopup(isExpense: false)
    }

    @IBAction func logExpenses(_ sender: UIButton) {
        showTransactionPopup(isExpense: true)
    }
    
    @objc func weeklyBudgetChanged() {
            if let weeklyBudgetText = weeklyBudgetAmount.text, let weeklyBudget = Double(weeklyBudgetText) {
                currentBudgetAmount.text = String(format: "%.2f", weeklyBudget)
            }
        }


    func showTransactionPopup(isExpense: Bool) {
        let alertController = UIAlertController(title: isExpense ? "Log Expense" : "Add Money", message: nil, preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.placeholder = "Amount"
            textField.keyboardType = .decimalPad
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Category"
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            if let amountText = alertController.textFields?[0].text,
               let name = alertController.textFields?[1].text,
               let category = alertController.textFields?[2].text,
               let amount = Double(amountText) {

                let transaction = Transaction(amount: amount, name: name, category: category, isExpense: isExpense, date: Date())
                self?.transactions.append(transaction)
                self?.transactionTable.reloadData()

                if isExpense {
                    self?.updateCurrentBudget(with: -amount)
                } else {
                    self?.updateCurrentBudget(with: amount)
                }
            }
        })

        self.present(alertController, animated: true, completion: nil)
    }

    func updateCurrentBudget(with amount: Double) {
        if let currentBudgetText = currentBudgetAmount.text, let currentBudget = Double(currentBudgetText) {
            let updatedBudget = currentBudget + amount
            currentBudgetAmount.text = String(format: "%.2f", updatedBudget)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath)
//        let transaction = transactions[indexPath.row]
//        cell.textLabel?.text = "\(transaction.isExpense ? "-" : "+") \(transaction.amount) (\(transaction.name), \(transaction.category))"
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath)
        let transaction = transactions[indexPath.row]

        let amountText: String
        if transaction.isExpense {
            cell.textLabel?.textColor = UIColor.red
            amountText = "-\(transaction.amount)"
        } else {
            cell.textLabel?.textColor = UIColor.green
            amountText = "+\(transaction.amount)"
        }

        cell.textLabel?.text = "\(amountText) (\(transaction.name), \(transaction.category))"
        return cell
    }

}

struct Transaction {
    let amount: Double
    let name: String
    let category: String
    let isExpense: Bool
    let date: Date
}
