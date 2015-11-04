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
    
    func loginWithEmailAndPassword(email: String, password: String, successBlock: Response<AnyObject, NSError> -> Void, errorBlock: Response<AnyObject, NSError> -> Void) -> Bool {
        
        Smoke().postWithParameters("http://ec2-54-233-79-138.sa-east-1.compute.amazonaws.com/api/authenticate", parameters: ["email": email, "password": password], successBlock: { (response) -> Void in
            
            do{ //transforma JSON recebido em dicionario para guardar o token
                if let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? [String: String]{
                    
                    if let token = jsonDictionary["token"]{
                        //guarda o token
                        A0SimpleKeychain().setString(token, forKey:"userToken")
                        
                    }else{
                        print("token nao encontrado na JSON devolvido")
                    }
                    
                    //le e imprime o token
//                    let token = A0SimpleKeychain().stringForKey("userToken")
//                    print(token)
                    
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

}
