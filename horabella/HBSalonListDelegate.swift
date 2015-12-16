//
//  HBSalonListDelegate.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

protocol HBSalonListDelegate {
    func reloadDataOfTable()
}

class HBSalonList: NSObject {
    var delegate: HBSalonListDelegate?
    var endPointLocate = "http://horabella.com.br/api/v1/shop/locate"
    var endPointSearch = "http://horabella.com.br/api/v1/shop/search"
    var endPointFilter = "http://horabella.com.br/api/v1/shop/filter"
    
    init(latitude: Double, longitude: Double) {
        super.init()
        //faz a requisição e monta o array
        print(" -------  Requisição Feeds de Salões START ----------- ")
        
        var parameters = Dictionary<String,String>()
        parameters["radius"] = "10000"
        parameters["latitude"] = String(latitude)
        parameters["longitude"] = String(longitude)
        
        //montar endPoints String
        Smoke().getWithParameters(false, endpoint: endPointLocate, parameters: parameters, successBlock: {
            (response) -> Void in
            
            let shopArray = Smoke().dataToArrayOfDictionaries(response.data!)
            
            if shopArray != nil {
                for shop in shopArray! {
                    let address = shop["address"] as! String
                    let comment = Int(shop["comments"]! as! String)
                    let evaluations = Int(shop["evaluations"]! as! String)
                    let id = Int(shop["id"]! as! String)
                    let likes = Int(shop["likes"]! as! String)
                    let location = self.stringToCLLocation(shop["location"]! as! String)
                    let name = shop["name"]! as! String
                    let phone = shop["phone"]! as! String
                    let rate = Double(shop["rate"]! as! String)
                    let website = shop["website"]! as! String
                    let arrayDictionaryImage = shop["images"] as! Array<Dictionary<String,String>>
                    let description = shop["description"] as! String
                   
                    var imagesArray = Array<String>()
                    for dictionary in arrayDictionaryImage {
                        let url = dictionary["url"]! as String
                        imagesArray.append(url)
                    }
                    
                    let newSalon = HBSalon(address: address, comments: comment!, evaluations: evaluations!, id: id!, likes: likes!, location: location, name: name, phone: phone, rate: rate!, website: website, images: imagesArray, description: description)
                    
                    CurrentHBSalonList.sharedInstance.HBSalonArray.append(newSalon)
                }
            }
            
            print(" ------- Encontrados: \(CurrentHBSalonList.sharedInstance.HBSalonArray.count) salões -------")
            
            self.delegate?.reloadDataOfTable()
            }) {
                (response) -> Void in
                print(response)
                print(" ------- Falha na Busca de Salões END -------")
        }
        
    }
    
    func stringToCLLocation(locationString: String) -> CLLocation {
        let locationArray = locationString.characters.split{$0 == ","}.map(String.init)
        let location = CLLocation(latitude: Double(locationArray[0])!, longitude: Double(locationArray[1])!)
        return location
    }
    
    func search (searchText: String, latitude: Double, longitude: Double) {
        print(" -------  Requisição Search Bar START ----------- ")
        
        CurrentHBSalonList.sharedInstance.HBSalonArray.removeAll() //clear the array
        
        var parameters = Dictionary<String,String>()
        parameters["radius"] = "10000"
        parameters["latitude"] = String(latitude)
        parameters["longitude"] = String(longitude)
        parameters["q"] = searchText //typed by the user
        
        Smoke().getWithParameters(true, endpoint: endPointSearch, parameters: parameters, successBlock: {
            (response) -> Void in
            
            let shopArray = Smoke().dataToArrayOfDictionaries(response.data!)
            
            if shopArray != nil {
                for shop in shopArray! {
                    let address = shop["address"] as! String
                    let comment = Int(shop["comments"]! as! String)
                    let evaluations = Int(shop["evaluations"]! as! String)
                    let id = Int(shop["id"]! as! String)
                    let likes = Int(shop["likes"]! as! String)
                    let location = self.stringToCLLocation(shop["location"]! as! String)
                    let name = shop["name"]! as! String
                    let phone = shop["phone"]! as! String
                    let rate = Double(shop["rate"]! as! String)
                    let website = shop["website"]! as! String
                    let arrayDictionaryImage = shop["images"] as! Array<Dictionary<String,String>>
                    let description = shop["description"] as! String
                    
                    var imagesArray = Array<String>()
                    for dictionary in arrayDictionaryImage {
                        let url = dictionary["url"]! as String
                        imagesArray.append(url)
                    }
                    
                    let newSalon = HBSalon(address: address, comments: comment!, evaluations: evaluations!, id: id!, likes: likes!, location: location, name: name, phone: phone, rate: rate!, website: website, images: imagesArray, description: description)
                    
                    CurrentHBSalonList.sharedInstance.HBSalonArray.append(newSalon)
                }
            }
            
            print(" ------- Encontrados: \(CurrentHBSalonList.sharedInstance.HBSalonArray.count) salões -------")
            
            self.delegate?.reloadDataOfTable()

            }) { (response) -> Void in
                print("deu merda")
                
        }
    }
    
    func searchByLocation(latitude: Double, longitude: Double) {
        
        CurrentHBSalonList.sharedInstance.HBSalonArray.removeAll() //clear the array
        
        //faz a requisição e monta o array
        print(" -------  Requisição Feeds de Salões START ----------- ")
        
        var parameters = Dictionary<String,String>()
        parameters["radius"] = "10000"
        parameters["latitude"] = String(latitude)
        parameters["longitude"] = String(longitude)
        
        //montar endPoints String
        Smoke().getWithParameters(false, endpoint: endPointLocate, parameters: parameters, successBlock: {
            (response) -> Void in
            
            let shopArray = Smoke().dataToArrayOfDictionaries(response.data!)
            
            if shopArray != nil {
                for shop in shopArray! {
                    let address = shop["address"] as! String
                    let comment = Int(shop["comments"]! as! String)
                    let evaluations = Int(shop["evaluations"]! as! String)
                    let id = Int(shop["id"]! as! String)
                    let likes = Int(shop["likes"]! as! String)
                    let location = self.stringToCLLocation(shop["location"]! as! String)
                    let name = shop["name"]! as! String
                    let phone = shop["phone"]! as! String
                    let rate = Double(shop["rate"]! as! String)
                    let website = shop["website"]! as! String
                    let arrayDictionaryImage = shop["images"] as! Array<Dictionary<String,String>>
                    let description = shop["description"] as! String
                    
                    var imagesArray = Array<String>()
                    for dictionary in arrayDictionaryImage {
                        let url = dictionary["url"]! as String
                        imagesArray.append(url)
                    }
                    
                    let newSalon = HBSalon(address: address, comments: comment!, evaluations: evaluations!, id: id!, likes: likes!, location: location, name: name, phone: phone, rate: rate!, website: website, images: imagesArray, description: description)
                    
                    CurrentHBSalonList.sharedInstance.HBSalonArray.append(newSalon)
                }
            }
            
            print(" ------- Encontrados: \(CurrentHBSalonList.sharedInstance.HBSalonArray.count) salões -------")
            
            self.delegate?.reloadDataOfTable()
            }) {
                (response) -> Void in
                print(response)
                print(" ------- Falha na Busca de Salões END -------")
        }
        
    }
    
    func searchByCategoriesAndLocation(categories: Array<String>, latitude: Double, longitude: Double) {
        
        CurrentHBSalonList.sharedInstance.HBSalonArray.removeAll() //clear the array
        
        //faz a requisição e monta o array
        print(" -------  Requisição Feeds de Salões START ----------- ")
        
        var parameters = Dictionary<String,AnyObject>()
        parameters["radius"] = "10000"
        parameters["latitude"] = String(latitude)
        parameters["longitude"] = String(longitude)
        
        var categoriesArray = Array<Int>()
        
        for category in categories {
            let number = Int(category)! + 1
            categoriesArray.append(number)
        }
        
        parameters["categories"] = categoriesArray
        
        //montar endPoints String
        Smoke().getWithParameters(false, endpoint: endPointFilter, parameters: parameters, successBlock: {
            (response) -> Void in
            
            let shopArray = Smoke().dataToArrayOfDictionaries(response.data!)
            
            if shopArray != nil {
                for shop in shopArray! {
                    let address = shop["address"] as! String
                    let comment = Int(shop["comments"]! as! String)
                    let evaluations = Int(shop["evaluations"]! as! String)
                    let id = Int(shop["id"]! as! String)
                    let likes = Int(shop["likes"]! as! String)
                    let location = self.stringToCLLocation(shop["location"]! as! String)
                    let name = shop["name"]! as! String
                    let phone = shop["phone"]! as! String
                    let rate = Double(shop["rate"]! as! String)
                    let website = shop["website"]! as! String
                    let arrayDictionaryImage = shop["images"] as! Array<Dictionary<String,String>>
                    let description = shop["description"] as! String
                    
                    var imagesArray = Array<String>()
                    for dictionary in arrayDictionaryImage {
                        let url = dictionary["url"]! as String
                        imagesArray.append(url)
                    }
                    
                    let newSalon = HBSalon(address: address, comments: comment!, evaluations: evaluations!, id: id!, likes: likes!, location: location, name: name, phone: phone, rate: rate!, website: website, images: imagesArray, description: description)
                    
                    CurrentHBSalonList.sharedInstance.HBSalonArray.append(newSalon)
                }
            }
            
            print(" ------- Encontrados (CATEGORIA): \(CurrentHBSalonList.sharedInstance.HBSalonArray.count) salões -------")
            
            self.delegate?.reloadDataOfTable()
            }) {
                (response) -> Void in
                print(response)
                print(" ------- Falha na Busca de Salões por categoria END -------")
                print(NSString(data: response.data!, encoding: 4))
                
        }
        
    }
    
    
}
