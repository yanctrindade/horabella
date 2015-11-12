//
//  Filter.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/10/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBFilter: NSObject {
    
    var filtersArray = Array<String>()

    class var sharedInstance: HBFilter {
        struct Singleton {
            static let instance = HBFilter()
        }
        return Singleton.instance
    }
}
