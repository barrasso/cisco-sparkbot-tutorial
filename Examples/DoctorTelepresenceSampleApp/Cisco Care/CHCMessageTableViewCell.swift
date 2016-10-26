//
//  CHCMessageTableViewCell.swift
//  Cisco Care
//
//  Created by mbarrass on 8/4/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCMessageTableViewCell: UITableViewCell {

    // MARK: Outlets & Properties
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellDetailLabel: UILabel!
    
    // MARK: Cell Initialization
    
    var sparkRoom: SparkRoom? {
        didSet {
            if sparkRoom != nil {
                /* set text labels */
                let title = sparkRoom?.title
                self.cellTitleLabel.text = title

                let detail = sparkRoom?.latestMsg
                if detail != "" {
                    self.cellDetailLabel.text = detail
                } else {
                    self.cellDetailLabel.text = "Your provider session is ready."
                }
                
                /* set avatar img */
                self.avatarImageView.image = UIImage(named: "messages")
//                let avatarURL = sparkRoom?.providerAvatarURL
//                if let url = NSURL(string: avatarURL!) {
//                    if let data = NSData(contentsOfURL: url) {
//                        self.avatarImageView.image = UIImage(data: data)?.rounded
//                    }
//                }
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
}
