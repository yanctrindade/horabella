//
//  HBScheludingTableViewController.swift
//  horabella
//
//  Created by Erick Leal on 18/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBScheludingTableViewController: UITableViewController {

    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var professionalArray = Array<String>()
    var availableSchedulesArray = Array<String>()
    
    var calendarCell: HBCalendarTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        professionalArray = ["Ian Ferreira", "Yan Trindade"]
        availableSchedulesArray = ["09:00", "10:00", "11:00"]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarCell.menuView.commitMenuViewUpdate()
        calendarCell.calendarView.commitCalendarViewUpdate()
    }
    
    // MARK: - Schedule
    
    @IBAction func confirmSchedule(sender: AnyObject) {
        print("faz agendamento")
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return professionalArray.count
        case 1:
            return 1
        case 2:
            return availableSchedulesArray.count
        default:
            return 1
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("professionalCell", forIndexPath: indexPath) as! HBProfessinalTableViewCell
            cell.name.text = professionalArray[indexPath.row]
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("calendarCell", forIndexPath: indexPath) as! HBCalendarTableViewCell
            calendarCell = cell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("availableScheduleCell", forIndexPath: indexPath) as! HBAvailableScheduleTableViewCell
            cell.timeLabel.text = availableSchedulesArray[indexPath.row]
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("confirmCell", forIndexPath: indexPath)
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("headerCell") as! HBHeaderTableViewCell
        
        switch section {
        case 0:
            header.sectionTitle.text = "Profissional"
        case 1:
            header.sectionTitle.text = "Data"
        case 2:
            header.sectionTitle.text = "Horário"
        default:
            return nil
        }
        
        return header
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 50
        case 1:
            return 300
        default:
            return 50
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
