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
    
    var firstName: String!
    var lastName: String!
    var email: String!
    var gender: String!
    var phone: String!
    var birthDate: String!
    var pictureURL: String!
    var points: String!
    var password: String!
    
    //flag para indicar quando o usuario está sendo atualizado
    var isCurrentUser: Bool! = false
    
    
    //MARK: - Singleton
    
    class var sharedInstance: SmokeUser {
        struct Singleton {
            static let instance = SmokeUser()
        }
        return Singleton.instance
    }
    
    //retorna infos do usuario
    func currentUser() -> SmokeUser? {
        
        if (getToken() != nil) {
            return SmokeUser.sharedInstance
        }else{
            return nil
        }
        
    }
    
    //MARK: - Token
    
    //retorna token de autenticaçao
    func getToken() -> String? {
        
        //let kc = A0SimpleKeychain()
        //kc.useAccessControl = true
        
        if let token = A0SimpleKeychain().stringForKey("horabella_user_token"){
            return token
        }else{
            return nil
        }
        
    }
    
    //guarda token
    func saveToken(token: String) -> Void{
        
        //let kc = A0SimpleKeychain()
        //kc.useAccessControl = true
        
        A0SimpleKeychain().setString(token, forKey:"horabella_user_token")
        
        print(A0SimpleKeychain().stringForKey("horabella_user_token"))

    }
    
    //remove token
    func removeToken() -> Void {
        let kc = A0SimpleKeychain()
        //kc.useAccessControl = true
        
        kc.deleteEntryForKey("horabella_user_token")
    }
    
    
    //MARK: - User
    
    func loginWithEmailAndPassword(email: String, password: String, successBlock: (Response<AnyObject, NSError> -> Void)? = nil, errorBlock: (Response<AnyObject, NSError> -> Void)? = nil) -> Bool {
        
        Smoke().postWithParameters(endpoint: "http://horabella.com.br/api/v1/user/login", parameters: ["email": email, "password": password], successBlock: { (response) -> Void in
            
            if let jsonDictionary = self.dataToDictionary(response.data!){
                
                if let token = jsonDictionary["token"] as? String{
                    //guarda o token
                    self.saveToken(token)
                    
                    //guarda usuario na singleton
                    self.fetch()
                    
                }else{
                    print("token nao encontrado no JSON devolvido")
                }
                
            }

            //executa bloco caso exista
            if let block = successBlock {
                block(response)
            }
            
            }) { (response) -> Void in
                
                //executa bloco caso exista
                if let block = errorBlock {
                    block(response)
                }
                
        }
        
        return true
    }
    
    //atualiza infos do usuario na singleton
    func fetch(successBlock: (Response<AnyObject, NSError> -> Void)? = nil, errorBlock: (Response<AnyObject, NSError> -> Void)? = nil) -> Void {
        
        SmokeUser.sharedInstance.isCurrentUser = false
        
        Smoke().getWithParameters(endpoint: "http://horabella.com.br/api/v1/user/fetch", parameters: nil, successBlock: { (response) -> Void in
            
            //seta informaçoes para a singleton do usuario
            if let jsonDictionary = self.dataToDictionary(response.data!){
            
                if let user = jsonDictionary["user"] {
                    if let info = user["first_name"]{
                        SmokeUser.sharedInstance.firstName = info as! String
                    }
                    
                    if let info = user["last_name"]{
                        SmokeUser.sharedInstance.lastName = info as! String
                    }
                    
                    if let info = user["email"]{
                        SmokeUser.sharedInstance.email = info as! String
                    }
                    
                    if let info = user["gender"]{
                        SmokeUser.sharedInstance.gender = info as! String
                    }
                    
                    if let info = user["phone"]{
                        SmokeUser.sharedInstance.phone = info as! String
                    }
                    
                    if let info = user["picture"]{
                        SmokeUser.sharedInstance.pictureURL = info as! String
                    }
                    
                    if let info = user["birthday"]{
                        SmokeUser.sharedInstance.birthDate = info as! String
                    }
                    
                    if let info = user["points"]{
                        SmokeUser.sharedInstance.points = info as! String
                    }
                    
                    SmokeUser.sharedInstance.isCurrentUser = true
                    
                }
                
            }
            
            //executa bloco caso exista
            if let block = successBlock {
                block(response)
            }
            }) { (response) -> Void in
                
                //executa bloco caso exista
                if let block = errorBlock {
                    block(response)
                }
                
                SmokeUser().removeToken()
                
        }
        
    }
    
    func signUp(successBlock: Response<AnyObject, NSError> -> Void, errorBlock: Response<AnyObject, NSError> -> Void) -> Void {
        
        Smoke().postWithParameters(endpoint: "http://horabella.com.br/api/v1/user", parameters: ["first_name": firstName, "last_name": lastName, "email": email, "password": password], successBlock: { (response) -> Void in
            
            successBlock(response)
            
            }) { (response) -> Void in
            
                errorBlock(response)
        
        }
    }
    
    func resetPassword(email: String, successBlock: (Response<AnyObject, NSError> -> Void)? = nil, errorBlock: (Response<AnyObject, NSError> -> Void)? = nil) -> Void {
        
        Smoke().postWithParameters(endpoint: "http://horabella.com.br/api/v1/user/password/email", parameters: ["email": email], successBlock: { (response) -> Void in
            
            //executa bloco caso exista
            if let block = successBlock {
                block(response)
            }
            
            }) { (response) -> Void in
                
                //executa bloco caso exista
                if let block = errorBlock {
                    block(response)
                }
                
        }
    }
    
    func logOut() -> Void{
        
        SmokeUser().removeToken()
        SmokeUser().removeUser()
        
    }
    
    func removeUser(){
        SmokeUser.sharedInstance.firstName = nil
        SmokeUser.sharedInstance.lastName = nil
        SmokeUser.sharedInstance.email = nil
        SmokeUser.sharedInstance.gender = nil
        SmokeUser.sharedInstance.phone = nil
        SmokeUser.sharedInstance.birthDate = nil
        SmokeUser.sharedInstance.password = nil
        SmokeUser.sharedInstance.isCurrentUser = false
    }
    
    //MARK: - Data to Dictionary
    
    func dataToDictionary(data: NSData) -> NSDictionary? {
        do{ //transforma data JSON recebido em dicionario para guardar o token
            if let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                
                return jsonDictionary
                
            }
        }catch{
            print("erro para transformar JSON em dicionario")
        }
        return nil
    }

}
