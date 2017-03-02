//
//  GameViewController.swift
//  ProjectGreen
//
//  Created by Jacob Pashman on 2/21/17.
//  Copyright © 2017 Manzanita Labs. All rights reserved.
//


import UIKit
import SpriteKit
import GameplayKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
//import QRCode


class GameViewController: UIViewController{
    
    var ref : FIRDatabaseReference!
    var Joinref :FIRDatabaseReference!
    var Postref :FIRDatabaseReference!
    let password = "adamadam"

    @IBOutlet weak var LobbyName: UITextField!
    
    var availableLobbyArray = [String]()

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GameViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        
        
        
        
        
        print ("Loaded")
    }      
        
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    
   

    @IBAction func CreateLobby(_ sender: Any) {
        
        ref = FIRDatabase.database().reference()
        
        let user = FIRAuth.auth()?.currentUser
        let uid = user?.uid
        
        let LobbyNameStr = self.LobbyName.text
        
        if LobbyNameStr == "" {
        
            print ("At least 1 character")
        
        }
        
        else {
            self.ref.child("Lobbies").child(LobbyNameStr!).child("players").child(uid!).setValue(["uid_0": uid!])
            self.ref.child("Available_Lobbies").child(LobbyNameStr!).setValue(["CanJoin": true])
        }
        
        
        
        
    }
    
    
    func CreateArrayCanJoinLobbies() {
    
        Postref = FIRDatabase.database().reference()
        
        let availableLobbiesRef = Postref.child("Available_Lobbies")
        
        
        availableLobbiesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            for child in snapshot.children {
                let snap = child as! FIRDataSnapshot
                let lobbyKey = snap.key
                self.availableLobbyArray.append(lobbyKey)
            }
        })
    
    
    }
    
    @IBAction func JoinLobbyButton(_ sender: Any) {
        
        self.CreateArrayCanJoinLobbies()
        let user = FIRAuth.auth()?.currentUser
        let uid = user?.uid
        
        
        Joinref = FIRDatabase.database().reference()
        
        let LobbyNameStr = self.LobbyName.text
        
        
        if self.availableLobbyArray.contains(LobbyNameStr!) {
        
            self.Joinref.child("Lobbies").child(LobbyNameStr!).child("players").child(uid!).setValue(["uid_1": uid!])
            self.Joinref.child("Available_Lobbies").child(LobbyNameStr!).removeValue()
        
        }
        else {
        
            print ("No such Lobby")
            print (self.availableLobbyArray)
        }
            
      }
    
    
    // QR codes...
//    @IBAction func JoinWithQR(_ sender: Any) {
//        
//        let LobbyNameStr = self.LobbyName.text
//        
//        let url = "https://myproject-e9dfb.firebaseio.com/Lobbies/\(LobbyNameStr!)/.json"
//        
//        imageView.image = {
//            var qrCode = QRCode(url)!
//            qrCode.size = self.imageView.bounds.size
//            qrCode.color = CIColor(rgba: "2980b9")
//            return qrCode.image
//        }()
//        
//    }

    
    
   
    override func viewDidAppear(_ animated: Bool) {
        
        let keychain = UserDefaults.standard.string(forKey: "email")
        print (keychain!)
        
        FIRAuth.auth()?.signIn(withEmail: (keychain)!, password: password) { (user, error) in
            print ("Signed in with user: \(user)")
        }
        
        
        self.CreateArrayCanJoinLobbies()
        
    }
    
    
  }
