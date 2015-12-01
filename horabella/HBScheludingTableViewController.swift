//
//  HBScheludingTableViewController.swift
//  horabella
//
//  Created by Erick Leal on 18/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBScheludingTableViewController: UITableViewController, HBScheduleDelegate {

    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var professionalArray = Array<HBProfessional>()
    var availableSchedulesArray = Array<String>()
    
    var calendarCell: HBCalendarTableViewCell!
    
    var isTimeSelected = false
    
    var hbSchedule:HBSchedule?
    var serviceName: String?
    var servicePrice: String?
    var serviceId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: Selector("didSelectDay:"),
            name: "didSelectDay",
            object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        isTimeSelected = false
        
        HBAppointment.sharedInstance.reset()
        
        //protocol request
        hbSchedule = HBSchedule(idService: self.serviceId!)
        hbSchedule?.delegate = self
        
        //outlets
        serviceLabel.text = serviceName
        priceLabel.text = servicePrice!
        
        //observer para atualizar horarios quando clica em um dia
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarCell.menuView.commitMenuViewUpdate()
        calendarCell.calendarView.commitCalendarViewUpdate()
    }
    
    // MARK: - Schedule
    @IBAction func confirmSchedule(sender: AnyObject) {
        
        if HBAppointment.sharedInstance.isReady() {
            performSegueWithIdentifier("confirmSchedule", sender: self)
        }else{
            print("falta infos")
            
            let alert = UIAlertController(title: "Erro", message: "Escolha um horário válido para confirmar", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
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
    
    //CELL FOR ROW
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("professionalCell", forIndexPath: indexPath) as! HBProfessinalTableViewCell
            cell.name.text = professionalArray[indexPath.row].firstName! + " " + professionalArray[indexPath.row].lastName!
            if HBAppointment.sharedInstance.isProfessionalSelected {
                if professionalArray[indexPath.row].id == HBAppointment.sharedInstance.professional.id {
                    tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
                }
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("calendarCell", forIndexPath: indexPath) as! HBCalendarTableViewCell
            cell.selectionStyle = .None
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
    
    //DID SELECT ROW
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            HBAppointment.sharedInstance.isProfessionalSelected = true
            
            //coloca profissional na singleton appointment
            HBAppointment.sharedInstance.professional = professionalArray[indexPath.row]
            
            updateTimes()
            
            self.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .Middle)
        } else if indexPath.section == 2 {
            
            let time = availableSchedulesArray[indexPath.row] as String
            let timeArray = time.componentsSeparatedByString(":")
            
            HBAppointment.sharedInstance.hour = Int(timeArray[0])
            HBAppointment.sharedInstance.minute = Int(timeArray[1])
            
            HBAppointment.sharedInstance.setDate()
            HBAppointment.sharedInstance.isTimeSelected = true
            
        }
    }
    
    //INDEX UNICO POR SECTION
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if let array = tableView.indexPathsForSelectedRows {
            for selectedIndexPath in array {
                if selectedIndexPath.section == indexPath.section {
                    tableView.deselectRowAtIndexPath(selectedIndexPath, animated: false)
                }
            }
        }
        return indexPath
    }
    
    
    //VIEW FOR HEADER IN SECTION
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("headerCell") as! HBHeaderTableViewCell
        
        switch section {
        case 0:
            header.sectionTitle.text = "1. Profissional"
        case 1:
            header.sectionTitle.text = "2. Data"
        case 2:
            header.sectionTitle.text = "3. Horário"
        default:
            return nil
        }
        
        return header
    }
    
    //HEIGHT FOR ROW
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
    
    //MARK: Schedule Delegate Method
    func reloadDataOfTable() {
        print("--- Schedule Delegate Method Accessed ---")
        
        self.professionalArray = (self.hbSchedule?.professionalsArray)!
        
        self.tableView.reloadData()
    }
    
    func reloadAvailableTimes() {
        
        self.availableSchedulesArray = (self.hbSchedule?.availableTimesArray)!
        
        self.tableView.reloadData()
        
    }
    
    //MARK: Get available times
    
    func didSelectDay(sender: NSNotification) {
        if HBAppointment.sharedInstance.isProfessionalSelected{
            updateTimes()
        }
    }
    
    func updateTimes() {
        hbSchedule?.getAvailableTimes(HBAppointment.sharedInstance.day, month: HBAppointment.sharedInstance.month, year: HBAppointment.sharedInstance.year, professionalId: Int(HBAppointment.sharedInstance.professional.id!))
    }
    
}
