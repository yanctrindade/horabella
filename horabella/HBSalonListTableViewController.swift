//
//  HBSalonListTableViewController.swift
//  horabella
//
//  Created by Yan Correa Trindade on 10/27/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import HCSStarRatingView

class HBSalonListTableViewController: UITableViewController,UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController = UISearchController(searchResultsController: nil)
    var salaoNome = "Helio Diff Hair Design"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavBarSettings
        navigationController!.navigationBar.barTintColor = UIColor(netHex: 0x472C44) //background color
        
        //Search Controller Settings
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = true
        navigationItem.titleView = searchController.searchBar
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //NavBar Button depends if the filters are ON or OFF
        if (1 == 2) {
            let filterButton = UIBarButtonItem(image: UIImage(named: "filterButtonON")!.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: Selector("FilterBarButton"))
            self.navigationItem.rightBarButtonItem = filterButton
        } else {
            let filterButton = UIBarButtonItem(image: UIImage(named: "filterButtonOFF")!.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: Selector("FilterBarButton"))
            self.navigationItem.rightBarButtonItem = filterButton
        }
        
    }
    
    //MARK: Search Bar Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        salaoNome = searchString!
        self.tableView.reloadData()
    }
    
    
    //MARK: Filter Bar Button
    func FilterBarButton() {
        self.performSegueWithIdentifier("feedToFilter", sender: self)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("salonCell", forIndexPath: indexPath) as! HBSalonListTableViewCell

        // Configure the cell...
        cell.salonName.text = salaoNome

        return cell
    }
    
}

//MARK: Usar UIColor Extension de um cógido Hex
//Ex: 0xffffff
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
