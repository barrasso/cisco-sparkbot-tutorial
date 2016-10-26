//
//  CHCPageContentViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 7/22/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit
import KeychainSwift
import SafariServices

class CHCPageContentViewController: UIViewController, SFSafariViewControllerDelegate {

    // MARK: Outlets & Properties
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var onboardContentImageView: UIImageView!
    
    var pageIndex: Int = 0
    var pageTitle: String!
    var safariVC: SFSafariViewController?
    
    let keychain = KeychainSwift()
    let defaults = NSUserDefaults.standardUserDefaults()
    let deviceWidth  = UIScreen.mainScreen().bounds.width
    let deviceHeight = UIScreen.mainScreen().bounds.height
    
    
    // MARK: View Initialization
    
    override func viewWillAppear(animated: Bool) {
        
        /* Update page index while scrolling */
        self.pageControl.currentPage = pageIndex
        
        if pageIndex != 2 {
            /* Hide and disable button */
            self.signupButton.alpha = 0.0
            self.signupButton.hidden = true
            self.signupButton.enabled = false
        } else {
            /* Initialize fade in */
            self.signupButton.alpha = 0.0
            
            /* Show and enable sign in button */
            UIView.animateWithDuration(1.25, animations: {
                self.signupButton.alpha = 1.0
                self.signupButton.hidden = false
                self.signupButton.enabled = true
            })
        }        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* set onboarding title */
        self.titleLabel.text = pageTitle
        
        /* Setup button custom styles */
        self.signupButton.layer.borderWidth = 1
        self.signupButton.layer.cornerRadius = 8
        self.signupButton.backgroundColor = UIColor.clearColor()
        self.signupButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        /* add observers */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CHCPageContentViewController.handleSafariCallback(_:)), name: "kCloseSafariViewControllerNotification", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IBActions
    
    @IBAction func signupButtonTouchUpInside(sender: AnyObject) {
        
        /* begin OAuth spark authentication */
        safariVC = SFSafariViewController(URL: NSURL(string: "https://api.ciscospark.com/v1/authorize?client_id=Cb34286d6295ed6510eec9fd9d67fc885fe903bde2148b54ea1c56cf661f4ec56&response_type=code&redirect_uri=https%3A%2F%2Fcisco-care.herokuapp.com%2Fapi%2Fauth%2Fspark%2Fcallback&scope=spark%3Amessages_write%20spark%3Arooms_read%20spark%3Amemberships_read%20spark%3Amessages_read%20spark%3Arooms_write%20spark%3Apeople_read%20spark%3Amemberships_write&state=care2016")!)
        safariVC!.delegate = self
        self.presentViewController(safariVC!, animated: true, completion: nil)
    }
    
    // MARK: SFSafari Delegate
    
    func handleSafariCallback(notification: NSNotification) {
        /* get the url from the oauth callback */
        if let url = notification.object as? NSURL {
            let urlAsString = String(url)
            let urlAsArray = urlAsString.componentsSeparatedByString("//")
            if urlAsArray[1] == "spark" {
                
                safariVC?.dismissViewControllerAnimated(true, completion: {
                    let accessToken = urlAsArray[2]
                    let refreshToken = urlAsArray[3]
                    
                    /* save tokens to keychain */
                    self.keychain.set(accessToken, forKey: "sparkAccessToken")
                    self.keychain.set(refreshToken, forKey: "sparkRefreshToken")
                    
                    /* save token expiration dates to NSUserDefaults */
                    let currentDate = NSDate()
                    let currentCalendar = NSCalendar.currentCalendar()
                    let accessExpirationDate = currentCalendar.dateByAddingUnit(.Day, value: 14, toDate: currentDate, options: [])
                    let refreshExpirationDate = currentCalendar.dateByAddingUnit(.Day, value: 90, toDate: currentDate, options: [])
                    self.defaults.setObject(accessExpirationDate, forKey: "accessExpirationDate")
                    self.defaults.setObject(refreshExpirationDate, forKey: "refreshExpirationDate")
                    
                    /* Successfully authenticated. Go to Main storyboard... */
                    self.performSegueWithIdentifier("showMainTabBarController", sender: nil)
                })
            }
        }
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
