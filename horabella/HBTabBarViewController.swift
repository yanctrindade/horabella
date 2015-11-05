//
//  HBTabBarViewController.swift
//  horabella
//
//  Created by Yan Correa Trindade on 10/29/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Tab Bar Color Contorno ativado
        self.tabBar.tintColor = UIColor.whiteColor()
        
        let tabBarON = ["saloesTab_on","agendaTab_on","profileTab_on","dealsTab_on"]
        let tabBarOFF = ["saloesTab_off","agendaTab_off","profileTab_off","dealsTab_off"]
        
        //TabBar Icons White
        for var i: Int = 0; i<4; i++ {
            let tabBarItem = self.tabBar.items![i]
            tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
            tabBarItem.image = UIImage(named: tabBarOFF[i])!.imageWithRenderingMode(.AlwaysOriginal)
            tabBarItem.selectedImage = UIImage(named: tabBarON[i])
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
