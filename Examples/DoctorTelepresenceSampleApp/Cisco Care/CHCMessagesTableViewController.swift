//
//  CHCMessagesTableViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/4/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCMessagesTableViewController: UITableViewController {
    
    // MARK: Outlets & Properties
    
    /* table view */
    private let reuseID = "MessageCell"
    var refreshCtrl = UIRefreshControl()
    var sparkRooms: [SparkRoom] = [SparkRoom]()
    
    /* NSUser Defaults */
    let defaults = NSUserDefaults.standardUserDefaults()
    
    /* activity indicator */
    let indicatorContainer: UIView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    /* constraints */
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width
    
    /* default messages overlay */
    let overlayImageView: UIImageView = UIImageView()
    let overlayLabel: UILabel = UILabel()
    
    // MARK: View Initialization

    override func viewDidAppear(animated: Bool) {
        /* fetch new room data */
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        showActivityIndicator(self.tableView, title: "Loading messages...")
        CHCSparkHandler.listAllRoomSessions { (rooms, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    self.displayDefaultRoomsOverlay()
                    self.sparkRooms.removeAll()
                    self.tableView.reloadData()
                    
                    print("Error getting list of rooms: \(error)")
                    self.displayAlert("Network Error", error: "Oops, something went wrong.\nPlease try again.")
                    
                    if self.activityIndicator.isAnimating() {
                        self.activityIndicator.stopAnimating()
                        self.indicatorContainer.hidden = true
                    }
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                })
            } else {
                // search for user's spark rooms, get latest message data
                self.sparkRooms = rooms!
                var allRooms = rooms!
                if allRooms.count != 0 {
                    for room in 0...allRooms.count-1 {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                            CHCSparkHandler.getLatestMessageForRoom(allRooms[room].roomID, completion: { (results, error) in
                                if error != nil {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        print("Error getting latest messages for rooms: \(error)")
                                        self.displayAlert("Network Error", error: "Oops, something went wrong.\nPlease try again.")
                                    }
                                } else {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        for i in self.sparkRooms {
                                            if i.roomID == results!["roomId"] as! String {
                                                self.sparkRooms = self.sparkRooms.filter{ $0.roomID != i.roomID }
                                            }
                                        }
                                        let text = results!["text"] as! String
                                        let time = results!["created"] as! String
                                        allRooms[room].latestMsg = text
                                        allRooms[room].createdAt = time
                            
                                        self.sparkRooms.append(allRooms[room])
                                        self.tableView.reloadData()
                                    }
                                }
                            })
                        }
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        self.hideDefaultsRoomsOverlay()
                    }
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.displayDefaultRoomsOverlay()
                        self.sparkRooms.removeAll()
                        self.tableView.reloadData()
                    })
                }
                dispatch_async(dispatch_get_main_queue(), {
                    if self.activityIndicator.isAnimating() {
                        self.activityIndicator.stopAnimating()
                        self.indicatorContainer.hidden = true
                    }
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                })
            }
        }
        // check tab badge value
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
        if tabItem.badgeValue != nil {
            tabItem.badgeValue = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup tableview refresh controller
        refreshCtrl.backgroundColor = UIColor.clearColor()
        refreshCtrl.tintColor = UIColor.colorFromHex(0x333333)
        refreshCtrl.addTarget(self, action: #selector(CHCMessagesTableViewController.didPullToRefresh), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshCtrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didPullToRefresh() {
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        /* fetch provider data */
        CHCSparkHandler.listAllRoomSessions({ (rooms, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    self.displayDefaultRoomsOverlay()
                    self.sparkRooms.removeAll()
                    self.tableView.reloadData()
                    
                    print("Error getting list of rooms: \(error)")
                    self.displayAlert("Network Error", error: "Oops, something went wrong.\nPlease try again.")
                    if self.refreshCtrl.refreshing {
                        self.refreshCtrl.endRefreshing()
                    }
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                })
            } else {
                // search for user's spark rooms, get latest message data
                self.sparkRooms = rooms!
                var allRooms = rooms!
                if allRooms.count != 0 {
                    for room in 0...allRooms.count-1 {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                            CHCSparkHandler.getLatestMessageForRoom(allRooms[room].roomID, completion: { (results, error) in
                                if error != nil {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        print("Error getting latest messages for rooms: \(error)")
                                        self.displayAlert("Network Error", error: "Oops, something went wrong.\nPlease try again.")
                                    }
                                } else {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        for i in self.sparkRooms {
                                            if i.roomID == results!["roomId"] as! String {
                                                self.sparkRooms = self.sparkRooms.filter{ $0.roomID != i.roomID }
                                            }
                                        }
                                        let text = results!["text"] as! String
                                        let time = results!["created"] as! String
                                        allRooms[room].latestMsg = text
                                        allRooms[room].createdAt = time
                                    
                                        self.sparkRooms.append(allRooms[room])
                                        self.tableView.reloadData()
                                    }
                                }
                            })
                        }
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        self.hideDefaultsRoomsOverlay()
                    }
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.displayDefaultRoomsOverlay()
                        self.sparkRooms.removeAll()
                        self.tableView.reloadData()
                    })
                }
                dispatch_async(dispatch_get_main_queue(), {
                    if self.refreshCtrl.refreshing {
                        self.refreshCtrl.endRefreshing()
                    }
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                })
            }
        })
    }
    
    // MARK: Utility Functions
    
    func displayDefaultRoomsOverlay() {
        /* setup overlay icon image */
        overlayImageView.contentMode = .ScaleAspectFill
        overlayImageView.frame = CGRectMake(0, 0, deviceWidth * 0.40, deviceWidth * 0.40)
        overlayImageView.center = CGPointMake(deviceWidth * 0.50, deviceWidth * 0.30)
        let overlayImage = UIImage(named: "messages")
        overlayImageView.image = overlayImage
        
        /* setup overlay text */
        overlayLabel.numberOfLines = 3
        overlayLabel.textAlignment = .Center
        overlayLabel.frame = CGRectMake(0, 0, deviceWidth * 0.80, deviceWidth * 0.40)
        overlayLabel.center = CGPointMake(deviceWidth * 0.5, deviceWidth * 0.60)
        overlayLabel.font = UIFont(name: "Futura", size: 18.0)
        overlayLabel.textColor = UIColor.colorFromHex(0x666666)
        overlayLabel.text = "Messages from your providers will be listed here."
        
        /* add subviews to tableview */
        self.tableView.addSubview(overlayImageView)
        self.tableView.addSubview(overlayLabel)
        showDefaultsRoomsOverlay()
    }

    func showDefaultsRoomsOverlay() {
        overlayLabel.hidden = false
        overlayImageView.hidden = false
    }
    
    func hideDefaultsRoomsOverlay() {
        overlayLabel.hidden = true
        overlayImageView.hidden = true
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
        return sparkRooms.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseID, forIndexPath: indexPath) as! CHCMessageTableViewCell

        /* configure the cell */
        cell.sparkRoom = sparkRooms[indexPath.section]
        
        return cell
    }
}
