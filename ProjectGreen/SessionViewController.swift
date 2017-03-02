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
    @IBOutlet weak var pickerarray: UIPickerView!
    
    @IBOutlet weak var PickerView: UIPickerView!
    var ref : FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    
    
    
    
   
    var myArray = [String]()
    var availableLobbyArray = [String]()


    

    @IBAction func TestButton(_ sender: Any) {
        
        let rootRef = FIRDatabase.database().reference()
        
        let availableLobbiesRef = rootRef.child("Available_Lobbies")
        availableLobbiesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            for child in snapshot.children {
                let snap = child as! FIRDataSnapshot
                let lobbyKey = snap.key
                self.availableLobbyArray.append(lobbyKey)
            }
        })
        
        
        
        
       
    }

    
    //end of func JoinLobby



    
    
}
