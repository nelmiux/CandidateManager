//
//  CandidateDetailViewController.swift
//
//  Created by Nelma Perera.
//  Copyright © 2016 Nelma Perera. All rights reserved.
//

import UIKit

class CandidateDetailViewController: UIViewController {
    
    var firstName: String = ""
    var lastName: String = ""
    var state: String = ""
    var politicalParty: String = ""
    var votes: Int = 0
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var politicalPartyLabel: UILabel!
    
    @IBOutlet weak var votesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameLabel.text = firstName
        
        lastNameLabel.text = lastName
        
        stateLabel.text = state
        
        politicalPartyLabel.text = politicalParty
        
        votesLabel.text = String(votes)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
