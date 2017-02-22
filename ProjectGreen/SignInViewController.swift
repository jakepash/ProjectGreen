//
//  SignInViewController.swift
//  ProjectGreen
//
//  Created by Adam on 2/22/17.
//  Copyright © 2017 Manzanita Labs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class SignInViewController: UIViewController {
    
    

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    let password = "adamadam"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }

    
    @IBAction func ClickSignIn(_ sender: Any) {
        
        let email = self.email.text
        
        let username = self.username.text
        
        
        FIRAuth.auth()?.createUser(withEmail: (email)!, password: password) { (user, error) in
            print ("Created user / user already exists! Trying to sign in")
            
            FIRAuth.auth()?.signIn(withEmail: (email)!, password: self.password) { (user, error) in
                print("user signed in!")
            }
        }
        
        let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
        
        changeRequest?.displayName = username
        
        changeRequest?.commitChanges()        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
