//
//  HBSalonListTableViewController.swift
//  horabella
//
//  Created by Yan Correa Trindade on 10/27/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import HCSStarRatingView
import CoreLocation
import AlamofireImage
import Alamofire

class HBSalonListTableViewController: UITableViewController,UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, CLLocationManagerDelegate, HBSalonListDelegate {
    
    var salonArray = Array<HBSalon>()
    
    var endPoint = "http://ec2-54-233-79-138.sa-east-1.compute.amazonaws.com/api/v1/shop"
    var searchController = UISearchController(searchResultsController: nil)
    var salaoNome = "Helio Diff Hair Design"
    //LocationManager variables
    var locationManager = CLLocationManager()
    var coordinates: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    //Request Class Variable
    var salonList: HBSalonList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Search Controller Settings
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = false
        navigationItem.titleView = searchController.searchBar
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //clear array
        CurrentHBSalonList.sharedInstance.HBSalonArray.removeAll()
        salonArray.removeAll()
        
        //configurações de localização
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 20
        
        //carregar lista de saloes
        self.salonList = HBSalonList(latitude: coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
        self.salonList?.delegate = self
        
        //NavBar Button depends if the filters are ON or OFF
        let filterButton = UIBarButtonItem(image: UIImage(named: "filterButtonOFF")!.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: Selector("FilterBarButton"))
        self.navigationItem.rightBarButtonItem = filterButton
        
        //atualiza a tabela
        self.tableView.reloadData()
    }
    
    //MARK: Search Bar Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        salaoNome = searchString!
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        //self.navigationItem.rightBarButtonItem.
        print("comecouuuu")
    }
    
    
    //MARK: Filter Bar Button
    func FilterBarButton() {
        //observer pra quando a tela de filtro sumir
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: Selector("didDismissFilterViewControlller:"),
            name: "didDismissFilterViewControlller",
            object: nil)
        
        self.performSegueWithIdentifier("feedToFilter", sender: self)
    }
    
    func didDismissFilterViewControlller(sender: NSNotification){
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salonArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("salonCell", forIndexPath: indexPath) as! HBSalonListTableViewCell

        // Configure the cell...
        if salonArray.count > 0 {
            let salon = salonArray[indexPath.row]
            cell.salonName.text = salon.name
            cell.salonAddress.text = salon.address
            cell.salonEvaluation.value = CGFloat(salon.rate!)
            let str = String(format: "%.1f", salon.distanceToUser!/1000)
            cell.salonDistance.text = str + " KM"
            cell.salonFavorite.selected = false
            
            //download the salon image 0
            if salon.images?.count > 0 {
                Alamofire.request(.GET, salon.images![0])
                    .responseImage { response in
                        if let image = response.result.value {
                            //print("image downloaded: \(image)")
                            cell.salonImage.image = image
                            salon.firstImage = image
                        }
                }

            }
        }
        
        return cell
    }
    
    //MARK: CLLocationDelegate Methods
    //funçao que retorna a localizacao atual do celular
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as Array<CLLocation>
        coordinates = locationArray.last! as CLLocation
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
        print("Falha na localização")
        
        //AlertView se o GPS estiver off e abre a tela de Configurações
        /*let alert = UIAlertController(title: "Permissão de GPS", message: "Vá as configurações do aparelho e autorize o uso de GPS.", preferredStyle:.Alert)
        let defaultAction = UIAlertAction(title: "Configurações", style: .Cancel) { (alert: UIAlertAction!) -> Void in
            UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
        }
        alert.addAction(defaultAction)
        presentViewController(alert, animated: true, completion:nil)*/
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var coreLocationStatus = "";
        
        switch (status) {
        case .Restricted:
            coreLocationStatus = "Permissão alterada para Restricted"
            break
        case .Denied:
            coreLocationStatus = "Permissão alterada para Denied"
            break
        case .AuthorizedAlways:
            coreLocationStatus = "Permissão alterada para AuthorizedAlways"
            break
        case .AuthorizedWhenInUse:
            coreLocationStatus = "Permissão alterada para AuthorizedWhenInUse"
            break
        default:
            print("\(status)")
        }
        print("\(coreLocationStatus)")
    }

    //MARK: Salon List Delegate Methods
    func reloadDataOfTable() {
        print("------- Salon List Delegate Method Accessed -------")
        
        let mySalonArray = CurrentHBSalonList.sharedInstance.HBSalonArray
        
        //calculate the distance between user and salon
        for salon in mySalonArray {
            let distancia = self.calculateDistanceToUser(salon.location!)
            salon.distanceToUser = distancia
        }
        
        //sort by distance
        self.salonArray = mySalonArray.sort({$0.distanceToUser < $1.distanceToUser})
        CurrentHBSalonList.sharedInstance.HBSalonArray = self.salonArray
        
        //self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesInRange: range)
        self.tableView.reloadSections(sections, withRowAnimation: .Automatic)
    }
    
    //MARK: Calculate Distance Between Salon x User Location
    func calculateDistanceToUser(location: CLLocation) -> Double {
        let distanceMeters = location.distanceFromLocation(self.coordinates)
        let distanceKM = distanceMeters / 1000
        let roundedOneDigit = distanceKM.roundedOneDigit
        return roundedOneDigit
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "salonDetailSegue" {
            let vc = segue.destinationViewController as! HBSalonDetailTableViewController
            //passa index do salao clicado para tela de detalhes
            if let indexPath = self.tableView.indexPathForSelectedRow{
                vc.salon = CurrentHBSalonList.sharedInstance.HBSalonArray[indexPath.row]
            }
        }
    }
    
}

extension Double{
    var roundedOneDigit:Double{
        return Double(round(10*self)/10)
    }
}


