//
//  CHCHealthViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/3/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCHealthViewController: UIViewController {
    
    // MARK: Properties & Outlets
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var recordContainerView: UIView!
    @IBOutlet weak var medicalHistoryContainerView: UIView!
    @IBOutlet weak var filterSegmentControl: UISegmentedControl!
    
    /* constraints */
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width
    @IBOutlet weak var segmentedWidthLayoutConstraint: NSLayoutConstraint!
    
    /* health record overlay */
    let healthImageView: UIImageView = UIImageView()
    let healthRecordLabel: UILabel = UILabel()

    // MARK: View Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* initial view setup */
        medicalHistoryContainerView.hidden = true
        medicalHistoryContainerView.userInteractionEnabled = false
        segmentedWidthLayoutConstraint.constant = deviceWidth * 0.85
        
        // TODO: Add this to sub-viewcontroller: CHCHealthReportVC
        /* check for health records */
        displayHealthRecords()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Utility Functions
    
    func displayHealthRecords() {
        // TODO: if hasHealthRecordsSetup ~> displayRecords()
        
        // else, ~> display 'records not found' overlay
        /* setup health record icon image */
        healthImageView.contentMode = .ScaleAspectFill
        healthImageView.frame = CGRectMake(0, 0, deviceWidth * 0.40, deviceWidth * 0.40)
        healthImageView.center = CGPointMake(deviceWidth * 0.50, deviceWidth * 0.30)
        let healthImage = UIImage(named: "my-health")
        healthImageView.image = healthImage
        
        /* setup health record not available text */
        healthRecordLabel.numberOfLines = 2
        healthRecordLabel.textAlignment = .Center
        healthRecordLabel.frame = CGRectMake(0, 0, deviceWidth * 0.80, deviceWidth * 0.40)
        healthRecordLabel.center = CGPointMake(deviceWidth * 0.5, deviceWidth * 0.60)
        healthRecordLabel.font = UIFont(name: "Futura", size: 18.0)
        healthRecordLabel.textColor = UIColor.colorFromHex(0x666666)
        healthRecordLabel.text = "No health records are available yet."
        
        /* add subviews to record container view */
        self.recordContainerView.addSubview(healthImageView)
        self.recordContainerView.addSubview(healthRecordLabel)
    }
    
    @IBAction func filterSegmentValueChanged(sender: AnyObject) {
        if filterSegmentControl.selectedSegmentIndex == 0 {
            recordContainerView.hidden = false
            recordContainerView.userInteractionEnabled = true
            medicalHistoryContainerView.hidden = true
            medicalHistoryContainerView.userInteractionEnabled = false
        } else {
            recordContainerView.hidden = true
            recordContainerView.userInteractionEnabled = false
            medicalHistoryContainerView.hidden = false
            medicalHistoryContainerView.userInteractionEnabled = true
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
