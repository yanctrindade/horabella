//
//  HBAppointment.swift
//  horabella
//
//  Created by Erick Leal on 24/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBAppointment: NSObject {
    
    var date: NSDate!
    var professional: HBProfessional!
    var service: HBService!
    var salon: HBSalon!
    
    var day: Int!
    var month: Int!
    var year: Int!
    var hour: Int!
    var minute: Int!
    
    var isCalendarSelected: Bool = false
    var isProfessionalSelected: Bool = false
    var isTimeSelected: Bool = false
    
    //MARK: - Singleton
    
    class var sharedInstance: HBAppointment {
        struct Singleton {
            static let instance = HBAppointment()
        }
        return Singleton.instance
    }
    
    func reset(){
        isProfessionalSelected = false
        isTimeSelected = false
    }
    
    func setDate() {
        
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = NSDateComponents()
        
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        self.date = calendar.dateFromComponents(dateComponents)
        
    }
    
    func getStringDate() -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        return dateFormatter.stringFromDate(self.date)
        
    }
    
    func getProfessionalName() -> String {
        return professional.firstName! + " " + professional.lastName!
    }
    
    func isReady() -> Bool{
        return isCalendarSelected && isProfessionalSelected && isTimeSelected
    }

}
