//
//  AddVoteTableViewController.swift
//
//  Created by Nelma Perera.
//  Copyright © 2016 Nelma Perera. All rights reserved.
//

import UIKit
import CoreData

class ShowVotesTableView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var candidates = [NSManagedObject]()
    
    let cellId:String = "CellId"
    
    var tableView:UITableView = UITableView()
    
    convenience init(title:String, preferredContentSize:CGSize) {
        self.init()
        
        // Set some view controller attributes
        self.preferredContentSize = preferredContentSize
        self.title = title
        
        self.modalPresentationStyle = UIModalPresentationStyle.Popover
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false;
        
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellId, forIndexPath: indexPath)
        
        let row = indexPath.row
        
        let candidate = candidates[row]
        
        let fname = candidate.valueForKey("firstName") as? String
        let lname = candidate.valueForKey("lastName") as? String
        let votes = candidate.valueForKey("votes") as? Int
        
        if fname != nil {
            cell.textLabel?.text = fname! + " " + lname! + "  Votes: " + String(votes!)
        }
        
        return cell
    }
}
