////
////  ChooseViewController.swift
////  ProjectGreen
////
////  Created by Adam on 2/24/17.
////  Copyright © 2017 Manzanita Labs. All rights reserved.
////
//
//import UIKit
//import Firebase
//
//class ChooseViewController: UIViewController {
//
//    
//    var ref = Fire
//    var titlesArray = [String]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        
//        // "events" is the root, and "title" is the key for the data I wanted to build an array with.
//        let titleRef = self.ref.childByAppendingPath("events")
//        titleRef.queryOrderedByChild("title").observeEventType(.ChildAdded, withBlock: { snapshot in
//            
//            if let title = snapshot.value["title"] as? String {
//                self.titlesArray.append(title)
//                
//                // Double-check that the correct data is being pulled by printing to the console.
//                print("\(self.titlesArray)")
//                
//                // async download so need to reload the table that this data feeds into.
//                self.tableView.reloadData()
//            }
//        })
//
//        
//        
//        
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    // Class variables
//    
//    
//    // Under viewDidLoad
//    
//    
//    
//
//}





//
//
//
//
//@IBAction func JoinLobby(_ sender: Any) {
//    
//    
//    
//    
//    
//    ref = FIRDatabase.database().reference().child("Lobbies")
//    //let key = String()
//    
//    
//    
//    
//    
//    
//    self.ref.observeSingleEvent(of: .value, with: { (FIRDataSnap) in
//        
//        for child in FIRDataSnap.children.allObjects {
//            let key = (child as AnyObject).key as String
//            self.myArray.append(key)
//        }
//        
//    })
//    
//    
//    for (element) in self.myArray {
//        
//        self.ref.child(element).child("Players").observeSingleEvent(of: .value, with: { (Snap) in
//            
//            if Snap.childrenCount < 2 {
//                print("Can Join lobby\(element)")
//                self.CanJoinArray.append(element)
//                
//            }
//            else {
//                print("Can't join lobby\(element)... Full!")
//                
//            }
//            
//            
//        }
//        )
//        
//        
//        
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//}
