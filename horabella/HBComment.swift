//
//  HBComment.swift
//  horabella
//
//  Created by Erick Leal on 27/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import SwiftyJSON

class HBComment: NSObject {

    var id: Int?
    var fullName: String?
    var comment: String?
    var date: String?
    var picture: String?
    
    init(id: Int, fullName: String, comment: String, date: String, picture: String) {
        self.id = id
        self.fullName = fullName
        self.comment = comment
        self.date = date
        self.picture = picture
        
        super.init()
    }
    
    init(json: JSON) {
        self.id = json["id"].intValue
        
        let userJson = json["user"]
        
        print(json)
        print(userJson)
        
        self.fullName = userJson["first_name"].stringValue + " " + userJson["last_name"].stringValue
        self.comment = json["comment"].stringValue
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = formatter.dateFromString(json["created_at"].stringValue) {
            formatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
            self.date = formatter.stringFromDate(date)
        }
        
        self.picture = userJson["picture"].stringValue
        
        super.init()
    }
    
}
