//
//  HBSalon.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import CoreLocation

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
    }
    

}
