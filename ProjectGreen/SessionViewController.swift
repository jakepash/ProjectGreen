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
    
    
    var ref : FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func JoinLobby(_ sender: Any) {
        
        ref = FIRDatabase.database().reference().child("Lobbies")
        
        
        // return all
        ref.observeSingleEvent(of: .value, with: { (FIRDataSnap) in
            for child in FIRDataSnap.children.allObjects {
                let key = (child as AnyObject).key as String
                
                self.ref.child(key).child("Players").observeSingleEvent(of: .value , with: { (FIR) in
                    for data in FIR.children.allObjects {
                        let key1 = (data as AnyObject).key as String
                        print (key1)
                        
                    
                    
                    }
                })
            }
        
        
            
    })
        
        
        
        
    }
}
