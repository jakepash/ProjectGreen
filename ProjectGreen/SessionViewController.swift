//
//  SessionViewController.swift
//  ProjectGreen
//
//  Created by Adam on 2/23/17.
//  Copyright © 2017 Manzanita Labs. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase



class SessionViewController: UIViewController {
    
    @IBOutlet weak var PickerView: UIPickerView!
    var ref : FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var myArray = ["0"]
   
    
    @IBAction func JoinLobby(_ sender: Any) {
        
        ref = FIRDatabase.database().reference().child("Lobbies")
        //let key = String()
        
        myArray.remove(at: 0)
        
        
        
        ref.observeSingleEvent(of: .value, with: { (FIRDataSnap) in
            for child in FIRDataSnap.children.allObjects {
                let key = (child as AnyObject).key as String
                self.myArray.append(key)
            }
            
            
            
            
            for (_, element) in self.myArray.enumerated() {
                self.ref.child(element).child("Players").observeSingleEvent(of: .value, with: { (Snap) in
                    if Snap.childrenCount < 2 {
                        print ("Joining...")
                    }
                    else {
                        print ("Not Joining...")
                    
                    }
                })
                
            }
        
        
            
        })
        
        //...

        
       
        
    }
    @IBAction func PickerCheck(_ sender: Any) {
        print (self.myArray.count)
        
        
    }

    @IBOutlet weak var PickArray: UIPickerView!

    
}
