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
        
        if SmokeUser.sharedInstance.currentUser() == nil {
            self.tabBarController?.selectedIndex = 0
        } else {
            self.hbMySchedule = HBMySchedule()
            self.hbMySchedule?.delegate = self
        }
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myAppointmentsArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("agendamentoCell", forIndexPath: indexPath) as! HBScheduleTableViewCell
        
        if myAppointmentsArray.count > 0 {
            let appointment = self.myAppointmentsArray[indexPath.row]
            // Configure the cell...
            cell.salonNameLabel.text = appointment.service.salon!.name
            cell.serviceNameLabel.text = appointment.service.name
            cell.serviceProviderNameLabel.text = appointment.professional.firstName! + " " + appointment.professional.lastName!
            cell.dateAndTimeLabel.text = appointment.scheduleTime
        } else {
            cell.serviceNameLabel.text = "Error"
        }
        
        return cell
    }
    
    //Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let endPoint = "http://horabella.com.br/api/v1/appointment/" + String(self.myAppointmentsArray[indexPath.row].id!)
            
            Smoke().deleteWithParameters(true, endpoint: endPoint, parameters: nil, successBlock: { (response) -> Void in
                print(response)
                self.myAppointmentsArray.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                }, errorBlock: { (response) -> Void in
                    print(response)
            })
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }

    
    func reloadDataOfTable() {
        print("------ MYSCHEDULE DELEGATE METHOD ACCESSED ------")
        
        self.myAppointmentsArray = (self.hbMySchedule?.myAppointmentsArray)!
        
        self.tableView.reloadData()
    }
    
}
