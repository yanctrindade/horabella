//
//  HBSalonListDelegate.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import CoreLocation

protocol HBSalonListDelegate {
    func reloadDataOfTable()
}

class HBSalonList: NSObject {
    var delegate: HBSalonListDelegate?
    var endPoint = "http://ec2-54-233-79-138.sa-east-1.compute.amazonaws.com/api/v1/shop/locate"

    init(latitude: Double, longitude: Double) {
        super.init()
        //faz a requisição e monta o array
        print(" -------  Requisição Feeds de Salões START ----------- ")
        
        var parameters = Dictionary<String,String>()
        parameters["radius"] = "10000"
        parameters["latitude"] = String(latitude)
        parameters["longitude"] = String(longitude)
        
        //montar endPoints String
        Smoke().getWithParameters(false, endpoint: endPoint, parameters: parameters, successBlock: {
            (response) -> Void in
            
            print(response)
            let shopArray = Smoke().dataToArrayOfDictionaries(response.data!)
            print(shopArray?.count)
            
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
                   
                    var imagesArray = Array<String>()
                    for dictionary in arrayDictionaryImage {
                        let url = dictionary["url"]! as String
                        imagesArray.append(url)
                    }
                    
                    let newSalon = HBSalon(address: address, comments: comment!, evaluations: evaluations!, id: id!, likes: likes!, location: location, name: name, phone: phone, rate: rate!, website: website, images: imagesArray)
                    
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
    
}
