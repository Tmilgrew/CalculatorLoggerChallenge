//
//  CalculatorViewController.swift
//  CalculatorInterviewChallenge
//
//  Created by Thomas Milgrew on 9/9/20.
//  Copyright © 2020 Thomas Milgrew. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class CalculatorViewController: UIViewController {

    @IBOutlet weak var equationLabel: UILabel!
    
    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var performingMath = false
    var operation = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        if performingMath == true {
            equationLabel.text = String(sender.tag - 1)
            numberOnScreen = Double(equationLabel.text!)!
            performingMath = false
        } else {
            if equationLabel.text == "0" {
                equationLabel.text = String(sender.tag - 1)
                numberOnScreen = Double(equationLabel.text!)!
            }else {
                equationLabel.text = equationLabel.text! + String(sender.tag - 1)
                numberOnScreen = Double(equationLabel.text!)!
            }
            
        }
    }

    @IBAction func buttons(_ sender: UIButton) {
        if equationLabel.text != "" && sender.tag != 11 && sender.tag != 16 {
            previousNumber = Double(equationLabel.text!)!
            
            if sender.tag == 12 {
                equationLabel.text = "/"
            }
            if sender.tag == 13 {
                equationLabel.text = "x"
            }
            if sender.tag == 14 {
                equationLabel.text = "-"
            }
            if sender.tag == 15 {
                equationLabel.text = "+"
            }
            operation = sender.tag
            performingMath = true
            
        } else if sender.tag == 16 {
            if operation == 12 {
                equationLabel.text = String(previousNumber / numberOnScreen)
                let userEmail = Auth.auth().currentUser?.email ?? "An Anonymous user"
                let logMessage = "\(String(describing: userEmail)) entered the equation \(previousNumber) / \(numberOnScreen) = \(previousNumber / numberOnScreen)"
                let db = Firestore.firestore()
                let date = Date()
                let dataParams = [
                    "log_message": logMessage,
                    "logged_at": "\(date)"
                ]
                db.collection("calculationLogs").addDocument(data: dataParams) { (error) in
                    if error != nil {
                        self.showError("Data Saving Error","Error saving user data")
                    }
                }
            } else if operation == 13 {
                equationLabel.text = String(previousNumber * numberOnScreen)
                let userEmail = Auth.auth().currentUser?.email ?? "An Anonymous user"
                let logMessage = "\(String(describing: userEmail)) entered the equation \(previousNumber) * \(numberOnScreen) = \(previousNumber * numberOnScreen)"
                let db = Firestore.firestore()
                let date = Date()
                let dataParams = [
                    "log_message": logMessage,
                    "logged_at": "\(date)"
                ]
                db.collection("calculationLogs").addDocument(data: dataParams) { (error) in
                    if error != nil {
                        self.showError("Data Saving Error","Error saving user data")
                    }
                }
            } else if operation == 14 {
                equationLabel.text = String(previousNumber - numberOnScreen)
                let userEmail = Auth.auth().currentUser?.email ?? "An Anonymous user"
                let logMessage = "\(String(describing: userEmail)) entered the equation \(previousNumber) - \(numberOnScreen) = \(previousNumber - numberOnScreen)"
                let db = Firestore.firestore()
                let date = Date()
                let dataParams = [
                    "log_message": logMessage,
                    "logged_at": "\(date)"
                ]
                db.collection("calculationLogs").addDocument(data: dataParams) { (error) in
                    if error != nil {
                        self.showError("Data Saving Error","Error saving user data")
                    }
                }
            } else if operation == 15 {
                equationLabel.text = String(previousNumber + numberOnScreen)
                let userEmail = Auth.auth().currentUser?.email ?? "An Anonymous user"
                let logMessage = "\(String(describing: userEmail)) entered the equation \(previousNumber) + \(numberOnScreen) = \(previousNumber + numberOnScreen)"
                let db = Firestore.firestore()
                let date = Date()
                let dataParams = [
                    "log_message": logMessage,
                    "logged_at": "\(date)"
                ]
                db.collection("calculationLogs").addDocument(data: dataParams) { (error) in
                    if error != nil {
                        self.showError("Data Saving Error","Error saving user data")
                    }
                }
            }
        } else if sender.tag == 11 {
            equationLabel.text = "0"
            numberOnScreen = 0
            previousNumber = 0
            operation = 0
        }
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
    
    private func showError(_ errorTitle: String, _ errorMessage: String) {
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}





//            switch operation {
//            case 12:
//                equationLabel.text = String(previousNumber / (Double(sender.tag - 1)))
//            case 13:
//                equationLabel.text = String(previousNumber * (Double(sender.tag - 1)))
//            case 14:
//                equationLabel.text = String(previousNumber - (Double(sender.tag - 1)))
//            case 15:
//                equationLabel.text = String(previousNumber + (Double(sender.tag - 1)))
//            default:
//                print("Error making calculation.  Operation is ", operation)
//            }
