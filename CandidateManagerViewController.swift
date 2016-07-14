//
//  ViewController.swift
//
//  Created by Nelma Perera.
//  Copyright © 2016 Nelma Perera. All rights reserved.
//

import UIKit
import CoreData

class CandidateManagerViewController: UIViewController, UITableViewDelegate, UIPopoverPresentationControllerDelegate {
    
    var delegate: DataModelProtocol?
    
    var candidates = [NSManagedObject]()
    
    @IBOutlet weak var addVoteButton: UIButton!
    
    @IBOutlet weak var showVoteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following to remove all saved core data
        //self.deleteAllData("Candidate")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName:"Candidate")
        
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            candidates = fetchedResults!
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            candidates = results
        } else {
            print("Could not fetch")
        }
    }
    
    @IBAction func addVoteActionButton(sender: AnyObject) {
        
        // Instantiate our popover class and call it's present method.
        
        let popOverController = AddVotesPopoverController()
        
        popOverController.mainController = self
        
        popOverController.candidates = candidates
        
        popOverController.presentPopover(sourceController: self, sourceView: self.addVoteButton, sourceRect: self.addVoteButton.bounds)
        
    }
    
    @IBAction func showVoteActionButton(sender: AnyObject) {
        // Instantiate our popover class and call it's present method.
        
        let popOverController = ShowVotesPopoverController()
        
        popOverController.data = candidates
        
        popOverController.presentPopover(sourceController: self, sourceView: self.showVoteButton, sourceRect: self.showVoteButton.bounds)
    }
    
    func addCandidate(sender: AddCandidateViewController) {
        
        self.delegate = sender
        
        let firstName = sender.fNameText.text!
        let lastName = sender.lNameText.text!
        let politicalParty = sender.pParty
        let state = sender.stateText.text!
        let votes = 0
        
        if firstName != "" && lastName != "" && state != "" {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            // Create the entity we want to save
            let entity =  NSEntityDescription.entityForName("Candidate", inManagedObjectContext: managedContext)
            
            let candidate = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
            
            // Set the attribute values
            candidate.setValue(firstName, forKey: "firstName")
            candidate.setValue(lastName, forKey: "lastName")
            candidate.setValue(politicalParty, forKey: "politicalParty")
            candidate.setValue(state, forKey: "state")
            candidate.setValue(votes, forKey: "votes")
        
            // Commit the changes.
            do {
                try managedContext.save()
            } catch {
                // what to do if an error occurs?
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        
            // Add the new entity to our array of managed objects
            candidates.append(candidate)
            
            delegate!.notify("Data has been saved")
        } else {
        
            delegate!.notify("Blank flieds are not allowed\nData has NOT been saved")
        }
        
    }
    
    func updateVoteCount(sender: AddVotesTableView) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let candidate = candidates[sender.index]
            
        // Set the attribute values
        var votes = candidate.valueForKey("votes") as? Int
            
            (votes!) += 1
            
            candidate.setValue(votes, forKey: "votes")
            
            // Commit the changes.
            do {
                try managedContext.save()
                
                self.delegate = sender
                
                delegate!.notify("Data has been saved")
            } catch {
                // what to do if an error occurs?
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = segue.destinationViewController
        
        if segue.identifier == "showCandidatesSegue" {
        
            let dest = destination as! ShowCandidatesTableViewController
        
            dest.candidates = candidates
            
        } else {
            
            let dest = destination as! AddCandidateViewController
        
            dest.mainController = self
        }
    }
    
    func deleteAllData(entity: String) {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let coord = appDel.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
}

