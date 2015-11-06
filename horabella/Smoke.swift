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
    
    func postWithParameters(endpoint: String, parameters: Dictionary<String, String>, successBlock: Response<AnyObject, NSError> -> Void, errorBlock: Response<AnyObject, NSError> -> Void) -> Void {
        
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
    }
    
    func getWithParameters(withToken: Bool = true, endpoint: String, parameters: Dictionary<String, String>? = nil, successBlock: Response<AnyObject, NSError> -> Void, errorBlock: Response<AnyObject, NSError> -> Void) -> Void {
        
        var headers = [String: String]()
        
        //adiciona token como header para validaçao
        if withToken {
            
            if let token = SmokeUser().getToken() {
                let authorization: String = "Bearer " + token
                
                headers = ["Authorization": authorization]
                
            }
            
        }
        
        Alamofire.request(.GET, endpoint, parameters: parameters, headers: headers)
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
        
    }
    
    


}
