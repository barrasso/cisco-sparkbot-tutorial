//
//  UIColor+Extension.swift
//  Cisco Care
//
//  Created by mbarrass on 7/22/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: Utility Functions
    
    static func colorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
