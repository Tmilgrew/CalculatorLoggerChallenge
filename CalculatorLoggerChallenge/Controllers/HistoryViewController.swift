//
//  HistoryViewController.swift
//  CalculatorInterviewChallenge
//
//  Created by Thomas Milgrew on 9/10/20.
//  Copyright © 2020 Thomas Milgrew. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class HistoryViewController: UIViewController {

    let db = Firestore.firestore()
    var calculationHistory = [Calculation]()

    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in view did load")
        // Do any additional setup after loading the view.
        historyTableView.delegate = self
        historyTableView.dataSource = self
        updateCalculations()
    }
    
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let accessControleNavigationController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.accessControleNavigationController) as? AccessControlNavigationController
            view.window?.rootViewController = accessControleNavigationController
            view.window?.makeKeyAndVisible()
        } catch let error {
            print("Error with sign out: ", error)
        }
    }
    
    private func updateCalculations () {
        db.collection("calculationLogs").order(by: "logged_at", descending: true).limit(to: 10).addSnapshotListener { (querySnapShot, error) in
            guard let documents = querySnapShot?.documents else {
                print("Error fetching snapshots: ", error ?? "Error listening to calculations")
                return
            }
            self.calculationHistory = []
            print("The documents are: ", documents)
            for document in documents {
                print("\(document.documentID) => \(document.data())")
                let title = document.get("log_message") as! String
                let timeStamp = document.get("logged_at") as! String
                self.calculationHistory.append(Calculation(message: title, time: timeStamp))
            }
            self.historyTableView.reloadData()
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculationHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "historylog", for: indexPath)
        if calculationHistory.count == 0 {
            cell.textLabel?.text = "There are no calculations made"
        } else {
            let calculation = calculationHistory[indexPath.row]
            cell.textLabel?.text = calculation.logMessage
        }
        return cell
    }
    
    
}
