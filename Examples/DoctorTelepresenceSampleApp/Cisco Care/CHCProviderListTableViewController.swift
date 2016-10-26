//
//  CHCProviderListTableViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/4/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCProviderListTableViewController: UITableViewController {
    
    // MARK: Outlets & Properties
    
    /* table view */
    private let reuseID = "ProviderListCell"
    var refreshCtrl = UIRefreshControl()
    
    /* constraints */
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width

    /* activity indicator */
    let indicatorContainer: UIView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    /* table data */
    var allProviders: [CHCProviderHandler] = [CHCProviderHandler]()
    
    // MARK: View Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup tableview refresh controller
        refreshCtrl.backgroundColor = UIColor.clearColor()
        refreshCtrl.tintColor = UIColor.colorFromHex(0x333333)
        refreshCtrl.addTarget(self, action: #selector(CHCProviderListTableViewController.didPullToRefresh), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshCtrl)
        
        /* initial fetch provider data */
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        showActivityIndicator(self.tableView, title: "Finding providers...")
        CHCProviderHandler.listAllProviders({ (providers, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    print("Error getting list of providers: \(error)")
                    self.displayAlert("Network Error", error: "Oops, something went wrong.\nPlease try again.")
                    if self.activityIndicator.isAnimating() {
                        self.activityIndicator.stopAnimating()
                        self.indicatorContainer.hidden = true
                    }
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                })
            } else {
                /* Got providers list, update table view */
                dispatch_async(dispatch_get_main_queue(), {
                    /* sort providers by who online status */
                    let sortedProviders = providers!.sort({ $0.status < $1.status })
                    self.allProviders = sortedProviders
                    self.tableView.reloadData()
                    
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
    }
    
    // MARK: Utility Functions
    
    func didPullToRefresh() {
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        /* fetch provider data */
        CHCProviderHandler.listAllProviders({ (providers, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    print("Error getting list of providers: \(error)")
                    self.displayAlert("Network Error", error: "Oops, something went wrong.\nPlease try again.")
                    if self.refreshCtrl.refreshing {
                        self.refreshCtrl.endRefreshing()
                    }
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                })
            } else {
                /* Got providers list, update table view */
                dispatch_async(dispatch_get_main_queue(), {
                    /* sort providers by who online status */
                    let sortedProviders = providers!.sort({ $0.status < $1.status })
                    self.allProviders = sortedProviders
                    self.tableView.reloadData()
                    
                    if self.refreshCtrl.refreshing {
                        self.refreshCtrl.endRefreshing()
                    }
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                })
            }
        })
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

    // MARK: Table View Data Source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return allProviders.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseID, forIndexPath: indexPath) as! CHCProviderTableViewCell
        cell.accessoryType = .DisclosureIndicator
        cell.selectionStyle = .None
        
        /* configure the cell */
        cell.provider = allProviders[indexPath.section]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /* get selected provder and pass data to parent segue */
        let selectedProvider = allProviders[indexPath.section]
        self.parentViewController!.performSegueWithIdentifier("showProviderDetail", sender: selectedProvider)
    }
}
