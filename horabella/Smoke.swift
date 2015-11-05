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
    
    func postWithParameters(endpoint: String, parameters: Dictionary<String, String>, successBlock: Response<AnyObject, NSError> -> Void, errorBlock: Response<AnyObject, NSError> -> Void) -> Bool {
        
        Alamofire.request(.POST, endpoint, parameters: parameters)
            .validate() //validaçao automatica 200...299
            .responseJSON { (response) -> Void in
                
                switch response.result {
                case .Success:
                    successBlock(response)
                    print("Validation Successful")
                case .Failure(let error):
                    errorBlock(response)
                    print(error)
                }
                
        }
        
        return true
    }


}
