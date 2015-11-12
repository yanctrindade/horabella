//
//  HBServiceTableViewCell.swift
//  horabella
//
//  Created by Erick Leal on 12/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBServiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
