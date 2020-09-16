//
//  SignUpViewController.swift
//  CalculatorInterviewChallenge
//
//  Created by Thomas Milgrew on 9/8/20.
//  Copyright © 2020 Thomas Milgrew. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpElements()

    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        } else {
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                
                // Check for errors
                if error != nil {
                    self.showError("Error creating user.")
                } else {
                    // User was stored successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    let dataParams = [
                        "first_name": firstName,
                        "last_name": lastName,
                        "uid": result!.user.uid
                    ]
                    db.collection("users").addDocument(data: dataParams) { (error) in
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                    }
                    // Navigate to Home Screen
                    self.navigateToHome()
                    
                }
            }

        }
    }
    
    
    func setUpElements() {
    
        errorLabel.alpha = 0
    
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    private func validateFields() -> String? {
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password contains at least 8 characters, a special character, and a number."
        }
        
        return nil
    }
    
    private func navigateToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.rootTabViewController) as? RootTabBarViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    private func showError(_ errorString: String) {
        errorLabel.text = errorString
        errorLabel.alpha = 1
    }
}
