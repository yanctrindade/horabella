//
//  HBSalon.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class HBSalon: NSObject {
    
    var id: Int?
    var address: String?
    var comments: Int?
    var evaluations: Int?
    var likes: Int?
    var location: CLLocation?
    var name: String?
    var phone: String?
    var rate: Double?
    var website: String?
    var images: Array<String>?
    var distanceToUser: Double?
    var firstImage: UIImage?
    
    init(address: String, comments: Int, evaluations: Int,id: Int, likes: Int, location: CLLocation, name: String, phone: String, rate: Double, website: String, images: Array<String>) {
        self.address = address
        self.comments = comments
        self.evaluations = evaluations
        self.likes = likes
        self.location = location
        self.name = name
        self.phone = phone
        self.rate = rate
        self.website = website
        self.images = images
        self.id = id
        self.distanceToUser = 0.0
        super.init()
    }
    
    init(json: JSON) {
        self.address = json["address"].stringValue
        self.comments = json["comments"].intValue
        self.evaluations = json["evaluations"].intValue
        self.likes = json["likes"].intValue
        let locationString = json["location"].stringValue
        self.location = HBSalon.stringToCLLocation(locationString)
        self.name = json["name"].stringValue
        self.phone = json["phone"].stringValue
        self.rate = json["rate"].doubleValue
        self.website = json["website"].stringValue
        //images
        self.images = Array<String>()
        let jsonArray = json["images"].arrayValue
        for dictionary in jsonArray {
            let url = dictionary["url"].stringValue
            self.images?.append(url)
        }
        self.id = json["id"].intValue
        self.distanceToUser = 0.0
        super.init()
    }
    
    class func stringToCLLocation(locationString: String) -> CLLocation {
        var locationArray = []
        locationArray = locationString.characters.split{$0 == ","}.map(String.init)
        if (locationArray.count == 2) {
            let location = CLLocation(latitude: Double(locationArray[0] as! String)!, longitude: Double(locationArray[1] as! String)!)
            return location
        } else {
            return CLLocation(latitude: Double(0), longitude: Double(0))
        }
    }
}
