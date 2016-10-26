//
//  CHCMainTabBarController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/1/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit
import FontAwesome_swift

class CHCMainTabBarController: UITabBarController {
    
    /* Tab Bar Icons */
    let tabBarIcon0 = UIImage.fontAwesomeIconWithName(.UserMd, textColor: UIColor.colorFromHex(0x333333), size: CGSizeMake(36, 36))
    let tabBarIcon1 = UIImage.fontAwesomeIconWithName(.Heartbeat, textColor: UIColor.colorFromHex(0x333333), size: CGSizeMake(36, 36))
    let tabBarIcon2 = UIImage.fontAwesomeIconWithName(.Comments, textColor: UIColor.colorFromHex(0x333333), size: CGSizeMake(36, 36))
    let tabBarIcon3 = UIImage.fontAwesomeIconWithName(.Calendar, textColor: UIColor.colorFromHex(0x333333), size: CGSizeMake(36, 36))
    let tabBarIcon4 = UIImage.fontAwesomeIconWithName(.Tasks, textColor: UIColor.colorFromHex(0x333333), size: CGSizeMake(36, 36))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.colorFromHex(0x2196F3)
        
        /* Setup tab bar images */
        for item in self.tabBar.items! {
            switch (item.title!) {
            case "Providers":
                item.image = tabBarIcon0
                break
            case "My Health":
                item.image = tabBarIcon1
                break
            case "Messages":
                item.image = tabBarIcon2
                break
            case "Appointments":
                item.image = tabBarIcon3
                break
            case "Account":
                item.image = tabBarIcon4
                break
            default:
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
