//
//  CHCPastAppointmentsTableViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/3/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCPastAppointmentsTableViewController: UITableViewController {
    
    // MARK: Outlets & Properties
    
    private let reuseID = "PastAppointmentsCell"
    
    /* constraints */
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width
    
    /* past appointments overlay */
    let pastOverlayImageView: UIImageView = UIImageView()
    let pastOverlayLabel: UILabel = UILabel()
    
    // MARK: View Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* get all past appointments */
        displayPastAppointments()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Utility Functions
    
    func displayPastAppointments() {
        // TODO: if hasPastAppointments ~> displayPastAppointments()
        
        // else, ~> display upcoming overlay
        /* setup past icon image */
        pastOverlayImageView.contentMode = .ScaleAspectFill
        pastOverlayImageView.frame = CGRectMake(0, 0, deviceWidth * 0.40, deviceWidth * 0.40)
        pastOverlayImageView.center = CGPointMake(deviceWidth * 0.50, deviceWidth * 0.30)
        let appointmentsImage = UIImage(named: "appointments")
        pastOverlayImageView.image = appointmentsImage
        
        /* setup past appointments text */
        pastOverlayLabel.numberOfLines = 2
        pastOverlayLabel.textAlignment = .Center
        pastOverlayLabel.frame = CGRectMake(0, 0, deviceWidth * 0.80, deviceWidth * 0.40)
        pastOverlayLabel.center = CGPointMake(deviceWidth * 0.5, deviceWidth * 0.60)
        pastOverlayLabel.font = UIFont(name: "Futura", size: 18.0)
        pastOverlayLabel.textColor = UIColor.colorFromHex(0x666666)
        pastOverlayLabel.text = "You have not attended any appointments yet."
        
        /* add subviews to past tableview */
        self.tableView.addSubview(pastOverlayImageView)
        self.tableView.addSubview(pastOverlayLabel)
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
