//
//  CHCProviderDetailContainerViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/10/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCProviderDetailContainerViewController: UITableViewController {
    
    // MARK: Outlets & Properties
    
    /* table view */
    private let reuseID = "ProviderInfoCell"
    let cellTitles = ["Type:",
                      "Location:",
                      "Languages:",
                      "Education:",
                      "Years of Experience:",
                      "Reviews:"]
    
    /* provider */
    var currentProvider: CHCProviderHandler?
    
    /* constraints */
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width

    // MARK: View Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Table View data source

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
        
        /* create custom cell border */
        let border = CALayer()
        let width = CGFloat(0.33)
        border.borderColor = UIColor.colorFromHex(0xAAAAAA).CGColor
        border.frame = CGRect(x: 0, y: cell.frame.size.height - width, width:  cell.frame.size.width, height: cell.frame.size.height)
        border.borderWidth = width
        cell.layer.addSublayer(border)
        
        /* Configure the cell */
        var detail = ""
        switch (indexPath.section) {
        case 0: // type
            detail = (currentProvider?.type)!
            break
        case 1: // location
            detail = (currentProvider?.location)!
            break
        case 2: // languages
            detail = (currentProvider?.languages)!
            break
        case 3: // education
            detail = (currentProvider?.education)!
            break
        case 4: // years of xp
            detail = String((currentProvider?.years)!)
            break
        case 5: // TODO: reviews
            detail = "Be the first to review this provider."
            break
        default:
            break
        }
        let title = cellTitles[indexPath.section]
        var attrSize0 = CGFloat(15.0)
        var attrSize1 = CGFloat(17.0)
        if deviceHeight <= 568 {
            attrSize0 = CGFloat(13.0)
            attrSize1 = CGFloat(15.0)
        }
        
        let attrTitle = NSMutableAttributedString(string: title, attributes: [NSForegroundColorAttributeName:UIColor.colorFromHex(0x444444), NSFontAttributeName:UIFont(name: "Futura", size: attrSize0)!])
        let attrDetail = NSAttributedString(string: " " + detail, attributes: [NSForegroundColorAttributeName:UIColor.colorFromHex(0x666666), NSFontAttributeName:UIFont(name: "Futura", size: attrSize1)!])
        attrTitle.appendAttributedString(attrDetail)
        cell.textLabel?.attributedText = attrTitle
        
        return cell
    }
}
