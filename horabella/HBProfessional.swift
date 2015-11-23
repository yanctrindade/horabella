//
//  HBProfessional.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/23/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import SwiftyJSON

class HBProfessional: NSObject {
    
    var gender: String?
    var phone: String?
    var points: Int?
    var id: Int?
    var email: String?
    var firstName: String?
    var lastName: String?
    
    init(json: JSON) {
        self.gender = json["gender"].stringValue
        self.phone = json["phone"].stringValue
        self.points = json["points"].intValue
        self.id = json["id"].intValue
        self.email = json["email"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
    }

}
