//
//  AddVotePopoverViewController.swift
//
//  Created by Nelma Perera.
//  Copyright © 2016 Nelma Perera. All rights reserved.
//

import UIKit
import CoreData

class ShowVotesPopoverController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var data = [NSManagedObject]()
    
    var showViewController:ShowVotesTableView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentPopover(sourceController sourceController:UIViewController, sourceView:UIView, sourceRect:CGRect) {
        
        // Create the view controller we want to display as the popup.
        self.showViewController = ShowVotesTableView(title: "Show Votes", preferredContentSize: CGSize(width: 300, height: 180))
        
        // Cause the views to be created in this view controller. Gets them added to the view hierarchy.
        self.showViewController?.view
        self.showViewController?.tableView.layoutIfNeeded()
        
        self.showViewController?.candidates = data
        
        // Set attributes for the popover controller.
        // Notice we're get an existing object from the view controller we want to popup!
        let popoverShowViewController = self.showViewController!.popoverPresentationController
        popoverShowViewController?.permittedArrowDirections = .Up
        popoverShowViewController?.delegate = self
        popoverShowViewController?.sourceView = sourceView
        popoverShowViewController?.sourceRect = sourceRect
        
        // Show the popup.
        // Notice we are presenting form a view controller passed in. We need to present from a view controller
        // that has views that are already in the view hierarchy.
        sourceController.presentViewController(self.showViewController!, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Indicate we want the same presentation behavior on both iPhone and iPad.
        return UIModalPresentationStyle.None
    }
    
}