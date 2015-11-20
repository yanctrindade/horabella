//
//  HBScheduleTableViewController.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/20/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBScheduleTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("agendamentoCell", forIndexPath: indexPath) as! HBScheduleTableViewCell

        // Configure the cell...
        cell.serviceNameLabel.text = "Baby Liss"
        cell.serviceProviderNameLabel.text = "Mara"
        cell.dateAndTimeLabel.text = "26/10 às 9:00"

        return cell
    }

}