//
//  HBService.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/20/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import SwiftyJSON

class HBService: NSObject {
    
    let id: Int?
    let name: String?
    let price: Double?
    let serviceDescription: String?
    let estimatedTime: Int?
    let category_id: Int?
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.price = json["price"].doubleValue
        self.serviceDescription = json["description"].stringValue
        self.estimatedTime = json["estimated_time"].intValue
        self.category_id = json["category_id"].intValue
        super.init()
    }
    
    init(json: JSON, offer: Bool) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.price = json["price"].doubleValue
        self.serviceDescription = json["description"].stringValue
        self.estimatedTime = json["estimated_time"].intValue
        let dictionary = json["category"].dictionaryValue
        self.category_id = dictionary["id"]?.intValue
        super.init()
    }
}
