//
//  CHCProvidersViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/1/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit
import STZPopupView

class CHCProvidersViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: Outlets & Properts
    
    /* screen constraints */
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width
    
    /* disclosure popup */
    let disclosureTitle = UILabel()
    let disclosureLabel = UILabel()
    let disclosurePopup = UIView()
    let gotItButton = UIButton()
    let config = STZPopupViewConfig()
    
    /* search bar */
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBarWidthConstraint: NSLayoutConstraint!
    
    /* providers */
    @IBOutlet weak var providersContainerView: UIView!
    
    // MARK: View Initialization

    override func viewDidLoad() {
        super.viewDidLoad()

        /* initial view setup */
        searchBar.tintColor = UIColor.colorFromHex(0xECECEC)
        let searchBarTextField = searchBar.valueForKey("searchField") as? UITextField
        searchBarTextField?.textColor = UIColor.colorFromHex(0xECECEC)
        searchBarWidthConstraint.constant = deviceWidth * 0.85
        
        // setup settings nav button
        let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes(attributes, forState: .Normal)
        self.navigationItem.rightBarButtonItem!.title = String.fontAwesomeIconWithName(.QuestionCircle)
        self.navigationItem.rightBarButtonItem!.target = self
        self.navigationItem.rightBarButtonItem!.action = #selector(CHCProvidersViewController.showDisclosurePopup)
        
        /* set delegates */
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Utility Functions
    
    func showDisclosurePopup() {
        if deviceHeight <= 568 {
            disclosurePopup.frame = CGRectMake(0, 0, deviceWidth * 0.8, deviceWidth * 1.1)
        } else if deviceHeight <= 667 {
            disclosurePopup.frame = CGRectMake(0, 0, deviceWidth * 0.8, deviceWidth * 0.85)
        } else {
            disclosurePopup.frame = CGRectMake(0, 0, deviceWidth * 0.8, deviceWidth * 0.67)
        }
        disclosurePopup.backgroundColor = UIColor.colorFromHex(0xECECEC)
        
        disclosureTitle.frame = CGRectMake(disclosurePopup.bounds.width * 0.10, disclosurePopup.bounds.height * 0.01, disclosurePopup.bounds.width * 0.80, disclosurePopup.bounds.height * 0.20)
        disclosureTitle.numberOfLines = 2
        disclosureTitle.textAlignment = .Center
        disclosureTitle.font = UIFont(name: "Futura", size: 18.0)
        disclosureTitle.textColor = UIColor.colorFromHex(0x444444)
        disclosureTitle.text = "Cisco Healthcare"
        disclosurePopup.addSubview(disclosureTitle)
        
        disclosureLabel.frame = CGRectMake(disclosurePopup.bounds.width * 0.10, disclosurePopup.bounds.height * 0.07, disclosurePopup.bounds.width * 0.80, disclosurePopup.bounds.height * 0.80)
        disclosureLabel.numberOfLines = 10
        disclosureLabel.textAlignment = .Center
        disclosureLabel.font = UIFont(name: "Futura", size: 15.0)
        disclosureLabel.textColor = UIColor.colorFromHex(0x666666)
        disclosureLabel.text = "Getting the medical attention you need has never been easier. Simply select a provider from the list below.  All providers are U.S. educated, board certified, and have been trained and certified in telehealth to deliver the best possible experience."
        disclosurePopup.addSubview(disclosureLabel)
        
        gotItButton.frame = CGRectMake(disclosurePopup.bounds.width * 0.10, disclosurePopup.bounds.height * 0.80, disclosurePopup.bounds.width * 0.80, disclosurePopup.bounds.height * 0.15)
        gotItButton.layer.cornerRadius = 4.0
        gotItButton.backgroundColor = UIColor.colorFromHex(0x2196F3)
        gotItButton.addTarget(self, action: #selector(CHCProvidersViewController.closeDisclosurePopup), forControlEvents: .TouchUpInside)
        let attrStr = NSAttributedString(string: "Got It", attributes: [NSForegroundColorAttributeName:UIColor.colorFromHex(0xECECEC), NSFontAttributeName:UIFont(name: "Futura", size: 16.0)!])
        gotItButton.setAttributedTitle(attrStr, forState: .Normal)
        disclosurePopup.addSubview(gotItButton)
        
        config.cornerRadius = 8.0
        config.dismissTouchBackground = true
        presentPopupView(disclosurePopup, config: config)
    }
    
    func closeDisclosurePopup() {
        dismissPopupView()
    }
    
    // MARK: Search Bar Delegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    // MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /* pass selected provider from tableview to detail vc */
        if let destination = segue.destinationViewController as? CHCProviderDetailViewController {
            destination.currentProvider = sender as? CHCProviderHandler
            
            // init custom back button for provider detail vc
            let backItem = UIBarButtonItem()
            backItem.title = " "
            destination.navigationItem.backBarButtonItem = backItem
        }
    }
}
