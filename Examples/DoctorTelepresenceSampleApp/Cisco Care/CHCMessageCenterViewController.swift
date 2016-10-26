//
//  CHCMessageCenterViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/4/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCMessageCenterViewController: UIViewController, UISearchBarDelegate {

    // MARK: Outlets & Properties
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width
    
    /* search bar */
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarContainerView: UIView!
    @IBOutlet weak var searchBarWidthConstraint: NSLayoutConstraint!
    
    /* messages container */
    @IBOutlet weak var messagesContainerView: UIView!
    
    // MARK: View Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* initial view setup */
        searchBar.tintColor = UIColor.colorFromHex(0xECECEC)
        let searchBarTextField = searchBar.valueForKey("searchField") as? UITextField
        searchBarTextField?.textColor = UIColor.colorFromHex(0xECECEC)
        searchBarWidthConstraint.constant = deviceWidth * 0.85
        
        /* set delegates */
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
}
