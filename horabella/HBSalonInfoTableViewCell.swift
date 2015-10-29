//
//  HBSalonInfoTableViewCell.swift
//  horabella
//
//  Created by Erick Leal on 29/10/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBSalonInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoType: UILabel!
    @IBOutlet weak var infoDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
