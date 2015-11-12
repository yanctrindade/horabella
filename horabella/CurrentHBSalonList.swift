//
//  CurrentHBSalonList.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/12/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class CurrentHBSalonList: NSObject {
    
    var HBSalonArray = Array<HBSalon>()
    
    class var sharedInstance: CurrentHBSalonList {
        struct Singleton {
            static let instance = CurrentHBSalonList()
        }
        return Singleton.instance
    }
}
