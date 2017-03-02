//
//  FirstViewController.swift
//  ProjectGreen
//
//  Created by Adam on 3/2/17.
//  Copyright © 2017 Manzanita Labs. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let GameViewController = storyBoard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            self.present(GameViewController, animated:true, completion:nil)
            return true
        }
        else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let SignInViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            self.present(SignInViewController, animated:true, completion:nil)
            return false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        isAppAlreadyLaunchedOnce()
    }
   
   }
