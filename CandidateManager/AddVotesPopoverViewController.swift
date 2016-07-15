//
//  AddVotePopoverViewController.swift
//
//  Created by Nelma Perera.
//  Copyright © 2016 Nelma Perera. All rights reserved.
//

import UIKit
import CoreData

class AddVotesPopoverController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var mainController: CandidateManagerViewController? = nil
    
    var addViewController:AddVotesTableView? = nil
    
    var candidates = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentPopover(sourceController sourceController:UIViewController, sourceView:UIView, sourceRect:CGRect) {
        
        // Create the view controller we want to display as the popup.
        self.addViewController = AddVotesTableView(title: "Add Votes", preferredContentSize: CGSize(width: 300, height: 180))
        
        // Cause the views to be created in this view controller. Gets them added to the view hierarchy.
        self.addViewController?.view
        self.addViewController?.tableView.layoutIfNeeded()
        
        self.addViewController?.candidates = self.candidates
        
        self.addViewController?.mainController = self.mainController
        
        
        // Set attributes for the popover controller.
        // Notice we're get an existing object from the view controller we want to popup!
        let popoverAddViewController = self.addViewController!.popoverPresentationController
        popoverAddViewController?.permittedArrowDirections = .Up
        popoverAddViewController?.delegate = self
        popoverAddViewController?.sourceView = sourceView
        popoverAddViewController?.sourceRect = sourceRect
        
        // Show the popup.
        // Notice we are presenting form a view controller passed in. We need to present from a view controller
        // that has views that are already in the view hierarchy.
        sourceController.presentViewController(self.addViewController!, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Indicate we want the same presentation behavior on both iPhone and iPad.
        return UIModalPresentationStyle.None
    }
}