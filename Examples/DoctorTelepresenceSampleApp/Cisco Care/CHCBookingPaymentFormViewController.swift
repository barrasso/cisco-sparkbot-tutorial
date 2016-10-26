//
//  CHCBookingPaymentFormViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/19/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit
import SwiftForms

class CHCBookingPaymentFormViewController: FormViewController {

    // MARK: Outlets & Properties
    
    /* custom models */
    var currentRoom: SparkRoom?
    var currentProvider: CHCProviderHandler?
    
    /* activity indicator */
    let indicatorContainer: UIView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    struct Static {
        static let nameTag = "name"
        static let cardTag = "cardNumber"
        static let xpDateTag = "expiration"
        static let cvcTag = "cvc"
        static let zipTag = "zip"
        static let enabled = "enabled"
        static let button = "button"
    }
    
    /* payment form descriptor */
    var paymentForm = FormDescriptor()
    
    // MARK: View Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadForm()
        self.navigationItem.title = "Payment Details"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: #selector(CHCBookingPaymentFormViewController.submit(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func submit(_: UIBarButtonItem!) {
        startSession()
    }
    
    // MARK: Helper Functions
    
    func startSession() {
        // check for valid form info
        
        // init activity indicator loading animation
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        showActivityIndicator(self.tableView, title: "Starting Session...")
        
        // create room using Spark API
        let providerName = (currentProvider?.name)!
        let providerAvatarURL = (currentProvider?.avatar)!
        CHCSparkHandler.createRoomSession(providerName, providerAvatarURL: providerAvatarURL) { (room, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    print("Error creating spark room: \(error)")
                    self.displayAlert("Network Error", error: "Oops, could not create room.\nPlease try again.")
                    if self.activityIndicator.isAnimating() {
                        self.activityIndicator.stopAnimating()
                        self.indicatorContainer.hidden = true
                    }
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                })
            } else {
                /* Got new room details */
                dispatch_async(dispatch_get_main_queue(), {
                    // save room id to nsuserdefaults
                    self.currentRoom = room
                    let roomID = (self.currentRoom?.roomID)!
                    
                    // load previous array of Like ID's, if it exists
                    let defaults = NSUserDefaults.standardUserDefaults()
                    if var roomArray = defaults.arrayForKey("SparkRoomArray") {
                        roomArray.append(roomID)
                        defaults.setObject(roomArray, forKey: "SparkRoomArray")
                    } else {
                        var newArray = [AnyObject]()
                        newArray.append(roomID)
                        defaults.setObject(newArray, forKey: "SparkRoomArray")
                    }
                    
                    if self.activityIndicator.isAnimating() {
                        self.activityIndicator.stopAnimating()
                        self.indicatorContainer.hidden = true
                    }
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if (self.currentRoom != nil) {
                        // segue back to main vc & signal for new messages
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let initialViewController = storyboard.instantiateViewControllerWithIdentifier("MainTabBarController") as! CHCMainTabBarController
                        
                        let tabArray = initialViewController.tabBar.items as NSArray!
                        let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
                        tabItem.badgeValue = "1"
                        self.presentViewController(initialViewController, animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    func showActivityIndicator(uiView: UIView, title: String) {
        /* init container view */
        indicatorContainer.frame = uiView.frame
        indicatorContainer.center = uiView.center
        indicatorContainer.backgroundColor = UIColor.colorFromHex(0xFFFFFF, alpha: 0.3)
        
        /* add loading gradient view */
        let loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 120, 120)
        loadingView.center = CGPointMake(uiView.frame.size.width * 0.50, uiView.frame.size.height * 0.33)
        loadingView.backgroundColor = UIColor.colorFromHex(0x333333, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        /* setup loading label */
        let loadingLabel: UILabel = UILabel()
        loadingLabel.textAlignment = .Center
        loadingLabel.frame = CGRectMake(0, 0, loadingView.frame.width, loadingView.frame.height)
        loadingLabel.center = CGPointMake(loadingView.frame.size.width * 0.50, loadingView.frame.size.height * 0.85)
        loadingLabel.textColor = UIColor.colorFromHex(0xECECEC)
        loadingLabel.font = UIFont(name: "Futura", size: 12.0)
        loadingLabel.text = title
        
        /* setup activity indicator */
        activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.center = CGPointMake(loadingView.frame.size.width / 2,
                                               loadingView.frame.size.height / 2);
        
        /* add sub views and start loading animation */
        loadingView.addSubview(activityIndicator)
        loadingView.addSubview(loadingLabel)
        indicatorContainer.addSubview(loadingView)
        uiView.addSubview(indicatorContainer)
        activityIndicator.startAnimating()
    }
    
    func displayAlert(title: String, error: String) {
        let errortAlert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        errortAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            // close alert
        }))
        self.presentViewController(errortAlert, animated: true, completion: nil)
    }

    // MARK: Private Interface Functions
    
    private func loadForm() {
        
        paymentForm.title = "Payment Details"
        
        let section1 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        var row = FormRowDescriptor(tag: Static.nameTag, type: .Name, title: "Name on Card")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. John Smith", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.cardTag, type: .Phone, title: "Card Number")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. 12345678910001", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.xpDateTag, type: .Date, title: "Expiration Date")
        row.configuration.cell.showsInputToolbar = true
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.cardTag, type: .Phone, title: "CVC")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. 123", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.cardTag, type: .Phone, title: "Zip Code")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. 95134", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.rows.append(row)
        
        let section2 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        row = FormRowDescriptor(tag: Static.enabled, type: .BooleanSwitch, title: "Save card info for next time")
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.button, type: .Button, title: "Start Session")
        row.configuration.cell.appearance = ["titleLabel.textColor":UIColor.colorFromHex(0xFFFFFF), "titleLabel.font":UIFont(name: "Futura", size: 20.0)!, "backgroundColor":UIColor.colorFromHex(0x2196F3)]
        row.configuration.button.didSelectClosure = { _ in
            self.view.endEditing(true)
            self.startSession()
        }
        section2.rows.append(row)
        
        paymentForm.sections = [section1, section2]
        self.form = paymentForm
    }
    
    // MARK: Form TableView Delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
}
