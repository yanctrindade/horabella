//
//  Smoke.swift
//  horabella
//
//  Created by Erick Leal on 03/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import Alamofire

class Smoke: NSObject {
    
    func postWithParameters(endpoint: String, parameters: Dictionary<String, String>, process: Response<AnyObject, NSError> -> Void) -> Bool {
        
        Alamofire.request(.POST, endpoint, parameters: parameters).responseJSON { (response) -> Void in
            process(response)
        }
        
        return true
    }
    
    func loginWithEmailAndPassword(email: String, password: String, process: Response<AnyObject, NSError> -> Void) -> Bool {
        
        Alamofire.request(.POST, "http://ec2-54-233-79-138.sa-east-1.compute.amazonaws.com/api/authenticate", parameters: ["email": email, "password": password]).responseJSON { (response) -> Void in
            process(response)
        }
        
        return true
    }

}
