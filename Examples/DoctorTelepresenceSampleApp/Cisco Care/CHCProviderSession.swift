//
//  CHCProviderSession.swift
//  Cisco Care
//
//  Created by mbarrass on 8/8/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCProviderSession {
    
    // MARK: Properties
    
    /* general infomation */
    var bio:      String?
    var name:     String?
    var type:     String?
    var email:    String?
    var gender:   String?
    var avatar:   String?
    var location: String?
    
    /* experience info */
    var years:     Double?
    var education: String?
    var languages: String?
    
    /* ratings */
    var stars:   Double?
    var reviews: [String]?
    
    /* spark info */
    var status:  String?
    var sparkID: String?
    
    /* list of patient IDs */
    var patients: [String]?
    
    // MARK: Initialization
    
    init(bio: String, name: String, type: String, email: String, gender: String, status: String, avatar: String, location: String, stars: Double, years: Double, education: String, languages: String) {
        self.bio        = bio
        self.name       = name
        self.type       = type
        self.email      = email
        self.gender     = gender
        self.status     = status
        self.avatar     = avatar
        self.location   = location
        self.stars      = stars
        self.years      = years
        self.education  = education
        self.languages  = languages
    }
}
