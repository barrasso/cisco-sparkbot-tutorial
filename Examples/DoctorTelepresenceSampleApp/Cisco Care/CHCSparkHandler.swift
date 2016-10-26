//
//  CHCSparkHandler.swift
//  Cisco Care
//
//  Created by mbarrass on 8/1/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit
import KeychainSwift

struct SparkUser {
    var sparkID = ""
    var avatarURL = ""
    var displayName = ""
    var emails = [String]()
}

struct SparkRoom {
    var type = ""
    var title = ""
    var roomID = ""
    var latestMsg = ""
    var createdAt = ""
    var patientName = ""
    var patientObjID = ""
    var patientSparkID = ""
    var providerName = ""
    var providerObjID = ""
    var providerSparkID = ""
    var providerAvatarURL = ""
    init(type: String, title: String, roomID: String, providerName: String, providerAvatarURL: String, creatorID: String) {
        self.type = type
        self.title = title
        self.roomID = roomID
        self.providerName = providerName
        self.providerAvatarURL = providerAvatarURL
        self.patientSparkID = creatorID
    }
}

class CHCSparkHandler {
    
    // MARK: Token Handling
    
    class func refreshAuthTokens(completion: (Bool, NSError?) -> Void) {
        /* Init request parameters */
        let grantType = "refresh_token"
        let clientID = "Cb34286d6295ed6510eec9fd9d67fc885fe903bde2148b54ea1c56cf661f4ec56"
        let clientSecret = "4c8812d43152b567fae7440c6c4884736e6631648c66524b33c0843445637af9"
        let refreshToken = KeychainSwift().get("sparkRefreshToken")!
        
        /* Create refresh request */
        let url = "https://api.ciscospark.com/v1/access_token?&grant_type=\(grantType)&client_id=\(clientID)&client_secret=\(clientSecret)&refresh_token=\(refreshToken)"
        let requestURL = NSURL(string: url)
        let request = NSMutableURLRequest(URL: requestURL!)
        request.HTTPMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        /* Initialize request */
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            guard data != nil else {
                print("no data found: \(error)")
                completion(false, error!)
                return
            }
            do { /* deserialize data into JSON dictionary object */
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? NSDictionary {
                    if let access_token = json["access_token"] as? String {
                        /* success: got new access token */
                        KeychainSwift().set(access_token, forKey: "sparkAccessToken")
                        completion(true, nil)
                    } else {
                        let jsonStr = String(data: data!, encoding: NSUTF8StringEncoding)
                        completion(false, NSError(domain: jsonStr!, code: 0, userInfo: nil))
                    }
                    return
                } else {
                    let jsonStr = String(data: data!, encoding: NSUTF8StringEncoding)
                    completion(false, NSError(domain: jsonStr!, code: 0, userInfo: nil))
                    return
                }
            } catch let parseError {
                print("Parse error: \(parseError)")
                let jsonStr = String(data: data!, encoding: NSUTF8StringEncoding)
                completion(false, NSError(domain: jsonStr!, code: 0, userInfo: nil))
                return
            }
        }
        task.resume()
    }
    
    // MARK: People Handling
    
    class func getPersonalDetails(completion: (SparkUser?, NSError?) -> Void) {
        /* Create request */
        let url = "https://api.ciscospark.com/v1/people/me"
        let requestURL = NSURL(string: url)
        let request = NSMutableURLRequest(URL: requestURL!)
        request.HTTPMethod = "GET"
        
        /* Builder headers */
        let accessToken = KeychainSwift().get("sparkAccessToken")!
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        /* Initialize request */
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            guard data != nil else {
                completion(nil, error!)
                return
            }
            do { /* deserialize data into JSON dictionary object */
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? NSDictionary {
                    /* create SparkUser and pass struct to completion handler */
                    let id = json["id"] as! String
                    let emails = json["emails"] as! [String]
                    let displayName = json["displayName"] as! String
                    if let avatarURL = json["avatar"] as? String {
                        let user = SparkUser(sparkID: id, avatarURL: avatarURL, displayName: displayName, emails: emails)
                        completion(user, nil)
                    } else {
                        let user = SparkUser(sparkID: id, avatarURL: "", displayName: displayName, emails: emails)
                        completion(user, nil)
                    }
                    return
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
    
    // MARK: Room Handling
    
    class func listAllRoomSessions(completion: ([SparkRoom]?, NSError?) -> Void) {
        /* Create request */
        let url = "https://api.ciscospark.com/v1/rooms"
        let requestURL = NSURL(string: url)
        let request = NSMutableURLRequest(URL: requestURL!)
        request.HTTPMethod = "GET"
        
        /* Builder headers */
        let accessToken = KeychainSwift().get("sparkAccessToken")!
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        /* Initialize request */
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            guard data != nil else {
                completion(nil, error!)
                return
            }
            do { /* deserialize data into JSON dictionary object */
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? NSDictionary {
                    if let rooms = json["items"] as? NSArray {
                        /* success: got rooms list */
                        var newArray = [SparkRoom]()
                        let defaults = NSUserDefaults.standardUserDefaults()
                        if let roomArray = defaults.arrayForKey("SparkRoomArray") {
                            for id in roomArray {
                                for room in rooms {
                                    if room.containsObject(id) {
                                        let roomID = room["id"] as! String
                                        let roomType = room["type"] as! String
                                        let roomTitle = room["title"] as! String
                                        let creatorID = room["creatorId"] as! String
                                        let newRoom = SparkRoom(type: roomType, title: roomTitle, roomID: roomID, providerName: "", providerAvatarURL: "", creatorID: creatorID)
                                        newArray.append(newRoom)
                                    }
                                }
                            }
                        }
                        completion(newArray, nil)
                    } else {
                        let jsonStr = String(data: data!, encoding: NSUTF8StringEncoding)
                        completion(nil, NSError(domain: jsonStr!, code: 0, userInfo: nil))
                    }
                    return
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
    
    class func createRoomSession(providerName: String, providerAvatarURL: String, completion: (SparkRoom?, NSError?) -> Void) {
        
        /* Init request parameters */
        let roomTitle = "CHC Session - \(providerName)"
        
        /* Create request */
        let url = "https://api.ciscospark.com/v1/rooms"
        let requestURL = NSURL(string: url)
        let request = NSMutableURLRequest(URL: requestURL!)
        request.HTTPMethod = "POST"
        
        /* build headers */
        let accessToken = KeychainSwift().get("sparkAccessToken")!
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        /* build request body */
        let params = [
            "title":roomTitle
        ]
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        
        /* Initialize request */
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            guard data != nil else {
                print("no data found: \(error)")
                completion(nil, error!)
                return
            }
            do { /* deserialize data into JSON dictionary object */
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? NSDictionary {
                    if let roomID = json["id"] as? String {
                        /* success: got new room */
                        let roomType = json["type"] as! String
                        let roomTitle = json["title"] as! String
                        let creatorID = json["creatorId"] as! String
                        let newRoom = SparkRoom(type: roomType, title: roomTitle, roomID: roomID, providerName: providerName, providerAvatarURL: providerAvatarURL, creatorID: creatorID)
                        completion(newRoom, nil)
                    } else {
                        let jsonStr = String(data: data!, encoding: NSUTF8StringEncoding)
                        completion(nil, NSError(domain: jsonStr!, code: 0, userInfo: nil))
                    }
                    return
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
    
    // MARK: Message Handling
    
    class func getLatestMessageForRoom(id: String, completion: ([String:AnyObject]?, NSError?) -> Void) {
        /* Init request parameters */
        let max = 1
        let roomId = id
        
        /* Create request */
        let url = "https://api.ciscospark.com/v1/messages?roomId=\(roomId)&max=\(max)"
        let requestURL = NSURL(string: url)
        let request = NSMutableURLRequest(URL: requestURL!)
        request.HTTPMethod = "GET"
        
        /* build headers */
        let accessToken = KeychainSwift().get("sparkAccessToken")!
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        /* Initialize request */
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            guard data != nil else {
                print("no data found: \(error)")
                completion(nil, error!)
                return
            }
            do { /* deserialize data into JSON dictionary object */
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? NSDictionary {
                    if let items = json["items"] as? NSArray {
                        /* success: got latest message details */
                        if items.count > 0 {
                            if let details = items[0] as? [String:AnyObject] {
                                completion(details, nil)
                            } else {
                                print("Could not get latest message data: \(items)")
                            }
                        }
                    } else {
                        let jsonStr = String(data: data!, encoding: NSUTF8StringEncoding)
                        completion(nil, NSError(domain: jsonStr!, code: 0, userInfo: nil))
                    }
                    return
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
