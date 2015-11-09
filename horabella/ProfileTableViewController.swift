//
//  ProfileTableViewController.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/9/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLoyaltyPoints: UILabel!
    @IBOutlet weak var userHistoryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func favoriteButton(sender: AnyObject) {
        print("Botao favorito pressionado")
    }
    
    @IBAction func settingsButton(sender: AnyObject) {
        print("Settings button pressed")
    }
}
