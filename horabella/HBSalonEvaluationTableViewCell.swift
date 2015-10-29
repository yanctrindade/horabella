//
//  HBSalonEvaluationTableViewCell.swift
//  horabella
//
//  Created by Erick Leal on 28/10/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBSalonEvaluationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var evaluationLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
