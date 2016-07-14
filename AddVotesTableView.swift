//
//  AddVoteTableViewController.swift
//
//  Created by Nelma Perera.
//  Copyright © 2016 Nelma Perera. All rights reserved.
//

import UIKit
import CoreData

class AddVotesTableView: UIViewController, UITableViewDataSource, UITableViewDelegate, DataModelProtocol {
    
    var mainController: CandidateManagerViewController? = nil
    
    let cellId:String = "CellId"
    
    var candidates = [NSManagedObject]()
    
    var tableView:UITableView = UITableView()
    
    var index:Int = -1
    
    convenience init(title:String, preferredContentSize:CGSize) {
        self.init()
        
        // Set some view controller attributes
        self.preferredContentSize = preferredContentSize
        self.title = title
        
        self.modalPresentationStyle = UIModalPresentationStyle.Popover
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.frame         =   CGRectMake(0, 0, self.preferredContentSize.width, self.preferredContentSize.height);
        self.tableView.delegate      =   self
        self.tableView.dataSource    =   self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
        
        self.view.addSubview(self.tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.candidates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellId, forIndexPath: indexPath)
        
        if self.candidates.count > 0 {
            let candidate = self.candidates[row]
            
            let fname = candidate.valueForKey("firstName") as? String
            let lname = candidate.valueForKey("lastName") as? String
            
            if fname != nil {
                cell.textLabel?.text = fname! + " " + lname!
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        index = indexPath.row
        
        if index >= self.candidates.count {
            
            tableView.allowsSelection = false;
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            return
        }
        
        if index < self.candidates.count {
            
            self.mainController?.updateVoteCount(self)
            
        } else {
            
            tableView.allowsSelection = false;
            
        }
    }
    
    func notify(message:String) {
        
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            
            let alertController = AlertController(title: "Update Votes", message: message, preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                UIAlertAction in self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            alertController.addAction(okAction)

            dispatch_async(dispatch_get_main_queue()) {
                alertController.show()
            }
        }
    }
    
    private class AlertController: UIAlertController {
        
        private lazy var alertWindow: UIWindow = {
            let window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.rootViewController = ClearViewController()
            window.backgroundColor = UIColor.clearColor()
            return window
        }()
        
        func show(animated flag: Bool = true, completion: (() -> Void)? = nil) {
            if let rootViewController = alertWindow.rootViewController {
                alertWindow.makeKeyAndVisible()
                rootViewController.presentViewController(self, animated: flag, completion: completion)
            }
        }
        
        deinit {
            alertWindow.hidden = true
        }
    }

    private class ClearViewController: UIViewController {
        
        private override func preferredStatusBarStyle() -> UIStatusBarStyle {
            return UIApplication.sharedApplication().statusBarStyle
        }
        
        private override func prefersStatusBarHidden() -> Bool {
            return UIApplication.sharedApplication().statusBarHidden
        }
    }
    
    
}

