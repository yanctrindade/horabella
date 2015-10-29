//
//  HBSalonDetailTableViewController.swift
//  horabella
//
//  Created by Erick Leal on 28/10/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBSalonDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var picturesScrollView: UIScrollView!
    @IBOutlet weak var segControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segmented Control
    
    @IBAction func indexChanged(sender: AnyObject) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segControl.selectedSegmentIndex == 0 {
            return 0
        }else if segControl.selectedSegmentIndex == 1 {
            return 3
        }else{
            return 0
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch segControl.selectedSegmentIndex {
            
        case 0:
            return 100
            
        case 1:
            if indexPath.row == 0 {
                return 50
            }else if indexPath.row == 1 {
                return 45
            }else{
                return 116
            }
            
        default:
            return 100
            
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch segControl.selectedSegmentIndex {
            
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
            
            return cell
            
        case 1:
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("salonEvaluation", forIndexPath: indexPath) as! HBSalonEvaluationTableViewCell
                
                cell.evaluationLabel.text = "5 estrelas"
                cell.likesLabel.text = "10 curtidas"
                cell.commentsLabel.text = "2 comentarios"
                
                return cell
                
            }else if indexPath.row == 1 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("makeComment", forIndexPath: indexPath) as! HBMakeCommentTableViewCell
                
                
                return cell
                
            }else{
                
                let cell = tableView.dequeueReusableCellWithIdentifier("salonComment", forIndexPath: indexPath) as! HBSalonCommentsTableViewCell
                
                cell.userName.text = "Yan"
                cell.commentDate.text = "ontem"
                cell.comment.text = "Adorei o corte amigaaaaa"
                
                return cell
                
            }
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
            
            return cell
            
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
