//
//  HBDealsTableViewCell.swift
//  horabella
//
//  Created by Yan Correa Trindade on 10/29/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBDealsTableViewCell: UITableViewCell {

    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
