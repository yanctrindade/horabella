//
//  HBCalendarTableViewCell.swift
//  horabella
//
//  Created by Erick Leal on 18/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import CVCalendar

class HBCalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let calendar = NSCalendar.currentCalendar()
        let currentDate = calendarView.manager.currentDate
        let dateComponents = calendar.components([.Day, .Month, .Year], fromDate: currentDate)
        
        HBAppointment.sharedInstance.day = dateComponents.day
        HBAppointment.sharedInstance.month = dateComponents.month
        HBAppointment.sharedInstance.year = dateComponents.year
        
        HBAppointment.sharedInstance.isCalendarSelected = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - CVCalendarViewDelegate & CVCalendarMenuViewDelegate

extension HBCalendarTableViewCell: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    func didSelectDayView(dayView: DayView) {
        //print(dayView.date.commonDescription + " selecionado!")
        
        //adiciona data na singleton de appointment
        HBAppointment.sharedInstance.day = dayView.date.day
        HBAppointment.sharedInstance.month = dayView.date.month
        HBAppointment.sharedInstance.year = dayView.date.year
        
        HBAppointment.sharedInstance.isCalendarSelected = true
        
        //avisa que selecionou um dia
        NSNotificationCenter.defaultCenter().postNotificationName("didSelectDay", object: nil)
        
    }
    
}
