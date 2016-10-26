//
//  CHCAppointmentsViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/3/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCAppointmentsViewController: UIViewController {

    // MARK: Outlets & Properties
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var pastAppointmentsContainerView: UIView!
    @IBOutlet weak var upcomingAppointmentsContainerView: UIView!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    /* constraints */
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width
    @IBOutlet weak var segmentedWidthLayoutConstraint: NSLayoutConstraint!
    
    // MARK: View Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* initial view setup */
        pastAppointmentsContainerView.hidden = true
        pastAppointmentsContainerView.userInteractionEnabled = false
        segmentedWidthLayoutConstraint.constant = deviceWidth * 0.85
        self.filterView.bringSubviewToFront(filterSegmentedControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Utility Functions
    
    @IBAction func filterSegmentViewValueChanged(sender: AnyObject) {
        if filterSegmentedControl.selectedSegmentIndex == 0 {
            pastAppointmentsContainerView.hidden = true
            pastAppointmentsContainerView.userInteractionEnabled = false
            upcomingAppointmentsContainerView.hidden = false
            upcomingAppointmentsContainerView.userInteractionEnabled = true
        } else {
            pastAppointmentsContainerView.hidden = false
            pastAppointmentsContainerView.userInteractionEnabled = true
            upcomingAppointmentsContainerView.hidden = true
            upcomingAppointmentsContainerView.userInteractionEnabled = false
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
