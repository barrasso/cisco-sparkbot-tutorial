//
//  CHCAccountOptionsTableViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/2/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit
import KeychainSwift

class CHCAccountOptionsTableViewController: UITableViewController {
    
    // MARK: Outlets & Properties
    
    /* user data */
    let keychain = KeychainSwift()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    /* table view */
    private let reuseID = "AccountOptionCell"
    let cellTitles = ["Personal Details",
                      "Insurance Details",
                      "Payment Information",
                      "Manage Children",
                      "Logout"]
    
    // MARK: View Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.colorFromHex(0xFFFFFF)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Table View Data Source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cellTitles.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseID, forIndexPath: indexPath)
        cell.selectionStyle = .None

        /* Configure the cell */
        let title = cellTitles[indexPath.section]
        cell.textLabel?.font = UIFont(name: "Futura", size: 16.0)
        cell.textLabel?.text = title
        cell.textLabel?.textColor = UIColor.colorFromHex(0x666666)
        cell.backgroundColor = UIColor.colorFromHex(0xFFFFFF)
        
        if title != "Logout" { // exclude last cell
            cell.accessoryType = .DisclosureIndicator
            
            /* create custom cell border */
            let border = CALayer()
            let width = CGFloat(0.33)
            border.borderColor = UIColor.colorFromHex(0xAAAAAA).CGColor
            border.frame = CGRect(x: 0, y: cell.frame.size.height - width, width:  cell.frame.size.width, height: cell.frame.size.height)
            border.borderWidth = width
            cell.layer.addSublayer(border)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0) { // personal details cell tapped

        }
        
        if (indexPath.section == 1) { // insurance details cell tapped

        }
        
        if (indexPath.section == 2) { // payment info cell tapped
        
        }
        
        if (indexPath.section == 3) { // manage children cell tapped

        }
        
        if (indexPath.section == 4) { // logout cell tapped
            displayLogoutAlert("Logout", error: "Are you sure you want to log out?")
        }
    }

    // MARK: Helper Functions
    
    func displayLogoutAlert(title: String, error: String) {
        let logoutAlert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log me out.", style: .Destructive, handler: { action in
            // clear token keychain
            self.keychain.set("", forKey: "sparkAccessToken")
            self.keychain.set("", forKey: "sparkRefreshToken")

            // clear auto login defaults
            self.defaults.setBool(false, forKey: "autoLoginEnabled")
            self.defaults.setObject(nil, forKey: "accessExpirationDate")
            self.defaults.setObject(nil, forKey: "refreshExpirationDate")
            
            // pop back to root start
            let storyboard = UIStoryboard(name: "Start", bundle: nil)
            let initialViewController = storyboard.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
            self.presentViewController(initialViewController, animated: true, completion: nil)
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "No, stay.", style: .Cancel, handler: { action in
            // close alert
        }))
        
        self.presentViewController(logoutAlert, animated: true, completion: nil)
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
