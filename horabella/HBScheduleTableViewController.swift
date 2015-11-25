//
//  HBScheduleTableViewController.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/20/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBScheduleTableViewController: UITableViewController, HBMyScheduleDelegate {
    
    var hbMySchedule: HBMySchedule?
    
    var myAppointmentsArray = [] as Array<HBMyAppointment>
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hbMySchedule = HBMySchedule()
        self.hbMySchedule?.delegate = self
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.myAppointmentsArray.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("agendamentoCell", forIndexPath: indexPath) as! HBScheduleTableViewCell
        
        let appointment = self.myAppointmentsArray[indexPath.section]
        // Configure the cell...
        cell.serviceNameLabel.text = appointment.service.name
        cell.serviceProviderNameLabel.text = appointment.professional.firstName! + " " + appointment.professional.lastName!
        cell.dateAndTimeLabel.text = appointment.scheduleTime

        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCellWithIdentifier("headerCell") as!HBScheduleHeaderTableViewCell
        headerView.salonNameLabel.text = self.myAppointmentsArray[section].service.salon?.name
        return headerView;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 94
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func reloadDataOfTable() {
        print("------ MYSCHEDULE DELEGATE METHOD ACCESSED ------")
        
        self.myAppointmentsArray = (self.hbMySchedule?.myAppointmentsArray)!
        
        self.tableView.reloadData()
    }
}
