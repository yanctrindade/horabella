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
    func reloadAvailableTimes()
}


class HBSchedule: NSObject {
    var delegate: HBScheduleDelegate?
    var endpoint = "http://horabella.com.br/api/v1/service/"
    var endpointAppointments = "http://horabella.com.br/api/v1/appointment/available"
    var professionalsArray = [] as Array<HBProfessional>
    var availableTimesArray = [] as Array<String>
    
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
    
    func getAvailableTimes(day: Int, month: Int, year: Int, professionalId: Int) {
        
        let parameters = [
            "day": day,
            "month": month,
            "year": year,
            "professional_id": professionalId
        ]
        
        Smoke().getWithParameters(endpoint: endpointAppointments, parameters: parameters, successBlock: { (response) -> Void in
            
            //adiciona horarios diponiveis no array
            let json = JSON(data: response.data!)
            
            print(json)
            
            self.availableTimesArray.removeAll()
            
            for hour in json.arrayValue {
                let string = "\(hour)"
                self.availableTimesArray.append(string)
            }
            
            self.delegate?.reloadAvailableTimes()
            
            }) { (response) -> Void in
                self.availableTimesArray.removeAll()
                print("Erro para obter horarios disponiveis")
                print(NSString(data: response.data!, encoding: 4))
                
        }
        
        
    }
    
}
