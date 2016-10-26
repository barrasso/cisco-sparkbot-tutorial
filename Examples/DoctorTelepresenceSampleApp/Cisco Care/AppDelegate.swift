//
//  AppDelegate.swift
//  Cisco Care
//
//  Created by mbarrass on 7/22/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit
import KeychainSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let keychain = KeychainSwift()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    // MARK: App Initialization
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        /* Override point for customization after application launch */
        
        /* Global Navigation bar style */
        UINavigationBar.appearance().tintColor = UIColor.colorFromHex(0xFFFFFF)
        UINavigationBar.appearance().barTintColor = UIColor.colorFromHex(0x2196F3)
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Futura", size: 18)!, NSForegroundColorAttributeName: UIColor.colorFromHex(0xFFFFFF)]

        /* Check for valid access token */
        if (keychain.get("sparkAccessToken") != nil) && (keychain.get("sparkAccessToken") != "") {
            if let accessDate: NSDate = defaults.valueForKey("accessExpirationDate") as? NSDate {
                let currentDate = NSDate()
                /* check if currentDate is past access token expiration date */
                if (currentDate.compare(accessDate) == .OrderedDescending) {
                    if let refreshDate: NSDate = defaults.valueForKey("refreshExpirationDate") as? NSDate {
                        /* check if current date is past refresh token expiration date */
                        if (currentDate.compare(refreshDate) == .OrderedDescending) {
                            /* No valid refresh token found */
                            defaults.setBool(false, forKey: "autoLoginEnabled")
                        } else {
                            /* Peform refresh on tokens */
                            CHCSparkHandler.refreshAuthTokens({ (success, error) in
                                if !success {
                                    print("Error while refreshing token: \(error)")
                                    self.defaults.setBool(false, forKey: "autoLoginEnabled")
                                } else {
                                    /* Successfully refreshed user auth session */
                                    let currentCalendar = NSCalendar.currentCalendar()
                                    let accessExpirationDate = currentCalendar.dateByAddingUnit(.Day, value: 14, toDate: currentDate, options: [])
                                    let refreshExpirationDate = currentCalendar.dateByAddingUnit(.Day, value: 90, toDate: currentDate, options: [])
                                    self.defaults.setObject(accessExpirationDate, forKey: "accessExpirationDate")
                                    self.defaults.setObject(refreshExpirationDate, forKey: "refreshExpirationDate")
                                    self.defaults.setBool(true, forKey: "autoLoginEnabled")
                                    self.performAuthenticatedLogin()
                                }
                            })
                        }
                    } else {
                        /* Refresh expiration date not set */
                        defaults.setBool(false, forKey: "autoLoginEnabled")
                    }
                } else {
                    /* Access token is still valid */
                    defaults.setBool(true, forKey: "autoLoginEnabled")
                    performAuthenticatedLogin()
                }
            } else {
                /* Access expiration date not set */
                defaults.setBool(false, forKey: "autoLoginEnabled")
            }
        } else {
            /* No valid access token found */
            defaults.setBool(false, forKey: "autoLoginEnabled")
        }
        return true
    }
    
    // MARK: Authentication Helper Functions
    
    func performAuthenticatedLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewControllerWithIdentifier("MainTabBarController") as! CHCMainTabBarController
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: Application State Functions

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: Safari URL Callbacks
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        if (options["UIApplicationOpenURLOptionsSourceApplicationKey"] as? String == "com.apple.SafariViewService") {
            NSNotificationCenter.defaultCenter().postNotificationName("kCloseSafariViewControllerNotification", object: url)
        }
        return true
    }
}

