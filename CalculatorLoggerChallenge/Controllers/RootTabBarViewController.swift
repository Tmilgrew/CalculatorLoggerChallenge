//
//  RootTabBarViewController.swift
//  CalculatorInterviewChallenge
//
//  Created by Thomas Milgrew on 9/8/20.
//  Copyright © 2020 Thomas Milgrew. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Root Tab View Did Load. \(Auth.auth().currentUser?.email)")
        authenticateUser()
        // Do any additional setup after loading the view.
    }
    
    func authenticateUser() {
        if Auth.auth().currentUser == nil {
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: Constants.Storyboard.accessControleNavigationController) as! AccessControlNavigationController
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
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
