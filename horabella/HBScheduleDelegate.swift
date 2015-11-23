//
//  HBScheduleDelegate.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/23/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol HBScheduleDelegate {
    func reloadDataOfTable()
}


class HBSchedule: NSObject {
    var delegate: HBScheduleDelegate?
    var endpoint = "http://ec2-54-233-79-138.sa-east-1.compute.amazonaws.com/api/v1/service/"
    var professionalsArray = [] as Array<HBProfessional>
    
    init (idService: Int) {
        super.init()
        
        print("------ HBSCHEDULE DELEGATE START -------")
        
        Smoke().getWithParameters(endpoint: endpoint + String(idService), successBlock: {
            (response) -> Void in
            print("certo")
            
            let json = JSON(data: response.data!)
            
            let professionalsJSONArray = json["professionals"].arrayValue
            
            for professional in professionalsJSONArray {
                let newProfessional = HBProfessional(json: professional)
                
                self.professionalsArray.append(newProfessional)
            }
            
            self.delegate?.reloadDataOfTable()
            
            }) { (response) -> Void in
                print("Error HBSchedule Delegate")
        }
    }
}
