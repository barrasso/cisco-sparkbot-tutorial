//
//  CHCCalendarSelectorViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/17/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit
import WWCalendarTimeSelector

class CHCCalendarSelectorViewController: UIViewController, WWCalendarTimeSelectorProtocol {
    
    // MARK: Outlets & Properties
    
    /* provider */
    var currentProvider: CHCProviderHandler?
    
    /* calendar selector */
    let selector = WWCalendarTimeSelector.instantiate()
    
    /* screen constraints */
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width
    
    /* buttons */
    
    @IBOutlet weak var scheduleASAPButton: UIButton!
    @IBOutlet weak var openCalendarButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func scheduleASAPTouchUpInside(sender: AnyObject) {
        
    }
    
    @IBAction func openCalendarTouchUpInside(sender: AnyObject) {
        showCalendar()
    }
    
    // MARK: View Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* setup nav bar */
        self.navigationItem.title = "Date Selection"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(CHCCalendarSelectorViewController.submit(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    func submit(_: UIBarButtonItem!) {
        self.performSegueWithIdentifier("showPaymentForm", sender: nil)
    }
    
    // MARK: Calendar Delegate
    
    func showCalendar() {
        // init calendar selector vc
        selector.delegate = self
        selector.optionLayoutHeight = deviceHeight * 0.75
        
        // calendar styles
        selector.optionTopPanelBackgroundColor = UIColor.colorFromHex(0x2196F3)
        selector.optionSelectorPanelBackgroundColor = UIColor.colorFromHex(0x2196F3)
        
        // highlight colors
        selector.optionClockBackgroundColorAMPMHighlight = UIColor.colorFromHex(0x2196F3)
        selector.optionClockBackgroundColorHourHighlight = UIColor.colorFromHex(0x2196F3)

        selector.optionClockBackgroundColorHourHighlightNeedle = UIColor.colorFromHex(0x2196F3)

        selector.optionClockBackgroundColorMinuteHighlight = UIColor.colorFromHex(0x2196F3)

        selector.optionClockBackgroundColorMinuteHighlightNeedle = UIColor.colorFromHex(0x2196F3)

        selector.optionCalendarBackgroundColorTodayHighlight = UIColor.colorFromHex(0x2196F3)
        selector.optionCalendarBackgroundColorPastDatesHighlight = UIColor.colorFromHex(0x2196F3)
        selector.optionCalendarBackgroundColorFutureDatesHighlight = UIColor.colorFromHex(0x2196F3)
        
        // selector button styles
        selector.optionButtonFontColorDone = UIColor.colorFromHex(0x2196F3)
        selector.optionButtonFontColorCancel = UIColor.colorFromHex(0xCF000F)
        
        // show calendar view
        presentViewController(selector, animated: true, completion: nil)
    }
    
    func WWCalendarTimeSelectorDone(selector: WWCalendarTimeSelector, date: NSDate) {
        print(date)
    }
    
    // MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? CHCBookingPaymentFormViewController {
            // pass provider object
            if (self.currentProvider != nil) {
                destination.currentProvider = self.currentProvider
            }
            // init custom back button
            let backItem = UIBarButtonItem()
            backItem.title = " "
            destination.navigationItem.backBarButtonItem = backItem
        }
    }
}
