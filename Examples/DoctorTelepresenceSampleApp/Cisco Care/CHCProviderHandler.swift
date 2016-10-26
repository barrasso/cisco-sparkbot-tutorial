//
//  CHCProviderHandler.swift
//  Cisco Care
//
//  Created by mbarrass on 8/8/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCProviderHandler: CHCProviderSession {
    
    // MARK: Getters
    
    class func listAllProviders(completion: ([CHCProviderHandler]?, NSError?) -> Void) {
        /* create request */
        let url = "https://cisco-care.herokuapp.com/api/providers/list/all"
        let requestURL = NSURL(string: url)
        let request = NSMutableURLRequest(URL: requestURL!)
        request.HTTPMethod = "GET"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        /* initialize request */
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            guard data != nil else {
                completion(nil, error!)
                return
            }
            /* try to deserialize json response */
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? NSArray {
                    if json.count > 0 {
                        /* construct each provider and pass array to completion handler */
                        var providers = [CHCProviderHandler]()
                        for provider in json {
                            /* general info */
                            let avatar   = provider["avatar"] as! String
                            let gender   = provider["gender"] as! String
                            let status   = provider["status"] as! String
                            let type     = provider["type"] as! String
                            let email    = provider["email"] as! String
                            let name     = provider["name"] as! String
                            let location = provider["location"] as! String
                            let bio      = provider["bio"] as! String
                            
                            /* ratings info */
                            let ratings = provider["rating"] as! NSDictionary
                            let stars = ratings["stars"] as! Double
                            
                            /* experience info */
                            let experience = provider["experience"] as! NSDictionary
                            let years      = experience["years"] as! Double
                            let languages  = experience["languages"] as! String
                            let education  = experience["education"] as! String
                            
                            /* create new provider object */
                            let newProvider = CHCProviderHandler(bio: bio, name: name, type: type, email: email, gender: gender, status: status, avatar: avatar, location: location, stars: stars, years: years, education: education, languages: languages)
                            providers.append(newProvider)
                        }
                        completion(providers, nil)
                        return
                    } else {
                        let noProviderError = "Did not find any providers."
                        completion(nil, NSError(domain: noProviderError, code: 0, userInfo: nil))
                        return
                    }
                } else {
                    let jsonStr = String(data: data!, encoding: NSUTF8StringEncoding)
                    completion(nil, NSError(domain: jsonStr!, code: 0, userInfo: nil))
                    return
                }
            } catch let parseError {
                print("Parse error: \(parseError)")
                let jsonStr = String(data: data!, encoding: NSUTF8StringEncoding)
                completion(nil, NSError(domain: jsonStr!, code: 0, userInfo: nil))
                return
            }
        }
        task.resume()
    }
}
