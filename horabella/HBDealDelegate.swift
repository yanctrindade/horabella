//
//  HBDealDelegate.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/23/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol HBDealDelegate {
    func reloadDataOfTable()
}

class HBDeals: NSObject {
    var delegate: HBDealDelegate?
    var endPoint = "http://horabella.com.br/api/v1/offer/locate/"
    var dealsArray = [] as Array<HBDeal>
    
    init(latitude: Double, longitude: Double) {
        super.init()
        print("------- HBDEAL DELEGATE START ------")
        
        var parameters = Dictionary<String,String>()
        parameters["radius"] = "10000"
        parameters["latitude"] = String(latitude)
        parameters["longitude"] = String(longitude)
        
        
        Smoke().getWithParameters(true, endpoint: endPoint, parameters: parameters, successBlock: { (response) -> Void in
            let json = JSON(data: response.data!)
            
            let dealsJSONArray = json.arrayValue
            
            for deal in dealsJSONArray {
                let newDeal = HBDeal(json: deal)
                
                self.dealsArray.append(newDeal)
            }
            
            self.delegate?.reloadDataOfTable()
            }) { (response) -> Void in
                print("--- ERROR HBDEALDELEGATE ----")
        }
    }
}
