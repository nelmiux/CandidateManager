//
//  AddCandidateViewController.swift
//
//  Created by Nelma Perera.
//  Copyright © 2016 Nelma Perera. All rights reserved.
//

import UIKit
import CoreData

class AddCandidateViewController: UIViewController, UITextFieldDelegate, DataModelProtocol {
    
    var candidates = [NSManagedObject]()
    
    var mainController: CandidateManagerViewController? = nil
    
    var pParty = "Democrat"

    @IBOutlet weak var fNameText: UITextField!
    
    @IBOutlet weak var lNameText: UITextField!
    
    @IBOutlet weak var stateText: UITextField!
    
    @IBOutlet weak var politicalPartySegmented: UISegmentedControl!
    
    @IBAction func saveButton(sender: UIButton) {
        if politicalPartySegmented.selectedSegmentIndex == 1 {
            pParty = "Republican"
        }
        
        self.mainController?.addCandidate(self)
        
        self.msgLabel.hidden = false
        
        if self.fNameText.text! != "" && self.lNameText.text! != "" && self.stateText.text! != "" {
        
            self.fNameText.text! = ""
        
            self.lNameText.text! = ""
        
            self.stateText.text! = ""
            
            politicalPartySegmented.selectedSegmentIndex = 0
            
            pParty = "Democrat"
        }
    }
    
    @IBOutlet weak var msgLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fNameText.delegate = self
        
        self.lNameText.delegate = self
        
        self.stateText.delegate = self
        
        self.msgLabel.hidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // A responder is an object that can respond to events and handle them.
        //
        // Resigning first responder here means this text field will no longer be the first
        // UI element to receive an event from this apps UI - you can think of it as giving
        // up input 'focus'.
        self.fNameText.resignFirstResponder()
        
        self.lNameText.resignFirstResponder()
        
        self.stateText.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.msgLabel.hidden = true
        self.view.endEditing(true)
    }

    func notify(message:String) {
        
        self.msgLabel.text = message
        
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            
            let alertController = UIAlertController(title: "Add Candidate", message: message, preferredStyle: .Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(alertController, animated: true, completion: nil)
            }
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
