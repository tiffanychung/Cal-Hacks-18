//
//  ViewController.swift
//  EventsMap
//
//  Created by Saahil Chadha on 11/3/18.
//  Copyright © 2018 Saahil Chadha. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth


class ViewController: UIViewController {
    var fbLoginSuccess = false //This is gobal
    @IBOutlet weak var logInButton: UIButton!

    let facebookLogin = FBSDKLoginManager()
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        facebookLogin.logIn(withReadPermissions: ["public_profile", "email"], from: self, handler: {
            (facebookResult, facebookError) -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(String(describing: facebookError))")
            } else if (facebookResult?.isCancelled)! {
                print("Facebook login was cancelled.")
            } else {
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                Auth.auth().signIn(with: credential) { (user, error) in
                    if error != nil {
                        print("Login failed. \(String(describing: error))")
                    } else {
                        self.fbLoginSuccess = true
                        print("Logged in!")
                        
                        if (facebookResult?.grantedPermissions.contains("email"))! {
                            
                        }
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                }
            }
        })
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil && fbLoginSuccess == true){
            self.performSegue(withIdentifier: "goToHome", sender: nil)
        }
        
       
    }
}
