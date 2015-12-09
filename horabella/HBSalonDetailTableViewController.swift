//
//  HBSalonDetailTableViewController.swift
//  horabella
//
//  Created by Erick Leal on 28/10/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class HBSalonDetailTableViewController: UITableViewController, HBSalonDetailDelegate {
    
    @IBOutlet weak var picturesScrollView: UIScrollView!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var hbSalonDetail: HBSalonDetail?
    var servicesByCategoryArray = Array<Array<HBService>>(count: 6, repeatedValue: [])
    var commentsArray = [] as Array<HBComment>
    
    var salon: HBSalon!

    var pageViews: [UIImageView?] = []
    
    var commentCell: HBMakeCommentTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = true
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        if let info = salon.name {
            title = info
        }
        
        //configuraçoes do scrollview
        picturesScrollView.showsHorizontalScrollIndicator = false
        picturesScrollView.showsVerticalScrollIndicator = false
        
        let pageCount = salon.images!.count
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount

        for _ in 0..<pageCount {
            pageViews.append(nil)
        }

        let pagesScrollViewSize = CGSize(width: self.view.frame.width, height: picturesScrollView.frame.height)
        picturesScrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(salon.images!.count),
            height: pagesScrollViewSize.height)
        
    }
    
    //MARK: Will Appear - Delegate Request
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        hbSalonDetail = HBSalonDetail(idSalon: self.salon.id!)
        hbSalonDetail?.delegate = self
        
        loadVisiblePages()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        HBServiceFilterSingleton.sharedInstance.selected.removeAll()
    }
    
    //MARK: - Make comment
    
    @IBAction func makeComment(sender: AnyObject) {
        
        if SmokeUser.sharedInstance.currentUser() != nil {
            hbSalonDetail?.makeComment(salon.id!, comment: commentCell.comment.text!)
            
            commentCell.comment.text = nil
        } else {
            let loginViewController = UIStoryboard(name: "Login", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("loginViewController")
            presentViewController(loginViewController, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - ScrollView
    func loadPage(page: Int) {
        if page < 0 || page >= salon.images!.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // 1
        if let _ = pageViews[page] {
            // Do nothing. The view is already loaded.
        } else {
            // 2
            let frame = CGRect(x: self.view.frame.width * CGFloat(page), y: 0.0, width: self.view.frame.width, height: picturesScrollView.frame.height)
            
            // 3
            let newPageView = UIImageView(image: UIImage(named: "noImage"))
            
            //download the salon images
            Alamofire.request(.GET, salon.images![page])
                .responseImage { response in
                    if let image = response.result.value {
                        newPageView.image = image
                    }
            }

            
            
            newPageView.contentMode = .ScaleAspectFill
            newPageView.clipsToBounds = true
            newPageView.frame = frame
            picturesScrollView.addSubview(newPageView)
            
            // 4
            pageViews[page] = newPageView
        }
    }
    
    func purgePage(page: Int) {
        if page < 0 || page >= salon.images!.count {
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
        for var index = lastPage+1; index < salon.images!.count; ++index {
            purgePage(index)
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        // Load the pages that are now on screen
        loadVisiblePages()
    }
    
    
    // MARK: - Segmented Control
    @IBAction func indexChanged(sender: AnyObject) {
        //se for a primeira aba, abilita seleçao para escolher serviço
        if sender.selectedSegmentIndex == 0  || sender.selectedSegmentIndex == 2{
            tableView.allowsSelection = true
        }else{
            tableView.allowsSelection = false
            hbSalonDetail?.getComments(salon.id!)
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        switch segControl.selectedSegmentIndex {
        case 0:
            return 1+self.servicesByCategoryArray.count
        case 1:
            return 1
        default:
            return 1
        }
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if segControl.selectedSegmentIndex == 0 {
                return 1
            }else if segControl.selectedSegmentIndex == 1 {
                return 2 + commentsArray.count
            }else{
                return 4
            }
        } else {
            return servicesByCategoryArray[section-1].count
        }
        
    }
    
    //HEIGHT FOR ROW
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        switch segControl.selectedSegmentIndex {
        case 0:
            if indexPath.section == 0{
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
    
    //CELL FOR ROW
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        switch segControl.selectedSegmentIndex {
        case 0:
            if indexPath.section == 0{
                let cell = tableView.dequeueReusableCellWithIdentifier("servicesCell", forIndexPath: indexPath) as! HBServicesTableViewCell
                
                //saber quais categorias possuem serviços
                var arrayIndex = [] as Array<Int>
                for var i: Int = 0; i<self.servicesByCategoryArray.count; i++ {
                    if self.servicesByCategoryArray[i].count > 0 {
                        arrayIndex.append(i)
                    }
                }
                
                cell.categoriesArray = arrayIndex
                cell.collectionView.reloadData()
                return cell
                
            }else{
                //carrega uma celula pra cada serviço do salao
                let cell = tableView.dequeueReusableCellWithIdentifier("serviceCell", forIndexPath: indexPath) as! HBServiceTableViewCell
                
                let service = servicesByCategoryArray[indexPath.section-1][indexPath.row]
                
                cell.serviceLabel.text = service.name
                let str = NSString(format: "%.2f", service.price!)
                cell.priceLabel.text = "R$ " + (str as String)
                
                return cell
            }
                
        case 1:
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("salonEvaluation", forIndexPath: indexPath) as! HBSalonEvaluationTableViewCell
                
                if let info = salon.rate{
                    cell.evaluationLabel.text = "\(suffixNumber(NSNumber(double: info)))"
                }
                
                if let info = salon.likes{
                    cell.likesLabel.text = "\(suffixNumber(info))"
                }
                
                if let info = salon.comments{
                    cell.commentsLabel.text = "\(suffixNumber(info))"
                }
                
                return cell
                
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("makeComment", forIndexPath: indexPath) as! HBMakeCommentTableViewCell
                
                commentCell = cell
                
                return cell
            }else{
                
                //carrega os comentarios
                let cell = tableView.dequeueReusableCellWithIdentifier("salonComment", forIndexPath: indexPath) as! HBSalonCommentsTableViewCell
                
                cell.userName.text = commentsArray[indexPath.row-2].fullName!
                cell.commentDate.text = commentsArray[indexPath.row-2].date!
                cell.comment.text = commentsArray[indexPath.row-2].comment!

                //baixa imagem do comentario
                Alamofire.request(.GET, commentsArray[indexPath.row-2].picture!)
                    .responseImage { response in
                        if let image = response.result.value {
                            //print("image downloaded: \(image)")
                            cell.userPicture.image = image
                        }
                }
                
                return cell
            }
        default:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("salonDescription", forIndexPath: indexPath) as! HBSalonDescriptionTableViewCell
                
                if let info = salon.name{
                    cell.name.text = info
                }
                
                cell.salonDescription.text = "Descriçao do\nsalao"
                return cell
                
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath) as! HBSalonInfoTableViewCell
                
                cell.infoType.text = "Endereço"
                
                if let info = salon.address{
                    cell.infoDescription.text = info
                }
                
                return cell
                
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath) as! HBSalonInfoTableViewCell
                
                cell.infoType.text = "Telefone"
                
                if let info = salon.phone{
                    cell.infoDescription.text = info
                }
                
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath) as! HBSalonInfoTableViewCell
                
                cell.infoType.text = "Site"
                
                if let info = salon.website{
                    cell.infoDescription.text = info
                }
                
                return cell
            }
        }
        
    }
    
    //DID SELECT
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch segControl.selectedSegmentIndex {
        case 0:
            if indexPath.row == 0 && indexPath.section == 0{
                //collectionView
                print("passei aqui -------")
            }else{
                //celula de servicos
            }
            
        case 1:
            if indexPath.row == 1 {
                //makeComment
            }else{
                //carrega os comentarios
            }
        default:
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! HBSalonInfoTableViewCell
            if indexPath.row == 1 {
                //endereco
                let lat = String(self.salon.location!.coordinate.latitude)
                let long = String(self.salon.location!.coordinate.longitude)
                
                let wazeURL = "waze://?ll=\(lat),\(long)&navigate=yes"
                let mapsURL = "maps://?daddr=\(lat),\(long)"
                
                //check if waze is installed on iphone
                let canOpenURL = UIApplication.sharedApplication().canOpenURL(NSURL(string: wazeURL)!)
                
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
                let wazeAction = UIAlertAction(title: "Abrir Waze", style: .Default) { _ in
                    //call to salon
                    UIApplication.sharedApplication().openURL(NSURL(string: wazeURL)!)
                }
                let mapsAction = UIAlertAction(title: "Abrir Mapas", style: .Default) { _ in
                    //call to salon
                    UIApplication.sharedApplication().openURL(NSURL(string: mapsURL)!)
                }
                let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel) { _ in }
                if canOpenURL {
                    alert.addAction(wazeAction)
                }
                alert.addAction(mapsAction)
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true){}
                
            } else if indexPath.row == 2 {
                
                //remove non number characters
                let stringArray = cell.infoDescription.text!.componentsSeparatedByCharactersInSet(
                    NSCharacterSet.decimalDigitCharacterSet().invertedSet)
                let phone = stringArray.joinWithSeparator("")
                
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
                let callAction = UIAlertAction(title: "Ligar", style: .Default) { _ in
                    //call to salon
                    if let phoneCallURL:NSURL = NSURL(string: "tel://+55\(phone)") {
                        let application:UIApplication = UIApplication.sharedApplication()
                        if (application.canOpenURL(phoneCallURL)) {
                            application.openURL(phoneCallURL);
                        }
                    }
                }
                let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel) { _ in }
                alert.addAction(callAction)
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true){}
                
            } else {
                //website
                let website = cell.infoDescription.text
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
                let callAction = UIAlertAction(title: "Acessar Website", style: .Default) { _ in
                    //call to salon
                    if let websiteURL:NSURL = NSURL(string: website!) {
                        let application:UIApplication = UIApplication.sharedApplication()
                        if (application.canOpenURL(websiteURL)) {
                            application.openURL(websiteURL);
                        }
                    }
                }
                let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel) { _ in }
                alert.addAction(callAction)
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true){}
                
            }
        }
    }
    
    //HEIGHT FOR HEADER
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return servicesByCategoryArray[section-1].count > 0 ? 35 : 0
        }
    }
    
    
    //VIEW FOR HEADER
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCellWithIdentifier ("sectionHeader") as! HBServiceHeaderTableViewCell
        switch (section) {
        case 1:
            headerView.categoryLabel.text = "Cabelo"
        case 2:
            headerView.categoryLabel.text = "Unha"
        case 3:
            headerView.categoryLabel.text = "Maquiagem"
        case 4:
            headerView.categoryLabel.text = "Depilação"
        case 5:
            headerView.categoryLabel.text = "Massagem"
        case 6:
            headerView.categoryLabel.text = "Estética"
        default:
            headerView.categoryLabel.text = "Erro"
        }
        return headerView
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0 && segControl.selectedSegmentIndex == 0 {
            return false
        }
        
        return true
    }
    
    //MARK: - Abreviar numero
    func suffixNumber(number:NSNumber) -> NSString {
        
        var num:Double = number.doubleValue;
        let sign = ((num < 0) ? "-" : "" );
        
        num = fabs(num);
        
        if (num < 1000.0){
            return "\(sign)\(num)";
        }
        
        let exp:Int = Int(log10(num) / log10(1000));
        
        let units:[String] = ["K","M","G","T","P","E"];
        
        let roundedNum:Double = round(10 * num / pow(1000.0,Double(exp))) / 10;
        
        return "\(sign)\(roundedNum)\(units[exp-1])";
    }


    //MARK: Salon Detail Delegate Method
    func reloadDataOfTable() {
        print("---- SALONDETAIL DELEGATE METHOD ---------")
        
        self.servicesByCategoryArray = (self.hbSalonDetail?.servicesArray)!
        self.tableView.reloadData()
    }
    
    func reloadComments() {
        self.commentsArray = (self.hbSalonDetail?.commentsArray)!
        self.tableView.reloadData()
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "scheduleSegue" {
            
            if SmokeUser.sharedInstance.currentUser() == nil {
                let loginViewController = UIStoryboard(name: "Login", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("loginViewController")
                presentViewController(loginViewController, animated: true, completion: nil)
                return false
            } else {
                return true
            }
        }
        
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "scheduleSegue" {
            
            let indexPath = tableView.indexPathForSelectedRow
            let service = servicesByCategoryArray[indexPath!.section-1][indexPath!.row]
            
            //coloca serviço e salao na singleton appointment
            HBAppointment.sharedInstance.service = service
            HBAppointment.sharedInstance.salon = salon
            
            let nextVc = segue.destinationViewController as! HBScheludingTableViewController
            nextVc.serviceName = service.name //name
            let str = NSString(format: "%.2f", service.price!)
            nextVc.servicePrice = "R$ " + (str as String) //price
            nextVc.serviceId = service.id //id
        }
    }

}
