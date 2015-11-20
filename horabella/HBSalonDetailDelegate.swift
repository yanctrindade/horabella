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
    var categoriesArray = Array<HBServiceCategory>()
    
    init(idSalon: Int) {
        super.init()
        
        print(" ----- HBSALONDETAIL DELEGATE START ------")
        
        Smoke().getWithParameters(endpoint: endPoint + String(idSalon), successBlock: {
            (response) -> Void in
            let json = JSON(data: response.data!)
            
            //array de json
            let categoriasJSONArray = json["categories"].arrayValue
            
            for category in categoriasJSONArray {
                //manda um pedaço de json que será resolvido/quebrado pelo SwiftyJSON framework
                let newCategory = HBServiceCategory(json: category)
                self.categoriesArray.append(newCategory)
            }
            print(" ----- HBSALONDETAIL DELEGATE END ------")
            self.delegate?.reloadDataOfTable()
            //error block
            }) { (response) -> Void in
                print("deu erro")
            }
        
        
    }
}
