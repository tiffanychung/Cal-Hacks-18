//
//  RootScreen.swift
//  EventsMap
//
//  Created by Saahil Chadha on 11/3/18.
//  Copyright © 2018 Saahil Chadha. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class RootScreen: UIViewController {
    
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var screenSubtitle: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var fbLogoImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding in the big white rectangle
        let rect = CGRect(x: 10, y: 129, width: 355, height: 554)
        let whiteRectView = UIView(frame: rect)
        whiteRectView.backgroundColor=UIColor.init(displayP3Red: 0.97, green: 1.0, blue: 1.0, alpha: 1.0)
        whiteRectView.layer.cornerRadius = 10
        self.view.addSubview(whiteRectView)
        
        //Adding in the star and rectangles group
        let goldRect = CGRect(x: 89, y: 170, width: 193, height: 193)
        let goldRectView = UIView(frame: goldRect)
        goldRectView.backgroundColor=UIColor.init(displayP3Red: 0.75, green: 0.62, blue: 0.27, alpha: 1)
        self.view.addSubview(goldRectView)
        
        let wrect1 = CGRect(x: 131, y: 150, width: 113, height: 231)
        let wrect1View = UIView(frame: wrect1)
        wrect1View.backgroundColor=UIColor.init(displayP3Red: 0.97, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(wrect1View)
        
        let wrect2 = CGRect(x: 55, y: 212, width: 265, height: 113)
        let wrect2View = UIView(frame: wrect2)
        wrect2View.backgroundColor=UIColor.init(displayP3Red: 0.97, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(wrect2View)
        
        let wrect3 = CGRect(x: 95, y: 176, width: 180, height: 180)
        let wrect3View = UIView(frame: wrect3)
        wrect3View.backgroundColor=UIColor.init(displayP3Red: 0.97, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(wrect3View)
        
        //FIGURE OUT HOW TO DO THE STAR AND PUT THAT HERE!!!
        
        
        
        
        //Login rectangle
        let logInRect = CGRect(x: 48, y: 537, width: 286, height: 59)
        let logInRectView = UIView(frame: logInRect)
        logInRectView.backgroundColor=UIColor.init(displayP3Red: 0.31, green: 0.46, blue: 0.69, alpha: 1.0)
        logInRectView.layer.cornerRadius = 10
        self.view.addSubview(logInRectView)
        
        //Move all the text and images to front
        self.view.bringSubviewToFront(screenTitle)
        self.view.bringSubviewToFront(screenSubtitle)
        self.view.bringSubviewToFront(logInButton)
        self.view.bringSubviewToFront(starImage)
        self.view.bringSubviewToFront(fbLogoImage)
        
        
    }
    @IBAction func facebookLoginPressed(_ sender: Any) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                // Present the main view
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    self.dismiss(animated: true, completion: nil)
                }
                
            })
            
        }
        
    }
    
    
}
