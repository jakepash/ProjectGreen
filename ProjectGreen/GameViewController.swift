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
import QRCode


class GameViewController: UIViewController{
    
    var ref : FIRDatabaseReference!
    var Joinref :FIRDatabaseReference!
    var Postref :FIRDatabaseReference!
    var Leaveref :FIRDatabaseReference!
    let joinedSession = String()
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
            let url = LobbyNameStr
            imageView.image = {
                var qrCode = QRCode(url!)!
                qrCode.size = self.imageView.bounds.size
                return qrCode.image
            }()
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
            let joinedSession = LobbyNameStr!
            
        }
        else {
        
            print ("No such Lobby")
            print (self.availableLobbyArray)
        }
        
            
      }
    
    
    func leaveLobby() {
        
        
        Leaveref = FIRDatabase.database().reference()
        let user = FIRAuth.auth()?.currentUser
        let uid = user?.uid
    
        print (joinedSession)
        //self.Leaveref.child("Lobbies").child(joinedSession).child("Players").child(uid!).removeValue()
    
    }
    
    
    // QR codes...
//    @IBAction func JoinWithQR(_ sender: Any) {
//        
//        let LobbyNameStr = self.LobbyName.text
//        
//        let url = LobbyNameStr
//        
//        if url == "" {
//        
//            print ("You need at least 1 character.")
//        
//        
//        }
//
//        else if (url?.characters.count)! > 20 {
//            
//            print ("No more then 20 characters")
//            
//        }
//        else {
//        imageView.image = {
//            var qrCode = QRCode(url!)!
//            qrCode.size = self.imageView.bounds.size
//            qrCode.color = CIColor(rgba: "00b2ee")
//            return qrCode.image
//        }()
//        }
//    }

    
    
   
    override func viewDidAppear(_ animated: Bool) {
        
        let keychain = UserDefaults.standard.string(forKey: "email")
        print (keychain!)
        
        FIRAuth.auth()?.signIn(withEmail: (keychain)!, password: password) { (user, error) in
            print ("Signed in with user: \(keychain!)")
        }
        
        
        self.CreateArrayCanJoinLobbies()
        
    }
    
    
  }
