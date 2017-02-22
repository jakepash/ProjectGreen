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

class GameViewController: UIViewController {
    
    var ref : FIRDatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    
    @IBAction func PushDatabase(_ sender: Any) {
        
        ref = FIRDatabase.database().reference()
        let user = FIRAuth.auth()?.currentUser
        let username = user?.email
        let uid = user?.uid

        
        self.ref.child("users").child(uid!).setValue(["email": username])
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
