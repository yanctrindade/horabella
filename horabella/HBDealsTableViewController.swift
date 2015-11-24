//
//  DealsTableViewController.swift
//  horabella
//
//  Created by Yan Correa Trindade on 10/29/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import CoreLocation

class HBDealsTableViewController: UITableViewController, HBDealDelegate, CLLocationManagerDelegate {
    
    var dealsArray = Array<HBDeal>()
    
    var hbDeals: HBDeals?
    
    var coordinates: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        hbDeals = HBDeals(latitude: coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
        hbDeals?.delegate = self
        
        //configurações de localização
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 20
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dealsArray.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("discountCell", forIndexPath: indexPath) as! HBDealsTableViewCell
        
        // Configure the cell...
        if (self.dealsArray.count > 0) {
            cell.percentageLabel.text = String(Int(self.dealsArray[indexPath.section].discount!)) + "%"
            cell.descriptionLabel.text = self.dealsArray[indexPath.section].dealDescription
            if indexPath.section%2 != 0 {
                cell.backgroundColor = UIColor.greenColor()
            }
        } else {
            cell.percentageLabel.text = "FALHA"
            cell.descriptionLabel.text = "ao carregar ofertas"
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCellWithIdentifier("sectionHeader") as!HBSectionHeaderTableViewCell
        headerView.salonNameLabel.text = self.dealsArray[section].shop?.name
        return headerView;
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


    func reloadDataOfTable() {
        print("-------- HBDEAL DELEGATE METHOD ACCESSED -------")
        
        self.dealsArray = (self.hbDeals?.dealsArray)!
        
        self.tableView.reloadData()
    }
}
