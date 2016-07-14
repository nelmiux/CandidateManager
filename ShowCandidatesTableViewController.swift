//
//  ShowCandidatesTableViewController.swift
//
//  Created by Nelma Perera.
//  Copyright © 2016 Nelma Perera. All rights reserved.
//

import UIKit
import CoreData

class ShowCandidatesTableViewController: UITableViewController {
    
    var candidates = [NSManagedObject]()
    
    var path: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.candidates.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "candidateCell"
        
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        if candidates.count > 0 {
            let candidate = candidates[row]
        
            let fname = candidate.valueForKey("firstName") as? String
            let lname = candidate.valueForKey("lastName") as? String
            let pParty = candidate.valueForKey("politicalParty") as? String
        
            if fname != nil {
                (cell as! ShowCandidatesTableViewCell).candidateTitleLabel.text = fname! + " " + lname!
        
                (cell as! ShowCandidatesTableViewCell).candidateDetailLabel.text = pParty
            }
        }
        
        return cell
    }

    // MARK: - Navigation
    
    func tableView(tableView: UITableView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("collectionSegue", sender: self)
        path = indexPath.row
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        path = tableView.indexPathForSelectedRow!.row
        
        let dest = segue.destinationViewController as! CandidateDetailViewController
        
        if path > -1 && path < candidates.count {
            let candidate = candidates[path]
            
            let fname = candidate.valueForKey("firstName") as? String
            let lname = candidate.valueForKey("lastName") as? String
            let state = candidate.valueForKey("state") as? String
            let pParty = candidate.valueForKey("politicalParty") as? String
            let votes = candidate.valueForKey("votes") as? Int

            if fname != nil {
                dest.firstName = fname!
                dest.lastName = lname!
                dest.state = state!
                dest.politicalParty = pParty!
                dest.votes = votes!
            }
        }
    }
}
