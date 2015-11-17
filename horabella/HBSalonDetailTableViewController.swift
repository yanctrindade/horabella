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
    @IBOutlet weak var pageControl: UIPageControl!
    
    var salon: HBSalon!
    var salonIndex: NSIndexPath!
    var salonImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        salon = CurrentHBSalonList.sharedInstance.HBSalonArray[salonIndex.row]
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        if let info = salon.name {
            title = info
        }
        
        //seta array com imagens do salao
        salonImages = [UIImage(named: "TesteSalaoBackground")!, UIImage(named: "TesteSalaoBackground")!, UIImage(named: "TesteSalaoBackground")!]
        
        //configuraçoes do scrollview
        picturesScrollView.showsHorizontalScrollIndicator = false
        picturesScrollView.showsVerticalScrollIndicator = false
        
        let pageCount = salonImages.count
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount

        for _ in 0..<pageCount {
            pageViews.append(nil)
        }

        let pagesScrollViewSize = CGSize(width: self.view.frame.width, height: picturesScrollView.frame.height)
        picturesScrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(salonImages.count),
            height: pagesScrollViewSize.height)

        loadVisiblePages()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - ScrollView
    
    func loadPage(page: Int) {
        if page < 0 || page >= salonImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // 1
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
        } else {
            // 2
            let frame = CGRect(x: self.view.frame.width * CGFloat(page), y: 0.0, width: self.view.frame.width, height: picturesScrollView.frame.height)
            
            // 3
            let newPageView = UIImageView(image: salonImages[page])
            newPageView.contentMode = .ScaleAspectFill
            newPageView.clipsToBounds = true
            newPageView.frame = frame
            picturesScrollView.addSubview(newPageView)
            
            // 4
            pageViews[page] = newPageView
        }
    }
    
    func purgePage(page: Int) {
        if page < 0 || page >= salonImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    func loadVisiblePages() {
        // First, determine which page is currently visible
        let pageWidth = picturesScrollView.frame.size.width
        let page = Int(floor((picturesScrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // Update the page control
        pageControl.currentPage = page
        
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        // Load pages in our range
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < salonImages.count; ++index {
            purgePage(index)
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        // Load the pages that are now on screen
        loadVisiblePages()
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
            //1 + quantidade de serviços
            return 2
        }else if segControl.selectedSegmentIndex == 1 {
            return 3
        }else{
            return 4
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch segControl.selectedSegmentIndex {
            
        case 0:
            if indexPath.row == 0{
                return 60
            }else{
                return 50
            }
            
        case 1:
            if indexPath.row == 0 {
                return 50
            }else if indexPath.row == 1 {
                return 45
            }else{
                return 116
            }
            
        default:
            if indexPath.row == 0 {
                return 110
            }else if indexPath.row == 1 {
                return 60
            }else{
                return 50
            }
            
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch segControl.selectedSegmentIndex {
            
        case 0:
            if indexPath.row == 0{
                
                let cell = tableView.dequeueReusableCellWithIdentifier("servicesCell", forIndexPath: indexPath) as! HBServicesTableViewCell
                return cell
                
            }else{
                
                //carrega uma celula pra cada serviço do salao
                let cell = tableView.dequeueReusableCellWithIdentifier("serviceCell", forIndexPath: indexPath) as! HBServiceTableViewCell
                
                cell.serviceLabel.text = "Corte masculino"
                cell.priceLabel.text = "R$100,00"
                
                return cell
            }
                
        case 1:
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("salonEvaluation", forIndexPath: indexPath) as! HBSalonEvaluationTableViewCell
                
                if let info = salon.rate{
                    cell.evaluationLabel.text = "\(info) estrelas"
                }
                
                if let info = salon.likes{
                    cell.likesLabel.text = "\(info) curtidas"
                }
                
                if let info = salon.comments{
                    cell.commentsLabel.text = "\(info) comentários"
                }
                
                return cell
                
            }else if indexPath.row == 1 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("makeComment", forIndexPath: indexPath) as! HBMakeCommentTableViewCell
                
                
                return cell
                
            }else{
                
                //carrega os comentarios
                let cell = tableView.dequeueReusableCellWithIdentifier("salonComment", forIndexPath: indexPath) as! HBSalonCommentsTableViewCell
                
                cell.userName.text = "Yan"
                cell.commentDate.text = "ontem"
                cell.comment.text = "Adorei o corte amigaaaaa"
                
                return cell
                
            }
            
        default:
            
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("salonDescription", forIndexPath: indexPath) as! HBSalonDescriptionTableViewCell
                
                if let info = salon.name{
                    cell.name.text = info
                }
                
                cell.salonDescription.text = "Descriçao do\nsalao\ntop"
                
                return cell
                
            }else if indexPath.row == 1 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath) as! HBSalonInfoTableViewCell
                
                cell.infoType.text = "Endereço"
                
                if let info = salon.address{
                    cell.infoDescription.text = info
                }
                
                return cell
                
            }else if indexPath.row == 2 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath) as! HBSalonInfoTableViewCell
                
                cell.infoType.text = "Telefone"
                
                if let info = salon.phone{
                    cell.infoDescription.text = info
                }
                
                return cell
                
            }else{
                
                let cell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath) as! HBSalonInfoTableViewCell
                
                cell.infoType.text = "Site"
                
                if let info = salon.website{
                    cell.infoDescription.text = info
                }
                
                return cell
                
            }
            
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
