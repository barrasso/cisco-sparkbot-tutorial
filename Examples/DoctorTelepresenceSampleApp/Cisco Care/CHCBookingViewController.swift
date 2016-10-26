//
//  CHCBookingViewController.swift
//  Cisco Care
//
//  Created by mbarrass on 8/15/16.
//  Copyright © 2016 cisco. All rights reserved.
//

import UIKit
import SwiftForms

class CHCBookingViewController: FormViewController {
    
    // MARK: Outlets & Properties
    
    /* provider */
    var currentProvider: CHCProviderHandler?
    
    struct Static {
        static let nameTag = "name"
        static let lastNameTag = "lastName"
        static let emailTag = "email"
        static let phoneTag = "phone"
        static let enabled = "enabled"
        static let check = "check"
        static let categories = "categories"
        static let button = "button"
        static let textView = "textview"
    }
    
    /* booking form descriptor */
    var bookingForm = FormDescriptor()
    
    // MARK: View Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadForm()
        self.navigationItem.title = "Your Visit"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(CHCBookingViewController.submit(_:)))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    func submit(_: UIBarButtonItem!) {
        
        let message = self.form.formValues().description
        print(message)
//
//        let alertController = UIAlertController(title: "Form output", message: message, preferredStyle: .Alert)
//        
//        let cancel = UIAlertAction(title: "OK", style: .Cancel) { (action) in
//        }
//        
//        alertController.addAction(cancel)
//        
//        self.presentViewController(alertController, animated: true, completion: nil)
        
        
        self.performSegueWithIdentifier("showMapView", sender: nil)
    }
    
    // MARK: Private Interface Functions
    
    private func loadForm() {
        
        bookingForm.title = "Booking Details"
        
        let section1 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        var row = FormRowDescriptor(tag: Static.nameTag, type: .Name, title: "First Name")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. John", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.emailTag, type: .Email, title: "Email")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. john@mail.com", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.phoneTag, type: .Phone, title: "Phone")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. 4082228888", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.rows.append(row)
        
        let section2 = FormSectionDescriptor(headerTitle: "Who is this visit for?", footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.check, type: .BooleanCheck, title: "Myself")
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.check, type: .BooleanCheck, title: "My Child")
        section2.rows.append(row)
        
        let section3 = FormSectionDescriptor(headerTitle: "What is the purpose of this visit?", footerTitle: nil)
        row = FormRowDescriptor(tag: Static.categories, type: .MultipleSelector, title: "Reasons")
        //row.configuration.cell.appearance = ["titleLabel.numberOfLines":3, "titleLabel.lineBreakMode":NSLineBreakMode.ByWordWrapping.rawValue]
        row.configuration.selection.options = [0, 1, 2, 3, 4]
        row.configuration.selection.allowsMultipleSelection = true
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? Int else { return "" }
            switch option {
            case 0:
                return "Fever"
            case 1:
                return "Headache"
            case 2:
                return "Coughing"
            case 3:
                return "Cold/Flu"
            case 4:
                return "Stomachache"
            default:
                return ""
            }
        }
        section3.rows.append(row)
        
//        let section4 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
//        
//        row = FormRowDescriptor(tag: Static.button, type: .Button, title: "Next")
//        row.configuration.cell.appearance = ["titleLabel.textColor":UIColor.colorFromHex(0x2196F3), "titleLabel.font":UIFont(name: "Futura", size: 18.0)!]
//        row.configuration.button.didSelectClosure = { _ in
//            self.view.endEditing(true)
//            self.submit(nil)
//        }
//        section4.rows.append(row)
        
        bookingForm.sections = [section1, section2, section3]
        self.form = bookingForm
    }
    
    // MARK: Form TableView Delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }

    // MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /* pass data from tableview to map vc */
        if let destination = segue.destinationViewController as? CHCMapViewController {
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
