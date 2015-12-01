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

class HBSalonListTableViewController: UITableViewController,UISearchControllerDelegate, UISearchBarDelegate, CLLocationManagerDelegate, HBSalonListDelegate, UITabBarControllerDelegate {
    
    var salonArray = Array<HBSalon>()
    
    var endPoint = "http://ec2-54-233-79-138.sa-east-1.compute.amazonaws.com/api/v1/shop"
    var searchController = UISearchController(searchResultsController: nil)
    //LocationManager variables
    var locationManager = CLLocationManager()
    var coordinates: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    //Request Class Variable
    var salonList: HBSalonList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //observer pra quando a tela de filtro sumir
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: Selector("didDismissFilterViewControlller:"),
            name: "didDismissFilterViewControlller",
            object: nil)
        
        //Search Controller Settings
        //searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Salão, Endereço"
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = false
        navigationItem.titleView = searchController.searchBar
        
        self.tabBarController?.delegate = self
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.searchController.active = false
    }
    
    //MARK: Search Bar Delegate Methods
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print(searchBar.text)
        if searchBar.text != "" {
            if let info = searchBar.text {
                self.salonList!.search(info, latitude: coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
            }
        }else{
            salonList?.searchByLocation(coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        if searchBar.text == nil {
            salonList?.searchByLocation(coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
        }
    }
    
    //MARK: Filter Bar Button
    func FilterBarButton() {
        self.performSegueWithIdentifier("feedToFilter", sender: self)
    }
    
    func didDismissFilterViewControlller(sender: NSNotification){
        if HBFilter.sharedInstance.filtersArray.contains("6") || HBFilter.sharedInstance.filtersArray.contains("7"){
            
            salonList?.searchByLocation(coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
            
        }else if HBFilter.sharedInstance.filtersArray.count > 0 {
            salonList?.searchByCategoriesAndLocation(HBFilter.sharedInstance.filtersArray, latitude: coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
        }else{
            salonList?.searchByLocation(coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
        }
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
            salon.distanceToUser = self.calculateDistanceToUser(salon.location!)
        }
        
        //sort by distance
        self.salonArray = mySalonArray.sort({$0.distanceToUser <= $1.distanceToUser})
        CurrentHBSalonList.sharedInstance.HBSalonArray = self.salonArray
        
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)

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
    
    //MARK: TabBarController Delegate Method
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        self.searchController.active = false
    }
    
}

extension Double{
    var roundedOneDigit:Double{
        return Double(round(10*self)/10)
    }
}


