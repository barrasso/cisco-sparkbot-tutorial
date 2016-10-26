//
//  CHCAccountViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/2/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCAccountViewController: UIViewController {

    // MARK: Outlets & Properts
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var backgroundCoverImageView: UIImageView!
    
    @IBOutlet weak var personalDetailsView: UIView!
    @IBOutlet weak var accountOptionsContainerView: UIView!
    
    /* screen constraints */
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width
    @IBOutlet weak var avatarTopLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerTopLayoutConstraint: NSLayoutConstraint!
    
    /* activity loader */
    let indicatorContainer: UIView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    // MARK: View Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* adjust view constraints */
        if deviceHeight <= 568 {
            avatarTopLayoutConstraint.constant = deviceHeight * 0.033
            containerTopLayoutConstraint.constant = deviceHeight * 0.35
        } else if deviceHeight <= 667 {
            avatarTopLayoutConstraint.constant = deviceHeight * 0.08
            containerTopLayoutConstraint.constant = deviceHeight * 0.40
        } else {
            containerTopLayoutConstraint.constant = deviceHeight * 0.44
        }
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        showActivityIndicator(self.view, title: "Loading...")
        /* Fetch personal data from Spark */
        CHCSparkHandler.getPersonalDetails({ (user, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    print("Error receiving personal details: \(error)")
                    if self.activityIndicator.isAnimating() {
                        self.activityIndicator.stopAnimating()
                        self.indicatorContainer.hidden = true
                    }
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                })
            } else { /* Got user details, update view */
                dispatch_async(dispatch_get_main_queue(), {
                    if let name = user?.displayName {
                        self.displayNameLabel.text = name
                    }
                    if let email = user?.emails[0] {
                        self.userEmailLabel.text = email
                    }
                    if let avatar = user?.avatarURL {
                        if avatar != "" {
                            if let url = NSURL(string: avatar) {
                                if let data = NSData(contentsOfURL: url) {
                                    self.userAvatarImageView.image = UIImage(data: data)?.rounded
                                }
                            }
                        }
                    }
                    if self.activityIndicator.isAnimating() {
                        self.activityIndicator.stopAnimating()
                        self.indicatorContainer.hidden = true
                    }
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                })
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if self.activityIndicator.isAnimating() {
            self.activityIndicator.stopAnimating()
        }
        self.indicatorContainer.removeFromSuperview()
    }
    
    // MARK: Utility Functions
    
    func showActivityIndicator(uiView: UIView, title: String) {
        /* init container view */
        indicatorContainer.frame = uiView.frame
        indicatorContainer.center = uiView.center
        indicatorContainer.backgroundColor = UIColor.colorFromHex(0xFFFFFF, alpha: 0.3)
        
        /* add loading gradient view */
        let loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor.colorFromHex(0x333333, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        /* setup loading label */
        let loadingLabel: UILabel = UILabel()
        loadingLabel.textAlignment = .Center
        loadingLabel.frame = CGRectMake(0, 0, 80, 80)
        loadingLabel.center = CGPointMake(loadingView.frame.size.width * 0.50, loadingView.frame.size.height * 0.85)
        loadingLabel.textColor = UIColor.colorFromHex(0xECECEC)
        loadingLabel.font = UIFont(name: "Futura", size: 10.0)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
