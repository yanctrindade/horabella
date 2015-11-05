//
//  SmokeUser.swift
//  horabella
//
//  Created by Erick Leal on 04/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import Alamofire
import SimpleKeychain

class SmokeUser: NSObject {
    
    static var sharedInstance = SmokeUser()
    
    var firstName: String!
    var lastName: String!
    var email: String!
    var phone: String!
    var birthDate: NSDate!
    var password: String!
    
    func currentUser() -> SmokeUser? {
        
        if (getToken() != nil) {
            return SmokeUser.sharedInstance
        }else{
            return nil
        }
        
    }
    
    func getToken() -> String? {
        
        if let token = A0SimpleKeychain().stringForKey("userToken"){
            return token
        }else{
            return nil
        }
        
    }
    
    func saveToken(token: String) -> Void{
        A0SimpleKeychain().setString(token, forKey:"userToken")
        if let token = A0SimpleKeychain().stringForKey("userToken"){
            print(token)
        }
    }
    
    func loginWithEmailAndPassword(email: String, password: String, successBlock: Response<AnyObject, NSError> -> Void, errorBlock: Response<AnyObject, NSError> -> Void) -> Bool {
        
        Smoke().postWithParameters("http://ec2-54-233-79-138.sa-east-1.compute.amazonaws.com/api/v1/user/login", parameters: ["email": email, "password": password], successBlock: { (response) -> Void in
            
            do{ //transforma JSON recebido em dicionario para guardar o token
                if let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? [String: String]{
                    
                    if let token = jsonDictionary["token"]{
                        //guarda o token
                        SmokeUser().saveToken(token)
                        
                        //guarda usuario na singleton
                        
                    }else{
                        print("token nao encontrado na JSON devolvido")
                    }
                    
                }
            }catch{
                print("erro para transformar JSON em dicionario")
            }
            
            successBlock(response)
            print("deu certo!")
            
            }) { (response) -> Void in
                
                errorBlock(response)
                print("deu errado!")
                
        }
        
        return true
    }
    
    func signUp(successBlock: Response<AnyObject, NSError> -> Void, errorBlock: Response<AnyObject, NSError> -> Void) -> Bool {
        
        Smoke().postWithParameters("http://ec2-54-233-79-138.sa-east-1.compute.amazonaws.com/api/v1/user", parameters: ["first_name": firstName, "last_name": lastName, "email": email, "password": password], successBlock: { (response) -> Void in
            
            successBlock(response)
            
            }) { (response) -> Void in
            
                errorBlock(response)
        
        }
        
        return true
    }

}
