//
//  InLobbyViewController.swift
//  ProjectGreen
//
//  Created by Adam on 3/5/17.
//  Copyright © 2017 Manzanita Labs. All rights reserved.
//

import UIKit

class InLobbyViewController: UIViewController {
    @IBOutlet weak var LobbyNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let QRViewerViewControllerRef = QRViewerViewController()
        let objectPrint = QRViewerViewControllerRef.metaDataObject
        print (objectPrint)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
