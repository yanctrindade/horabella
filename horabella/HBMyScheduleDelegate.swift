//
//  HBMyScheduleDelegate.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/25/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol HBMyScheduleDelegate {
    func reloadDataOfTable()
}

class HBMySchedule: NSObject {
    var delegate: HBMyScheduleDelegate?
    var endPoint = "http://ec2-54-233-79-138.sa-east-1.compute.amazonaws.com/api/v1/user/appointments"
    var myAppointmentsArray = Array<HBMyAppointment>()
    
    override init() {
        super.init()
        
        print("------- HBMYSCHEDULE DELEGATE START -------")
        
        Smoke().getWithParameters(endpoint: endPoint, successBlock: { (response) -> Void in
            
            let json = JSON(data: response.data!)
            
            for appointment in json.arrayValue {
                let myAppointment = HBMyAppointment(json: appointment)
                self.myAppointmentsArray.append(myAppointment)
            }
            
            self.delegate?.reloadDataOfTable()
            
            }) { (response) -> Void in
                print("-- ERROR MYSCHEDULE DELEGATE --")
        }
    }
}
