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
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = true
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
        if (1 == 2) {
            let filterButton = UIBarButtonItem(image: UIImage(named: "filterButtonON")!.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: Selector("FilterBarButton"))
            self.navigationItem.rightBarButtonItem = filterButton
        } else {
            let filterButton = UIBarButtonItem(image: UIImage(named: "filterButtonOFF")!.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: Selector("FilterBarButton"))
            self.navigationItem.rightBarButtonItem = filterButton
        }
        
        //atualiza a tabela
        self.tableView.reloadData()
    }
    
    //MARK: Search Bar Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        salaoNome = searchString!
        self.tableView.reloadData()
    }
    
    
    //MARK: Filter Bar Button
    func FilterBarButton() {
        self.performSegueWithIdentifier("feedToFilter", sender: self)
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
        let alert = UIAlertController(title: "Permissão de GPS", message: "Vá as configurações do aparelho e autorize o uso de GPS.", preferredStyle:.Alert)
        let defaultAction = UIAlertAction(title: "Configurações", style: .Cancel) { (alert: UIAlertAction!) -> Void in
            UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
        }
        alert.addAction(defaultAction)
        presentViewController(alert, animated: true, completion:nil)
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
        
        salonArray = CurrentHBSalonList.sharedInstance.HBSalonArray
        
        self.tableView.reloadData()
    }
}


