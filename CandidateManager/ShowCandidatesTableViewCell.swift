//
//  ShowCandidatesTableViewCell.swift
//
//  Created by Nelma Perera.
//  Copyright © 2016 Nelma Perera. All rights reserved.
//

import UIKit

class ShowCandidatesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var candidateTitleLabel: UILabel!
    
    @IBOutlet weak var candidateDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
