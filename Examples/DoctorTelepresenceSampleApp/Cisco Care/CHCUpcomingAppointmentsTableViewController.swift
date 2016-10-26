//
//  CHCUpcomingAppointmentsTableViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/3/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCUpcomingAppointmentsTableViewController: UITableViewController {
    
    // MARK: Outlets & Properties
    
    private let reuseID = "UpcomingAppointmentsCell"
    
    /* constraints */
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width
    
    /* upcoming appointments overlay */
    let upcomingOverlayImageView: UIImageView = UIImageView()
    let upcomingOverlayLabel: UILabel = UILabel()
    
    // MARK: View Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* check for upcoming appointments */
        displayUpcomingAppointments()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Utility Functions
    
    func displayUpcomingAppointments() {
        // TODO: if hasUpcomingAppointments ~> displayUpcomingAppointments()
        
        // else, ~> display upcoming overlay
        /* setup upcoming icon image */
        upcomingOverlayImageView.contentMode = .ScaleAspectFill
        upcomingOverlayImageView.frame = CGRectMake(0, 0, deviceWidth * 0.40, deviceWidth * 0.40)
        upcomingOverlayImageView.center = CGPointMake(deviceWidth * 0.50, deviceWidth * 0.30)
        let appointmentsImage = UIImage(named: "appointments")
        upcomingOverlayImageView.image = appointmentsImage
        
        /* setup upcoming appointments text */
        upcomingOverlayLabel.numberOfLines = 2
        upcomingOverlayLabel.textAlignment = .Center
        upcomingOverlayLabel.frame = CGRectMake(0, 0, deviceWidth * 0.80, deviceWidth * 0.40)
        upcomingOverlayLabel.center = CGPointMake(deviceWidth * 0.5, deviceWidth * 0.60)
        upcomingOverlayLabel.font = UIFont(name: "Futura", size: 18.0)
        upcomingOverlayLabel.textColor = UIColor.colorFromHex(0x666666)
        upcomingOverlayLabel.text = "You do not have any upcoming appointments scheduled."
        
        /* add subviews to upcoming tableview */
        self.tableView.addSubview(upcomingOverlayImageView)
        self.tableView.addSubview(upcomingOverlayLabel)
    }

    // MARK: Table View Data Source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
