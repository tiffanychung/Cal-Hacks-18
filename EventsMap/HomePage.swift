//
//  HomePage.swift
//  EventsMap
//
//  Created by Saahil Chadha on 11/3/18.
//  Copyright © 2018 Saahil Chadha. All rights reserved.
//

import UIKit
import Firebase

class HomePage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            print("logged out")
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RootScreen") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
            }
        }
        catch {
            print("error")
            return
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
