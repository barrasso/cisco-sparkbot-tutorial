//
//  CHCPageViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 7/22/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit

class CHCPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    // MARK: Outlets & Properties
    
    var pageTitleArray: NSArray = NSArray()

    // MARK: View Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Setup page data source delegate */
        pageTitleArray = ["Welcome", "Telehealth", "Get Started"]
        self.dataSource = self
        
        /* Setup page content view controllers */
        self.setViewControllers([getViewControllerAtIndex(0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Utility Functions
    
    func getViewControllerAtIndex(index: NSInteger) -> CHCPageContentViewController {
        
        /* Create a new view controller and pass suitable data */
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! CHCPageContentViewController
        pageContentViewController.pageTitle = "\(pageTitleArray[index])"
        pageContentViewController.pageIndex = index
        
        return pageContentViewController
    }
    
    // MARK: Page View Controller Delegate
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        /* Init page content view controller and get the index */
        let pageContent: CHCPageContentViewController = viewController as! CHCPageContentViewController
        var index = pageContent.pageIndex
        
        if ((index == 0) || (index == NSNotFound)) { return nil }
        index -= 1; /* Decrement index and return previous page content */
        return getViewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        /* Init page content view controller and get the index */
        let pageContent: CHCPageContentViewController = viewController as! CHCPageContentViewController
        var index = pageContent.pageIndex
        
        if (index == NSNotFound) { return nil }
        index += 1; /* Increment index and return next page content */
        if (index == pageTitleArray.count) { return nil }

        return getViewControllerAtIndex(index)
    }
}
