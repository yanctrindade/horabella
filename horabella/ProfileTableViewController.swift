//
//  ProfileTableViewController.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/9/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import Alamofire

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLoyaltyPoints: UILabel!
    @IBOutlet weak var userHistoryLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //loading user info
        if (SmokeUser.sharedInstance.isCurrentUser!) {
            userNameLabel.text = SmokeUser.sharedInstance.firstName + " " + SmokeUser.sharedInstance.lastName
            userLoyaltyPoints.text = "\(SmokeUser.sharedInstance.points) Pontos"
            emailLabel.text = SmokeUser.sharedInstance.email
            userHistoryLabel.text = "0 Agendamentos"
            //backgroundImage.image = UIImage(named: "")
            //profilePicture.image = UIImage(named: "")
            
            //baixa imagem do usuario
            Alamofire.request(.GET, SmokeUser.sharedInstance.pictureURL!)
                .responseImage { response in
                    if let image = response.result.value {
                        self.profilePicture.image = image
                        self.backgroundImage.image = image
                    }
            }
            
        }
        
        print(SmokeUser.sharedInstance.isCurrentUser)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    
    @IBAction func favoriteButton(sender: AnyObject) {
        print("Botao favorito pressionado")
    }
    
    @IBAction func settingsButton(sender: AnyObject) {
        print("Settings button pressed")
    }
}
