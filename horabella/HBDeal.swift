//
//  HBDeal.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/23/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import SwiftyJSON

class HBDeal: NSObject {
    var id: Int?
    var dealDescription: String?
    var discount: Float?
    var shop: HBSalon?
    var service: HBService?
    
    init(json: JSON) {
        self.shop = HBSalon(json: json)
        
        var deal = json["offers"].arrayValue.first?.dictionaryValue
        self.id = deal!["id"]!.intValue
        self.dealDescription = deal!["description"]!.stringValue
        self.discount = deal!["discount"]!.floatValue
        
        //self.service = HBService(json: deal!["service"]!)
        self.service = HBService(json: deal!["service"]!, withShop: true)
        
        super.init()
    }
    
}
