//
//  WelcomeSignInViewController.swift
//  CalculatorInterviewChallenge
//
//  Created by Thomas Milgrew on 9/8/20.
//  Copyright © 2020 Thomas Milgrew. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class WelcomeSignInViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var continueAsAnonymousButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func anonymousLoginTapped(_ sender: Any) {
        Auth.auth().signInAnonymously() { (authResult, error) in
            guard let user = authResult?.user else { return }
            let db = Firestore.firestore()
            let dataParams = [
                "first_name": "anonymous",
                "last_name": "anonymous",
                "uid": user.uid
            ]
            db.collection("users").addDocument(data: dataParams) { (error) in
                if error != nil {
                    print("Error Anonymous Login")
                }
            }
            // Navigate to Home Screen
            self.navigateToHome()
        }
    }
    
    private func navigateToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.rootTabViewController) as? RootTabBarViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }

}
