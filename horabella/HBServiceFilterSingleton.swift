//
//  HBServiceFilterSingleton.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/27/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBServiceFilterSingleton: NSObject {

    var selected = Array<Int>()
    
    class var sharedInstance: HBServiceFilterSingleton {
        struct Singleton {
            static let instance = HBServiceFilterSingleton()
        }
        return Singleton.instance
    }
}
