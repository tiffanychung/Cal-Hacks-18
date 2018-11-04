//
//  FBLogIn.swift
//  EventsMap
//
//  Created by Saahil Chadha on 11/3/18.
//  Copyright © 2018 Saahil Chadha. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class FBLogIn: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPwdButton: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 22, y: 439, width: view.frame.width - 32, height: 50)
    }
    @IBAction func logInButtonTapped(_ sender: Any) {
        //Check that fields aren't empty
        if let email = emailField.text, let pwd = pwdField.text{
            Auth.auth().signIn(withEmail: email, password: pwd) { (user, error) in
                
                //Check that user isn't nil
                if let u = user {
                    //User is found, go to home screen
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                    
                }
                else {
                    //Error: check error and show message
                }
        
        //Check that user isn't nil
        
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
    }
}
