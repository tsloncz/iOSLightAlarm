//
//  ViewController.swift
//  LightAlarm
//
//  Created by Tim Sloncz on 1/23/16.
//  Copyright © 2016 Tim Sloncz. All rights reserved.
//

import UIKit

class SetAlarmViewController: UIViewController, ServiceCallProtocol {

    // Constants
    let testSetUrl = "http://www.schempc.com/lightAlarm/?setHour=07&setMin=35"
    let baseAlarmUrl = "http://www.schempc.com/lightAlarm/?"
    let getTimeUrl = "http://www.schempc.com/lightAlarm/?getAlarmTime=true"
    
    // UI outlets
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var setAlarmButton: UIButton!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    
    let viewModel = SetAlarmViewModel()
    let timeFormatter = NSDateFormatter()
    
    var serviceCaller: ServiceCaller {
        get {
            return ServiceCaller(invoker: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTimePicker.datePickerMode = UIDatePickerMode.Time
        serviceCaller.makeCall(getTimeUrl)
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setAlarmTime(sender: UIButton) {
        viewModel.setAlarm(dateTimePicker.date)
    }

}

// Service Caller Protocol
extension SetAlarmViewController {
    func updateData(data: NSArray) {
        print("data: \(data)")
        let timeComponents = data[0]
        let hour = timeComponents["hour"] as! String
        let minute = timeComponents["min"] as! String
        let timeString = "\(hour):\(minute)"
        alarmTimeLabel.text = timeString
        // need to run on main thread
        dispatch_async(dispatch_get_main_queue()) {
            self.loadViewIfNeeded()
        }
        
        
    }
}