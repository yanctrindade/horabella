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
    
    init (json: JSON) {
        self.scheduleTime = json["schedule_time"].stringValue
        
        //self.service = HBService(json: json["service"])
        self.service = HBService(json: json["service"], withShop: true)
        
        self.professional = HBProfessional(json: json["professional"])
    }
}
