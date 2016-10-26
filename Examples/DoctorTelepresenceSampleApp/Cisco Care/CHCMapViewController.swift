//
//  CHCMapViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/15/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit
import MapKit

class CHCMapViewController: UIViewController {

    // MARK: Outlets & Properties
    
    /* provider */
    var currentProvider: CHCProviderHandler?
    
    /* location management */
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    /* activity loader */
    let indicatorContainer: UIView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    /* pharmacy management */
    @IBOutlet weak var selectedPharmacyLabel: UILabel!
    var requestItems: [MKMapItem] = [MKMapItem]()
    
    /* picker view */
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var skipButton: UIButton!
    
    /* screen constraints */
    let deviceHeight = UIScreen.mainScreen().bounds.height
    let deviceWidth  = UIScreen.mainScreen().bounds.width
    @IBOutlet weak var mapViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: View Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()

        /* setup nav bar */
        self.navigationItem.title = "Pharmacy Map"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(CHCMapViewController.submit(_:)))

        /* adjust constraints */
        mapViewHeightConstraint.constant = deviceHeight * 0.55
        
        /* setup location manager */
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    func submit(_: UIBarButtonItem!) {
        self.performSegueWithIdentifier("showCalendarView", sender: nil)
    }
    
    // MARK: Utility Functions
    
    func initiatePharmacySearchRequest() {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Pharmacy"
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler({(response,
            error) in
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                /* matches found */
                for item in response!.mapItems {
                    /* append each result to array and add annotation to map */
                    self.requestItems.append(item as MKMapItem)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.placemark.title
                    self.mapView.addAnnotation(annotation)
                }
                /* setup picker view related things */
                self.pickerView.dataSource = self
                self.pickerView.delegate = self
                
                self.pickerView.hidden = false
                self.skipButton.hidden = false
                self.selectedPharmacyLabel.hidden = false
                self.skipButton.enabled = true
                self.pickerView.userInteractionEnabled = true
            }
        })
    }
    
    func showActivityIndicator(uiView: UIView, title: String) {
        /* init container view */
        indicatorContainer.frame = uiView.frame
        indicatorContainer.center = uiView.center
        indicatorContainer.backgroundColor = UIColor.colorFromHex(0xFFFFFF, alpha: 0.3)
        
        /* add loading gradient view */
        let loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor.colorFromHex(0x333333, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        /* setup loading label */
        let loadingLabel: UILabel = UILabel()
        loadingLabel.textAlignment = .Center
        loadingLabel.frame = CGRectMake(0, 0, 80, 80)
        loadingLabel.center = CGPointMake(loadingView.frame.size.width * 0.50, loadingView.frame.size.height * 0.85)
        loadingLabel.textColor = UIColor.colorFromHex(0xECECEC)
        loadingLabel.font = UIFont(name: "Futura", size: 10.0)
        loadingLabel.text = title
        
        /* setup activity indicator */
        activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.center = CGPointMake(loadingView.frame.size.width / 2,
                                               loadingView.frame.size.height / 2);
        
        /* add sub views and start loading animation */
        loadingView.addSubview(activityIndicator)
        loadingView.addSubview(loadingLabel)
        indicatorContainer.addSubview(loadingView)
        uiView.addSubview(indicatorContainer)
        activityIndicator.startAnimating()
    }
    
    // MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? CHCCalendarSelectorViewController {
            // pass provider object
            if (self.currentProvider != nil) {
                destination.currentProvider = self.currentProvider
            }
            
            // init custom back button
            let backItem = UIBarButtonItem()
            backItem.title = " "
            destination.navigationItem.backBarButtonItem = backItem
        }
    }
}

// MARK: PickerView Delegate

extension CHCMapViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return requestItems.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            self.selectedPharmacyLabel.text = "Selected Location:\n\(requestItems[row].name!),\n\(requestItems[row].placemark.title!.componentsSeparatedByString(",")[0])"
        }
        return requestItems[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedPharmacyLabel.text = "Selected Location:\n\(requestItems[row].name!),\n\(requestItems[row].placemark.title!.componentsSeparatedByString(",")[0])"
    }
}

// MARK: Location Manager Delegate

extension CHCMapViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            // update map region span by current location
            let span = MKCoordinateSpanMake(0.07, 0.07)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            // end loading
            if self.activityIndicator.isAnimating() {
                self.activityIndicator.stopAnimating()
                self.indicatorContainer.hidden = true
            }
            if UIApplication.sharedApplication().isIgnoringInteractionEvents() {
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location error: \(error)")
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
}

// MARK: Map View Delegate

extension CHCMapViewController: MKMapViewDelegate {
    
    func mapViewWillStartLoadingMap(mapView: MKMapView) {
        showActivityIndicator(self.mapView, title: "Loading...")
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        self.initiatePharmacySearchRequest()

        if self.activityIndicator.isAnimating() {
            self.activityIndicator.stopAnimating()
            self.indicatorContainer.hidden = true
        }
        if UIApplication.sharedApplication().isIgnoringInteractionEvents() {
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }
    }
    
    func mapViewDidFailLoadingMap(mapView: MKMapView, withError error: NSError) {
        print("Map Error: \(error)")
        if self.activityIndicator.isAnimating() {
            self.activityIndicator.stopAnimating()
            self.indicatorContainer.hidden = true
        }
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
}