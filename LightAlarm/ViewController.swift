//
//  ViewController.swift
//  LightAlarm
//
//  Created by Tim Sloncz on 1/23/16.
//  Copyright © 2016 Tim Sloncz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ServiceCallProtocol {

    // Constants
    let testSetUrl = "http://www.schempc.com/lightAlarm/?setHour=07&setMin=35"
    let baseAlarmUrl = "http://www.schempc.com/lightAlarm/?"
    let getTimeUrl = "http://www.schempc.com/lightAlarm/?getAlarmTime=true"
    
    // UI outlets
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var setAlarmButton: UIButton!
    
    var serviceCaller: ServiceCaller {
        get {
            return ServiceCaller(invoker: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTimePicker.datePickerMode = UIDatePickerMode.Time
        serviceCaller.makeCall(getTimeUrl)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setAlarmTime(sender: UIButton) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let alarmTime = timeFormatter.stringFromDate(dateTimePicker.date)
        print(alarmTime)
        let date = dateTimePicker.date
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute] , fromDate: date)
        let hour = components.hour
        let minute = components.minute
        
        let setAlarmUrl = "\(baseAlarmUrl)setHour=\(hour)&setMin=\(minute)"
//        let setAlarmUrl = testSetUrl
        serviceCaller.makeCall(setAlarmUrl)
    }

}

extension ViewController {
    func updateData(data: NSArray) {
        print("data: \(data)")
    }
}