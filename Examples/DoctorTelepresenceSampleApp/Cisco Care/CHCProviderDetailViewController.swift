//
//  CHCProviderDetailViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/8/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCProviderDetailViewController: UIViewController {
    
    // MARK: Outlets & Properties
    
    /* provider */
    var currentProvider: CHCProviderHandler?

    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var providerRatingLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var selectProviderButton: UIButton!
    
    /* constraints */
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width
    @IBOutlet weak var avatarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var selectProviderButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    
    // MARK: Initialization
    
    override func viewWillAppear(animated: Bool) {
        let status = (currentProvider?.status)!
        
        // set provider button
        setupProviderButton(status)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Details"
        
        /* view constraint adjustments */
        avatarTopConstraint.constant    = deviceWidth * 0.02
        avatarWidthConstraint.constant  = deviceWidth * 0.33
        selectProviderButtonHeightConstraint.constant =  deviceHeight * 0.08
        selectProviderButton.layer.cornerRadius = 5.0
        
        if deviceHeight <= 568 {
            containerHeightConstraint.constant = deviceHeight * 0.46
        } else if deviceHeight <= 667 {
            containerHeightConstraint.constant = deviceHeight * 0.41
        } else {
            containerHeightConstraint.constant = deviceHeight * 0.44
        }
        
        /* set up provider details */
        let name = (currentProvider?.name)!
        let status = (currentProvider?.status)!
        setupNameLabel(name, status: status)
        
        // set rating
        let rating = Int((currentProvider?.stars)!)
        setupStarRatingLabel(rating)
        
        // set avatar
        avatarImageView.image = UIImage(named: (currentProvider?.avatar)!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Helper Functions
    
    func setupNameLabel(name: String, status: String) {
        var textColor = UIColor.colorFromHex(0xECECEC)
        switch (status) {
        case "Available":
            textColor = UIColor.colorFromHex(0x26C281)
            break
        case "Busy":
            textColor = UIColor.colorFromHex(0xF89406)
            break
        case "Offline":
            textColor = UIColor.colorFromHex(0x999999)
            break
        default:
            break
        }
        
        let statusIcon = "  " + String.fontAwesomeIconWithName(.Circle)
        let nameAttr = NSMutableAttributedString(string: name)
        let statusAttr = NSAttributedString(string:  statusIcon, attributes: [NSForegroundColorAttributeName:textColor, NSFontAttributeName:UIFont.fontAwesomeOfSize(18.0)])
        nameAttr.appendAttributedString(statusAttr)
        self.providerNameLabel.attributedText = nameAttr
    }
    
    func setupStarRatingLabel(rating: Int) {
        let star  = String.fontAwesomeIconWithName(.Star)
        let starO = String.fontAwesomeIconWithName(.StarO)
        var starRating = "\(starO)\(starO)\(starO)\(starO)\(starO)"
        
        switch (rating) {
        case 0:
            // stay 0
            break
        case 1:
            starRating = "\(star)\(starO)\(starO)\(starO)\(starO)"
            break
        case 2:
            starRating = "\(star)\(star)\(starO)\(starO)\(starO)"
            break
        case 3:
            starRating = "\(star)\(star)\(star)\(starO)\(starO)"
            break
        case 4:
            starRating = "\(star)\(star)\(star)\(star)\(starO)"
            break
        case 5:
            starRating = "\(star)\(star)\(star)\(star)\(star)"
            break
        default:
            starRating = "\(starO)\(starO)\(starO)\(starO)\(starO)"
            break
        }
        self.providerRatingLabel.font = UIFont.fontAwesomeOfSize(20.0)
        self.providerRatingLabel.textColor =  UIColor.colorFromHex(0xE87E04)
        self.providerRatingLabel.text = starRating
    }
    
    func setupProviderButton(status: String) {
        switch (status) {
        case "Available":
            self.selectProviderButton.enabled = true
            self.selectProviderButton.setTitle("Select Provider", forState: .Normal)
            self.selectProviderButton.backgroundColor = UIColor.colorFromHex(0x2196F3)
            self.selectProviderButton.setTitleColor(UIColor.colorFromHex(0xFFFFFF), forState: .Normal)
            break
        case "Busy":
            self.selectProviderButton.enabled = false
            self.selectProviderButton.setTitle("Provider is Busy", forState: .Disabled)
            self.selectProviderButton.backgroundColor = UIColor.colorFromHex(0x999999)
            self.selectProviderButton.setTitleColor(UIColor.colorFromHex(0x666666), forState: .Disabled)
            break
        case "Offline":
            self.selectProviderButton.enabled = false
            self.selectProviderButton.setTitle("Provider is Offline", forState: .Disabled)
            self.selectProviderButton.backgroundColor = UIColor.colorFromHex(0x999999)
            self.selectProviderButton.setTitleColor(UIColor.colorFromHex(0x666666), forState: .Disabled)
            break
        default:
            self.selectProviderButton.enabled = true
            break
        }
    }
    
    // MARK: Actions
    
    @IBAction func selectProviderButtonTouchUpInside(sender: AnyObject) {
        self.performSegueWithIdentifier("showBookingProcess", sender: nil)
    }

    // MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? CHCProviderDetailContainerViewController {
            if (self.currentProvider != nil) {
                destination.currentProvider = self.currentProvider
            }
        }
        
        /* pass data from tableview to booking vc */
        if let destination = segue.destinationViewController as? CHCBookingViewController {
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
