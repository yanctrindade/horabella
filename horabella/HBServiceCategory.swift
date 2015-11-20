//
//  HBService.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/20/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import SwiftyJSON

class HBServiceCategory: NSObject {
    
    let id: Int?
    let name: String?
    
    init (json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}
