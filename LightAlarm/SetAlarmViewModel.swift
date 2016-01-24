//
//  SetAlarmViewModel.swift
//  LightAlarm
//
//  Created by Tim Sloncz on 1/24/16.
//  Copyright © 2016 Tim Sloncz. All rights reserved.
//

import Foundation

class SetAlarmViewModel: ServiceCallProtocol {
    
    let baseAlarmUrl = "http://www.schempc.com/lightAlarm/?"
    let getTimeUrl = "http://www.schempc.com/lightAlarm/?getAlarmTime=true"
    let serviceRequest = ServiceCaller()
    
    init() {
        serviceRequest.delegate = self
    }
    
    func setAlarm(date: NSDate) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
//        let alarmTime = timeFormatter.stringFromDate(date)
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute] , fromDate: date)
        let hour = components.hour
        let minute = components.minute
        
        let setAlarmUrl = "\(baseAlarmUrl)setHour=\(hour)&setMin=\(minute)"
        
        serviceRequest.makeCall(setAlarmUrl)
    }
}

extension SetAlarmViewModel {
    func updateData(data: NSArray) {
        
    }
}