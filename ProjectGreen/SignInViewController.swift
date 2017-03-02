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
    
    
    @IBOutlet weak var FirstLaunchTxt: UILabel!

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    let password = "adamadam"
    
    var ref : FIRDatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
                
    }
    
    
    
    @IBAction func ClickSignIn(_ sender: Any) {
        
        let email = self.email.text
        ref = FIRDatabase.database().reference()
        let user = FIRAuth.auth()?.currentUser
        let uid = user?.uid
        
        let username = self.username.text
        
        
        FIRAuth.auth()?.createUser(withEmail: (email)!, password: password) { (user, error) in
            print ("Creating User")
        }
        UserDefaults.standard.set(email, forKey: "email")
        let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
        
        changeRequest?.displayName = username
        
        changeRequest?.commitChanges()
        
        self.ref.child("Users").child(uid!).setValue(["DisplayName": username,"Email": email])
        
        
        
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
