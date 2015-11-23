//
//  HBSalonDetailDelegate.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/20/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol HBSalonDetailDelegate {
    func reloadDataOfTable()
}

class HBSalonDetail: NSObject {
    var delegate: HBSalonDetailDelegate?
    var endPoint = "http://ec2-54-233-79-138.sa-east-1.compute.amazonaws.com/api/v1/shop/"
    var servicesArray = Array<Array<HBService>>(count: 6, repeatedValue: [])
    
    
    init(idSalon: Int) {
        super.init()
        
        print(" ----- HBSALONDETAIL DELEGATE START ------")
        
        Smoke().getWithParameters(endpoint: endPoint + String(idSalon) + "/services", successBlock: {
            (response) -> Void in
            let json = JSON(data: response.data!)
            
            //novo request
            for (key, subJson):(String,JSON) in json {
                let subJsonArray = subJson.arrayValue //array de json de servicos
                for service in subJsonArray {
                    let newService = HBService(json: service)
                    self.servicesArray[Int(key)!-1].append(newService)
                }
            }
            
            print(" ----- HBSALONDETAIL DELEGATE END ------")
            self.delegate?.reloadDataOfTable()
            //error block
            }) { (response) -> Void in
                print("---- ERRO NA BUSCA DE SERVIÇOS DO SALÃO ----")
            }
        
        
    }
}
