//
//  HBMyAppointment.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/25/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import SwiftyJSON

class HBMyAppointment: NSObject {
    var professional: HBProfessional!
    var service: HBService!
    var scheduleTime: String!
    var id: Int?
    var accepted: Bool?
    var courtesy: Bool?
    
    init (json: JSON) {
        self.scheduleTime = json["schedule_time"].stringValue
        self.id = json["id"].intValue
        self.accepted = json["accepted"].boolValue
        self.courtesy = json["courtesy"].boolValue
        
        self.service = HBService(json: json["service"], withShop: true)
        
        self.professional = HBProfessional(json: json["professional"])
    }
}
