//
//  HBConfirmationTableViewController.swift
//  horabella
//
//  Created by Erick Leal on 24/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import Alamofire

class HBConfirmationTableViewController: UITableViewController {
    
    @IBOutlet weak var salonPhoto: UIImageView!
    @IBOutlet weak var salonName: UILabel!
    @IBOutlet weak var salonAddress: UILabel!
    
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    
    @IBOutlet weak var professionalName: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var date: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Confirme"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //download the salon image 0
        if HBAppointment.sharedInstance.salon.images?.count > 0 {
            Alamofire.request(.GET, HBAppointment.sharedInstance.salon.images![0])
                .responseImage { response in
                    //debugPrint(response)
                    
                    //print(response.request)
                    //print(response.response)
                    //debugPrint(response.result)
                    
                    if let image = response.result.value {
                        //print("image downloaded: \(image)")
                        self.salonPhoto.image = image
                    }
            }
            
        }
        
        salonName.text = HBAppointment.sharedInstance.salon.name
        salonAddress.text = HBAppointment.sharedInstance.salon
        .address
        serviceName.text = HBAppointment.sharedInstance.service.name
        
        let str = NSString(format: "%.2f", HBAppointment.sharedInstance.service.price!)
        servicePrice.text = "R$ " + (str as String)
        
        professionalName.text = HBAppointment.sharedInstance.getProfessionalName()
        
        time.text = "\(HBAppointment.sharedInstance.hour):00"
        
        date.text = "\(HBAppointment.sharedInstance.day)/\(HBAppointment.sharedInstance.month)/\(HBAppointment.sharedInstance.year)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmAppointment(sender: AnyObject) {

        let parameters: Dictionary<String, AnyObject> = [
            "professional_id": HBAppointment.sharedInstance.professional.id!,
            "service_id": HBAppointment.sharedInstance.service.id!,
            "schedule_time": HBAppointment.sharedInstance.getStringDate()
        ]
        
        Smoke().postWithParameters(true, endpoint: "http://horabella.com.br/api/v1/appointment", parameters: parameters, successBlock: { (response) -> Void in
            
            let alert = UIAlertController(title: "Sucesso", message: "Agendamento feito com sucesso", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                alert.dismissViewControllerAnimated(true, completion: nil)
                self.navigationController?.popToRootViewControllerAnimated(true)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            print("deu certo")
            }) { (response) -> Void in
                print("nao deu certo")
                
                let alert = UIAlertController(title: "Erro", message: "Falha para fazer agendamento. Tente novamente", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                    alert.dismissViewControllerAnimated(true, completion: nil)
                }))
                self.presentViewController(alert, animated: true, completion: nil)
                
                print(NSString(data: response.data!, encoding: 4))
        }
        
//        let parameters: Dictionary<String, AnyObject> = [
//            "professional_id": HBAppointment.sharedInstance.professional.id!,
//            "service_id": HBAppointment.sharedInstance.service.id!,
//            "schedule_time": HBAppointment.sharedInstance.getStringDate()
//        ]
        
    }
    

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
