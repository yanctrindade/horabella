//
//  Smoke.swift
//  horabella
//
//  Created by Erick Leal on 03/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import Alamofire
import SimpleKeychain

class Smoke: NSObject {
    
    func postWithParameters(withToken: Bool = false, endpoint: String, parameters: Dictionary<String, AnyObject>, successBlock: Response<AnyObject, NSError> -> Void, errorBlock: Response<AnyObject, NSError> -> Void) -> Void {
        
        var headers = [String: String]()
        
        //adiciona token como header para validaçao
        if withToken {
            
            if let token = SmokeUser().getToken() {
                let authorization: String = "Bearer " + token
                
                headers = ["Authorization": authorization]
                
            }
            
        }
        
        Alamofire.request(.POST, endpoint, parameters: parameters, headers: headers)
            .validate() //validaçao automatica 200...299
            .responseJSON { (response) -> Void in
                
                switch response.result {
                case .Success:
                    successBlock(response)
                case .Failure(let error):
                    errorBlock(response)
                    print(error)
                }
                
        }
    }
    
    func getWithParameters(withToken: Bool = true, endpoint: String, parameters: Dictionary<String, AnyObject>? = nil, successBlock: Response<AnyObject, NSError> -> Void, errorBlock: Response<AnyObject, NSError> -> Void) -> Void {
        
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
                case .Failure(let error):
                    errorBlock(response)
                    print(error)
                }
        }
        
    }
    
    func deleteWithParameters(withToken: Bool = true, endpoint: String, parameters: Dictionary<String, AnyObject>? = nil, successBlock: Response<AnyObject, NSError> -> Void, errorBlock: Response<AnyObject, NSError> -> Void) -> Void {
        
        var headers = [String: String]()
        
        //adiciona token como header para validaçao
        if withToken {
            
            if let token = SmokeUser().getToken() {
                let authorization: String = "Bearer " + token
                
                headers = ["Authorization": authorization]
                
            }
            
        }
        
        Alamofire.request(.DELETE, endpoint, parameters: parameters, headers: headers)
            .validate() //validaçao automatica 200...299
            .responseJSON { (response) -> Void in
                
                switch response.result {
                case .Success:
                    successBlock(response)
                case .Failure(let error):
                    errorBlock(response)
                    print(error)
                }
        }
        
    }
    
    //MARK: data to dictionary
    func dataToDictionary(data: NSData) -> NSDictionary? {
        do{ //transforma data JSON recebido em dicionario
            if let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                
                return jsonDictionary
                
            }
        }catch{
            print("erro para transformar JSON em dicionario")
        }
        return nil
    }
    
    //MARK: data to array of dictionaries
    func dataToArrayOfDictionaries(data: NSData) -> Array<Dictionary<String,AnyObject>>? {
        do{ //transforma data JSON recebido em array de dicionario
            if let jsonArrayOfDictionaries = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? Array<Dictionary<String,AnyObject>>{
                
                return jsonArrayOfDictionaries
                
            }
        }catch let Error{
            print(Error)
            print("erro para transformar JSON em array")
        }
        return nil
    }


}
