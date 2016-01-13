//
//  EntryPointViewController.swift
//  Desi
//
//  Created by Matthew Flickner on 7/20/15.
//  Copyright (c) 2015 Desi. All rights reserved.
//

import UIKit
import Parse

class EntryPointViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("view loaded")
    }

    
    override func viewDidAppear(animated: Bool) {
        go()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func go(){
        let currentUser = DesiUser.currentUser()
        print("got here")
        if currentUser != nil {
            // Do stuff with the user
            self.performSegueWithIdentifier("openToGroupsSegue", sender: nil)
            print("go to groups")
        } else {
            // Show the signup or login screen
            self.performSegueWithIdentifier("openToLoginSegue", sender: nil)
            print("go to login")
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "openToGroupsSegue") {
            let nav = segue.destinationViewController as! UINavigationController
            let homeView = nav.topViewController as! DesiHomeViewController
            let userQuery = DesiUser.query()
            userQuery!.includeKey("friendList")
            userQuery!.getObjectInBackgroundWithId(DesiUser.currentUser()!.objectId!)
            
            let queryLocal = DesiUserGroup.query()
            queryLocal!.whereKey("username", equalTo: DesiUser.currentUser()!.username!)
            queryLocal!.includeKey("group.theDesi")
            queryLocal!.fromLocalDatastore()
            queryLocal!.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                   // dispatch_async(dispatch_get_main_queue()) {
                        // The find succeeded.
                        print("Successfully retrieved \(objects!.count) scores. Swag.")
                        // Do something with the found objects
                        if let objects = objects as? [PFObject] {
                            let userGroups = objects as? [DesiUserGroup]
                            homeView.myUserGroups = userGroups
                            
                            //homeView.tableView.reloadData()
                            
                        }
                    //}
                    
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
            
            let queryNet = DesiUserGroup.query()
            queryNet!.whereKey("username", equalTo: DesiUser.currentUser()!.username!)
            queryNet!.includeKey("group.theDesi")
            queryNet!.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        // The find succeeded.
                        print("Successfully retrieved \(objects!.count) scores. Swag.")
                        // Do something with the found objects
                        if let objects = objects as? [PFObject] {
                            let userGroups = objects as? [DesiUserGroup]
                            homeView.myUserGroups = userGroups
                        
                            homeView.tableView.reloadData()
                        
                        }
                    }
                    
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
            
        }
        if (segue.identifier == "openToLoginSegue") {
            
        }
        
    }


}