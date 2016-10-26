//
//  CHCProviderTableViewCell.swift
//  Cisco Care
//
//  Created by mbarrass on 8/8/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCProviderTableViewCell: UITableViewCell {

    // MARK: Outlets & Properties
    
    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var providerTypeLabel: UILabel!
    @IBOutlet weak var providerAvatarImageView: UIImageView!
    
    // MARK: Initialization
    
    var provider: CHCProviderHandler? {
        didSet {
            if provider != nil {
                /* set text labels */
                let name = provider?.name!
                let status = provider?.status!
                self.setupNameLabel(name!, status: status!)
                self.providerTypeLabel.text = provider?.type!
                
                /* set avatar image */
                self.providerAvatarImageView.image = UIImage(named: (provider?.avatar)!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /* create custom cell border */
        let border = CALayer()
        let width = CGFloat(0.33)
        border.borderColor = UIColor.colorFromHex(0xAAAAAA).CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Utility Functions
    
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
        let statusAttr = NSAttributedString(string:  statusIcon, attributes: [NSForegroundColorAttributeName:textColor, NSFontAttributeName:UIFont.fontAwesomeOfSize(14.0)])
        nameAttr.appendAttributedString(statusAttr)
        self.providerNameLabel.attributedText = nameAttr
    }
}
